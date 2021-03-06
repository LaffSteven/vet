class PetsController < ApplicationController

  # GET: /pets
  get "/pets" do
    # You can only see the index page if you are logged in
    if is_logged_in?
    @pets = Pet.all
    erb :"/pets/index.html"
    else
      # send you back to the welcome screen if you are not logged in
      redirect to "/welcome"
    end
  end

  # GET: /pets/new
  get "/pets/new" do
    if is_logged_in?
      erb :"/pets/new.html"
    else
      redirect to "/welcome"
    end
  end

  # POST: /pets
  post "/pets" do
    # user must be logged in to add a pet
    if !is_logged_in?
      redirect to "/login"
    end
    # check params validation
    if params[:name].empty? || params[:species].empty? || params[:breed].empty? || params[:age].empty?
      redirect to "pets/new"
      # else creates the new pet
    else
      params[:user_id] = current_user.id
      pet = Pet.create(params)
      redirect "/users/#{current_user.id}"
    end
  end

  # GET: /pets/5
  get "/pets/:id" do
    if find_and_set_pet && is_logged_in?
      if @pet.user_id == current_user.id
        erb :"/pets/show.html"
      else
        redirect to "/pets"
      end
    end
  end

  # GET: /pets/5/edit
  get "/pets/:id/edit" do
    if find_and_set_pet && is_logged_in?
      if @pet.user_id == current_user.id
        erb :"pets/edit.html"
      else
        redirect to "/pets"
      end
    end
  end

  # PATCH: /pets/5
  patch "/pets/:id" do
    find_and_set_pet
    if is_logged_in? && @pet.user_id == current_user.id
      @pet.update(:name => params[:name], :species => params[:species], :breed => params[:breed], :age => params[:age])
      redirect "/pets/#{@pet.id}"
    else
      redirect to "/users/#{current_user.id}"
    end
  end

  # DELETE: /pets/5/delete
  delete "/pets/:id" do
    find_and_set_pet
    if @pet.user_id == current_user.id
      @pet.destroy
      redirect to "/users/#{current_user.id}"
    else
      redirect to "/pets"
    end
  end

  private

  def find_and_set_pet
    @pet = Pet.find_by(:id => params[:id])
  end

end
