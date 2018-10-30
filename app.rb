require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/pet.db")

class Pet
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
end
DataMapper.finalize.auto_upgrade!

#index
get '/pets' do
  @pets = Pet.all
  erb :'pets/index'
end

get '/pets/new' do
  erb :'pets/new'
end

post '/pets' do
 Pet.create({:name => params[:name]})
  redirect '/pets'
end


get '/pets/:id' do
@pet = Pet.get(params["id"])
  erb :'pets/show'
end

get '/pets/:id/edit' do
@pet = Pet.get(params["id"])
  erb :'pets/edit'
end

patch '/pets/:id' do
pet = Pet.get(params["id"])
pet.update({:name => params[:name]})
redirect '/pets'
end

delete '/pets/:id' do
  pet = Pet.get(params["id"])
  pet.destroy
  redirect '/pets'
end
