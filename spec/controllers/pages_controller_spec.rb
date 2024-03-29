require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end
  
  it "should have the right title" do
    get 'home'
    response.should have_selector("title",:content => "Erogol | Home")
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
  end
  
  it "should have the right title" do
    get 'contact'
    response.should have_selector("title",:content => "Erogol | Contact")
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end
  
  it "should have the right title" do
    get 'about'
    response.should have_selector("title",:content => "Erogol | About")
  end
  
  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
    end
  end
  
  it "should have the right title" do
    get 'help'
    response.should have_selector("title", :content=>"Erogol | sHelp")
  end
  
end
