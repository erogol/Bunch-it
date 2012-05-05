# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    resource = build_resource({})
    respond_with resource
  end

  def create
    if verify_recaptcha
      build_resource
      if resource.save
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_in(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
          create_default_folder current_user
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        respond_with resource
      end
    else
      build_resource
      clean_up_passwords(resource)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
      render_with_scope :new
    end
  end

  def create_default_folder user
    if user.save
      user.folders.create(:folder_name=>"Default Folder", :user_id=>user.id)
    end
  end

  def update
    super
  end
end 