class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    @users = User.all
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/users/new" do
    # If there is an exisintg user session, warn current user they must log out first
    if is_logged_in?
      redirect to "/users/#{current_user.id}"
    # if no user is logged in, proceed to the new user form
    else
      erb :"/users/new.html"
    end
  end

  # POST: /users
  post "/users" do
    # Make sure that both username and password are not empty
    if params[:username].empty? || params[:password].empty?
      redirect to '/users/new'
    # Check the list of existing usernames, only allow unique usernames
    elsif user = User.find_by(:username => params[:username])
      redirect to '/users/new'
    # Check for unique email
    elsif user = User.find_by(:email => params[:email])
      redirect to '/users/new'
      # If username is unique and password is valid, post new user
      # Update the session to the new user's session and redirect to profile page
    else
      user = User.create(params)
      #binding.pry
      session[:user_id] = user.id
      redirect to "/users/#{user.id}"
    end
  end

  # GET: /users/5
  get "/users/:id" do
    find_and_set_user
    if @user.id == current_user.id
      @pets = Pet.all
      erb :"/users/show.html"
    else
      redirect to "/welcome"
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
      redirect to "/"
    end
  end


  # GET: /users/5/edit
  get "/users/:id/edit" do
    if is_logged_in?
      find_and_set_user
      erb :"/users/edit.html"
    else
      redirect to "/welcome"
    end
  end

  # PATCH: /users/5
  patch "/users/:id" do
    find_and_set_user
      if @user.authenticate(params[:password]) && !params[:username].empty?
        @user.update(:username => params[:username], :password => params[:password])
        redirect to "/users/#{@user.id}"
      end
        redirect to "/users/#{@user.id}/edit"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    find_and_set_user
    @user.destroy
    session.clear
    binding.pry
    redirect to "/welcome"
  end

##################################################
  private

  def find_and_set_user
    @user = User.find_by(:id => params[:id])
  end
##################################################

end
