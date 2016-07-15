require_relative 'weather_report'



puts "Enter zipcode to receive weather report"
zipcode = gets.chomp

weather_report = WeatherReport.new("10f48e19197a0061", zipcode).get_conditions
puts weather_report[city:, state:]
