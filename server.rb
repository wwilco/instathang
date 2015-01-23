require "sinatra"
require "HTTParty"
require "pry"



api_key = File.read("api_key.txt")
api_key.delete "\n"


get "/" do
  erb :instagram, locals: {images: []}
end

get "/search" do
  image_array = []
  data = params[:search]
  url = "https://api.instagram.com/v1/tags/#{data}/media/recent?client_id=#{api_key}"
  response = HTTParty.get(url)
  data = response["data"]

  data.each do |position|
    image_array << position["images"]["standard_resolution"]["url"]
  end

  erb :instagram, locals: {images: image_array}
  # binding.pry
end
