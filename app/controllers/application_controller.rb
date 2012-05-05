class ApplicationController < ActionController::Base
  #session :session_key => '_bunchit_session_id'
  helper :all

  # include all helpers, all the time
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '8c3e099237e6366fd2f5366e9c430e79'
  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "passwor...*TRUNC*
  # filter_parameter_logging :password
  def get_country_code
    @geoip ||= GeoIP.new(Rails.root.join("lib/GeoIP.dat"))
    @country_location = @geoip.country(request.remote_ip)
    # returns an array, example => [“134.56.44.234”, “134.56.44.234”, 225, “US”, “USA”, “United States”, “NA”]
    @country_location.country_code2
  end

  def create_folder(name, description)
    current_user.folders.create(:folder_name=>name, :user_id=>current_user.id)
  end

  def delete_result(title)
    current_user.folders
  end

  def findNewestQuery
    userId = current_user.id
    if !current_user.queries.empty?
      queries = Query.find(:all, :conditions =>["user_id = :user_id",{:user_id=>userId}])
      queries.sort!{|b,c|c.updated_at<=>b.updated_at}
    return queries[0]
    end
    false
  end

  def commonQuery
    queries = Query.find(:all, :conditions =>["user_id = :user_id",{:user_id=>current_user.id}])
    queries.sort_by{|b|b.enter_count}
    queries[queries.size-1]
  end

  def after_sign_in_path_for(resource)
    session[:return_to]
  end
# Overwriting the sign_out redirect path method
#def after_sign_out_path_for()
# root_path
#end
end
