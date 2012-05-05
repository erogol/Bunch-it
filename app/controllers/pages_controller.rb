#require 'util'

class PagesController < ApplicationController
  def home
    @title = "Home"
    session[:return_to] = request.fullpath
    @page = request.path
    puts "Welcome home page"
  end

  def contact
    @user = current_user
    @title = "Contact"
    #session[:return_to] = request.fullpath
  end
  
  def about
    @user = current_user
    #session[:return_to] = request.fullpath
    @title = "About"
  end
  
  def help
    @user = current_user
    #session[:return_to] = request.fullpath
    @title = "Help"
  end 
  
   
  
end
