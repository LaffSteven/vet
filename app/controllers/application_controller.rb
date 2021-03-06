require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "moose do not have wings"
  end

  get "/" do
    erb :welcome
  end

  get "/welcome" do
    erb :welcome
  end


  helpers do

    def is_logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

  end


end
