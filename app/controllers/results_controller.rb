require 'carrot2'

class ResultsController < ApplicationController
  layout "_result"
  def result
    if user_signed_in?
      @user = current_user
    end
    session[:return_to] = request.fullpath#set the place to return, if user signed then return that page
    @counter = 0
    @json = nil;
    @clusterDocs  = nil;
    @cluster = params[:clus]
    @title = "results"
    @query = params[:query]
    carrot = Carrot2.new
    uri = "http://localhost:8080/dcs/rest"
    
    #insert query to DB
    insertQueryToDB(@query)
    
    puts "\n## Clustering data from a search engine...\n"
    @response = carrot.dcs_request(uri, {
       "dcs.source" => "etools",
       "query" => @query,
       "dcs.output.format" => "JSON",
       "dcs.clusters.only" => "false"
      })
     @json = @response
     @response = JSON.parse(@response)
     #@json = @response['clusters']
     #@json = JSON.generate(@json)
     if @response['clusters'].size == 0 
        flash[:notice] = "No cluster generated (Sufficient number of results)! "
        puts "No cluster could be generated! <Sufficient no. of result>!"  
     end
     carrot.dump(@response)
     if @cluster != nil
       @clusterDocs  = @response['clusters'][@cluster]['documents']
     end 
  end
  
  def insertQueryToDB(query)
    #if user is not signed, just insert the query to database
    if(!signed_in?)
      temp = Query.new(:query_string=>query, :enter_count=>0)
      temp.save
      return
    end 
    #if user signed
    #if query exist before for that user, increment its enter_count 
    if !Query.exists?(:query_string => query, :user_id=> current_user.id)
      current_user.queries.create(:query_string=>query, :enter_count=>0)
    else
      #if query is new insert the query to DB eith user's id
      query_temp = Query.find(:first, :conditions=>["user_id = :user_id and query_string = :query_string",{:user_id=>current_user.id, :query_string=> query}])
      new_enter_count = query_temp.enter_count
      new_enter_count += 1;
      query_temp.update_attribute('enter_count',new_enter_count)
    end
  end
end
