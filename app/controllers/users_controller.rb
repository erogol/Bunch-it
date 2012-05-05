class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => :show
  
  def index
    @title = current_user.user_name
    @haveQuery = false
    if @newest_query = findNewestQuery
      @common_query = commonQuery
      @haveQuery = true
    else
      @haveQuery = false
    end
  end
  
  def show
    @title = current_user.user_name
    @haveQuery = false
    if @newest_query = findNewestQuery
      @common_query = commonQuery
      @haveQuery = true
    else
      @haveQuery = false
    end
  end

  def new
    @title = 'Sign up'
  end

end
