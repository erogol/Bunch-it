class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :token
  def index
    @title = "Home"
    session[:return_to] = request.fullpath
    @page = request.path
    puts "Welcome home page"
  end

  def token
  end
end
