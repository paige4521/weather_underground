require 'httparty'
require 'uri'
require 'json'
require 'area'
require 'pry'

class Wunderground

	def initialize(zipcode)
		@zipcode = zipcode.to_i #why to i?
		@token = ENV['WUNDERGROUND_TOKEN']

		#private method cal
		region_info = zipcode_to_region

		#assign keys to instance variables
		@state_code = region_info["state"]
		@city = region_info["city"]
		# puts "City: #{@city}, State: #{@state_code}"
	end


	def get_conditions
		url = URI.parse("http://api.wunderground.com/api/#{@token}/conditions/q/#{@zipcode}.json")
		http_response = HTTParty.get(url).parsed_response
		puts JSON.pretty_generate(http_response)
	end


	def get_forecast10day
		url = URI.parse("http://api.wunderground.com/api/#{@token}/forecast10day/q/#{@zipcode}.json")
		http_response = HTTParty.get(url).parsed_response
		puts JSON.pretty_generate(http_response)
	end


	#TODO: Need to Debug why not getting proper alert info
	def get_alerts
		url = URI.parse("http://api.wunderground.com/api/#{@token}/alerts/q/#{@state_code}/#{@city}.json")
		http_response = HTTParty.get(url).parsed_response
		puts JSON.pretty_generate(http_response)
	end


	def get_hurricane_info
		url = URI.parse("http://api.wunderground.com/api/#{@token}/currenthurricane/view.json")
		http_response = HTTParty.get(url)
		json_response = JSON.parse(http_response.body)

		##extract info
		info = Hash.new
		json_response["currenthurricane"].each do |item|
			puts item["stormInfo"]
		end

	end

	private
	def zipcode_to_region
		## method converts zipcode to region information eg: 21229 => Baltimore, MD
		region_info = Hash.new

		# to_region must be called on a string, use to_s to make zipcode into a string
		region_info["state"] = @zipcode.to_s.to_region(:state => true)

		# take the @zipcode which is an intege convert it to a string
		# call the area gem's .to_region method on it
		# Wunderground API for getting alerts only takes
		# a state code and a city name "with an underscore separating the name"
		# we need to replace the whitespace in the city name
		# that the area gem returns with an underscore so that the
		# wunderground api call can be of the correct format, use .gsub for this
		region_info["city"] = @zipcode.to_s.to_region(:city => true).gsub(" ", "_")
		return region_info
	end

end

zipcode 	= 21229
wunderground 	= Wunderground.new(zipcode)

hurricane = wunderground.get_hurricane_info
