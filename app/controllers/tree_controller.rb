require 'cgi'

class TreeController < ApplicationController
  def deleteFolder
    folder = params[:folder];
    #Folder.destroy_all "user_id ="+current_user.id.to_s+" and folder_name='"+folder+"'"
    folder_obj = Folder.find(:first, :conditions=>["folder_name = :folder_name and user_id = :user_id",{:folder_name=> folder, :user_id=>current_user.id.to_s}])
    folder_obj.delete
    puts "=>>>Folder "+folder+" deleted!"
    render :nothing => true
  end

  def createFolder
    folder = params[:folder]
    id = current_user.id;
    new_folder = Folder.new(:folder_name=>folder, :user_id=>id)
    if !Folder.exists?(:folder_name=>folder, :user_id=>id)
      new_folder.save
      render :nothing=>true
    else
      render :text=>"F"
    end  
  end

  def insertResult
    @result = Doc.new(:title => params[:title], :url=> params[:url], :snippet=>params[:snippet])
    folderName = params[:folder]
    if folderName == "null"
      folder = Folder.find(:first, :conditions=>["user_id = :user_id",{:user_id=>current_user.id}])
    else
      folder = Folder.find(:first, :conditions=>["folder_name = :folder_name and user_id = :user_id",{:folder_name=> folderName, :user_id=>current_user.id}])
    end
    @docy = folder.docs
    if nil == folder.docs.find_by_title(@result.title)
      folder.docs<<@result
      #insert_result(folderName, @result.title, @result.url)
      render :text=>folder.folder_name
    else
      #insert_result(folderName, @result.title, @result.url)
      render :text=>"F"
    end
  end

  def insert_result(folder, title, url)
    current_user.folders[:folder_name=>folder].docs.create(:title=> title, :url=> url)
  end
  
  def deleteResult
    title = params[:title]
    url = params[:url]
    url = CGI::unescapeHTML(url)
    title = CGI::unescapeHTML(title)
    doc = Doc.find(:first, :conditions=>["title = :title and url = :url",{:title=>title, :url=>url}])
    doc.delete
    puts "=>>>Result titled:"+title+" url:"+url+" deleted!"
    render :nothing=>true 
  end
end
