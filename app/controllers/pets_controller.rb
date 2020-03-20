class PetsController < ApplicationController

  # GET: /pets
  get "/pets" do
    @pets = Pet.all
    erb :"/pets/index.html"
  end

  # GET: /pets/new
  get "/pets/new" do
    erb :"/pets/new.html"
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
      params[:owner_id] = current_user.id
      pet = Pet.create(params)
      binding.pry
      redirect "/pets/#{pet.id}"
    end
  end

  # GET: /pets/5
  get "/pets/:id" do
    if find_and_set_pet
      erb :"/pets/show.html"
    else
      redirect to "/"
    end
  end

  # GET: /pets/5/edit
  get "/pets/:id/edit" do
    find_and_set_pet
    erb :"pets/edit.html"
  end

  # PATCH: /pets/5
  patch "/pets/:id" do
    redirect "/pets/:id"
  end

  # DELETE: /pets/5/delete
  delete "/pets/:id/delete" do
    find_and_set_pet
    if @pet.owner_id == current_user.id
      @pet.destroy
    end
    redirect to "/users/#{current_user.id}"
  end

  private

  def find_and_set_pet
    @pet = Pet.find_by(:id => params[:id])
  end

end
