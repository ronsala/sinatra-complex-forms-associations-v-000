class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create( params["owner"])
    else
      @owner = Owner.find_by_id(params["pet"]["owner_id"])
      @pet.owner = @owner
    end
    # @owner.save
    @pet.save
    # binding.pry #no hit
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    # binding.pry
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    # binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    # binding.pry
#     [1] pry(#<PetsController>)> @pet
# => #<Pet:0x00000005223760 id: 1, name: "Chewie Darling", owner_id: 1>
    # if !params["owner"]["name"].empty?
    if !pet.owner
      owner_id = @pet.owner_id
      @pet.owner = Owner.create(owner.id)
      # binding.pry #doesn't hit
    else
#       binding.pry
#       [1] pry(#<PetsController>)> params
# => {"pet"=>{"name"=>"Chewie Darling"},
#  "owner"=>{"name"=>""},
#  "captures"=>[],
#  "id"=>"1"}
      # @owner = Owner.find_by(params[:owner][:name])
      @owner = Owner.find_by(params[:id])

      # binding.pry
      @pet.owner = @owner
      # binding.pry doesn't hit
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
