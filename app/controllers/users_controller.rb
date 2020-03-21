class UsersController < ApplicationController

  get "/users" do
    if is_logged_in?
      @users = User.all
      erb :"/users/index.html"
    else
      redirect to '/welcome'
    end
  end

  post "/users" do
    find_and_set_user
    binding.pry
    if @user
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    end
  end

  patch "/users/:id" do
    find_and_set_user
    if is_logged_in? && @user.id == current_user.id
      @user.update(:name => params[:name], :username => params[:username], :email => params[:email], :password => params[:password])
      redirect "/users/#{@user.id}"
    else
      redirect to "/users/#{current_user.id}"
    end
  end

  get "/signup" do
      if is_logged_in?
        redirect to "/users/#{current_user.id}"
      else
        erb :"/users/new.html"
      end
  end

  post "/signup" do
    if params[:username].empty? || params[:password].empty?
      redirect to '/welcome'
    elsif user = User.find_by(:username => params[:username])
      redirect to '/welcome'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to "/users/#{user.id}"
    end
  end

  get "/users/:id" do
    find_and_set_user
    if is_logged_in?
      @pets = Pet.all
      erb :"/users/show.html"
    else
      redirect to "/welcome"
    end
  end

  get "/users/:id/edit" do
    if is_logged_in?
      find_and_set_user
      erb :"/users/edit.html"
    else
      redirect to "/welcome"
    end
  end

  patch "/users/:id" do
    find_and_set_user
    if @user == current_user
      @user.update(:name => params[:name], :username => params[:username], :email => params[:email])
      #binding.pry
      redirect to "/users/#{@user.id}"
    else
      redirect to "/users/#{@user.id}/edit"
    end
  end

  get "/login" do
    if is_logged_in?
      redirect to "/users/#{current_user.id}"
    else
      erb :"/users/login.html"
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/users/#{user.id}"
    end
    redirect to "/login"
  end

  get "/logout" do
    if session[:user_id] != nil
      session.clear
      redirect to "/welcome"
    end
  end

  delete "/users/:id" do
    find_and_set_user
    @pets_to_delete = Pet.all
    @pets_to_delete.each do |pet|
      if pet.owner_id == @user.id
        pet.destroy
      end
    end
    @user.destroy
    session.clear
    redirect to "/welcome"
  end

##################################################
  private

  def find_and_set_user
    @user = User.find_by(:id => params[:id])
  end
##################################################

end
