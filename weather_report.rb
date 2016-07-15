require "httparty"
require "uri"
require "json"
require "bundler"
#require "webmock"
#require 'area'
require 'pry'



class WeatherReport
attr_reader :token, :zip_code
#attr_reader :token, :zip_code


 def initialize(token, zip_code)
   @token = token
   @zip_code = zip_code
   #@state_code = state_code
   #@city_code = city_code
 end

 def get_conditions

   url = URI.parse("http://api.wunderground.com/api/#{@token}/conditions/q/#{@zip_code}.json")
   http_response = HTTParty.get(url)
   http_body_response = http_response.body
   parsed_response = JSON.parse(File.read("./conditions.json"))
   #puts http_response
    #parsed_response = JSON.parse(http_body_response)
    #puts parsed_response["current_observation"]["display_location"]["city"]
    #info = {}
    #info["city"] = parsed_response["current_observation"]["display_location"]["city"]
    #info["state"] = parsed_response["current_observation"]["display_location"]["state"]
    #info["zip"] = parsed_response["current_observation"]["display_location"]["zip"]
    #info["weather"] = parsed_response["current_observation"]["weather"]

    info = parsed_response["current_observation"]["temp_f"]
    puts info
    return info

 end

 def ten_day_forecast
    url = URI.parse("http://api.wunderground.com/api/#{@token}/forecast10day/q/#{@zip_code}.json")
    http_response = HTTParty.get(url)
     #puts JSON.pretty_generate(http_response)
    parsed_response = JSON.parse(http_response.body)
    ten_day_array = []
    parsed_response["forecast"]["txt_forecast"]["forecastday"].each do |day|
      daily = {}
      daily["title"] = day["title"]
      daily["fcttext"] = day["fcttext"]
      ten_day_array.push(daily)
      end

    ten_day_array
    #puts "#{ten_day_array}"
  end

 def sunrise_sunset
   url = URI.parse("http://api.wunderground.com/api/#{@token}/astronomy/q/#{@zip_code}.json")
   http_response = HTTParty.get(url)
   parsed_response = JSON.parse(File.read("./sunrise_sunset.json"))
   sun = parsed_response["moon_phase"]["sunrise"]["hour"]
   #puts JSON.pretty_generate(http_response)



 end

  def current_hurricanes
    url = URI.parse("http://api.wunderground.com/api/#{@token}/currenthurricane/q/#{@zip_code}view.json")
    http_response = HTTParty.get(url)
    parsed_response = JSON.parse(File.read('.current_hurricanes.json'))
    hurricane = parsed_response["currenthurricane"]["stormInfo"]["stormName"]
    #puts JSON.pretty_generate(http_response)
  end

end
