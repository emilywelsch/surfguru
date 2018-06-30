# require "surfguru/version"
require 'nokogiri'
require 'colorize'
require_relative '../lib/beach.rb'
require_relative '../lib/scraper.rb'

class CLI
  # https://www.surfline.com/surf-reports-forecasts-cams
  # https://www.surfline.com/surf-reports-forecasts-cams#africa
  # https://www.surfline.com/surf-reports-forecasts-cams#asia
  # https://www.surfline.com/surf-reports-forecasts-cams#europe
  # https://www.surfline.com/surf-reports-forecasts-cams#north-america
  # https://www.surfline.com/surf-reports-forecasts-cams#oceania
  # https://www.surfline.com/surf-reports-forecasts-cams#south-america
  continents = ["Africa", "Asia", "Europe", "North America", "Oceania", "South America", "Everywhere"]

  def surf
    puts "  "
    puts "Welcome to SurfGuru "
    puts "your guide to surfing the world "
    puts "  "
    list_continents
  end

  def list_continents
    continents = ["Africa", "Asia", "Europe", "North America", "Oceania", "South America", "Everywhere"]
    puts "Where would you like to surf? (Enter number or exit)"
    continents.each.with_index(1) { |continent, i| puts "#{i}. #{continent}" }
    puts "  "
    select_continent
  end

  def select_continent
    case user_input = gets.chomp
    when "exit"
      puts "Catch you on the next wave!"
      exit
    when "1", "2", "3", "4", "5", "6", "7"
      list_beaches(user_input)
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_continents
    end
  end






end
