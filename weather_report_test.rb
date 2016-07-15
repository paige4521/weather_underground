require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/pride'
require './weather_report'

#require './weather_report'
#require 'webmock/minitest'

class WeatherReportTest< Minitest::Test

  # def get_condition_data
  #   JSON.parse(File.read("./conditions.json"))
  # end
  #
  #
  # def ten_day_forecast_data
  #   JSON.parse(File.read("./ten_day_forecast.json"))
  # end
  #
  # def sunrise_sunset_data
  #   JSON.parse(File.read("./sunrise_sunset.json"))
  # end
  #
  # def current_hurricanes_data
  #   JSON.parse(File.read("./current_hurricanes.json"))
  # end

  def test_get_conditions
    weather = WeatherReport.new("10f48e19197a0061", 21076)
    assert_equal  87.8, weather.get_conditions
  end

  def test_ten_day_forecast
    weather = WeatherReport.new("10f48e19197a0061", 21076)
    weather_result = [{"title"=>"Thursday", "fcttext"=>"Partly cloudy. Lows overnight in the low 70s."}]
    assert_equal weather_result[0]["fcttext"], weather.ten_day_forecast[0]["fcttext"]
  end

  def test_sunrise_sunset
    weather = WeatherReport.new("10f48e19197a0061", 21076)
    assert_equal "5", weather.sunrise_sunset
  end

  def test_current_hurricanes
    weather = WeatherReport.new("10f48e19197a0061", 21076)
    assert_equal "Celia", weather.current_hurricanes
end
