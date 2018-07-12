# require "surfguru/version"
require 'nokogiri'
require 'colorize'
require_relative '../lib/beach.rb'
require_relative '../lib/country.rb'
require_relative '../lib/continent.rb'
require_relative '../lib/scraper.rb'

class CLI

  def surf
    puts "  "
    puts ">>>>---------------- ·÷±‡± Welcome to SurfGuru ±‡±÷· ---------------->".colorize(:blue)
    puts "                     your guide to surfing the world ".colorize(:cyan)
    puts "  "
    list_continents
  end

  def list_continents
    continents = Scraper.scrape_continents
    puts "Select Continent: (Enter number or exit)".colorize(:blue)
    continents.each.with_index(1) { |continent, i| puts "#{i}. #{continent}" }
    puts "  "
    select_continent
  end

  def select_continent
    continent_input = gets.chomp
    if continent_input == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
  elsif continent_input.to_i.between?(1, Continent.all.size)
      puts "Nice choice! There are lots of great surf spots in #{Continent.all[continent_input.to_i-1].name}.".colorize(:cyan)
      list_countries(continent_input)
    else
      puts "Invalid entry. Please try again.".colorize(:red)
      puts "  "
      list_continents
    end
  end

  def list_countries(continent_input)
    Scraper.scrape_countries(continent_input)
    puts "Select Country: (Enter number, go back, or exit)".colorize(:blue)
    Country.all.each.with_index(1) {|country, i| puts "#{i}. #{country.name}"}
    puts "  "
    select_country(continent_input)
  end

  def select_country(continent_input)
    country_input = gets.chomp
    if country_input == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
    elsif country_input == "go back"
      Country.clear_all
      list_continents
    elsif country_input.to_i.between?(1, Country.all.size)
      puts "Here's a list of some amazing surf spots in #{Country.all[country_input.to_i-1].name} with their current swell conditions.".colorize(:cyan)
      list_beaches(country_input)
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_countries(continent_input)
    end
  end

  def list_beaches(country_input)
    Scraper.scrape_beaches(country_input)
    puts "Select a beach below for more detailed information: (Enter number, go back, or exit)".colorize(:blue)
    Beach.all.each.with_index(1) {|beach, i| puts "#{i}. #{beach.name}: #{beach.surf_height}"}
    puts "  "
    select_beach(country_input)
  end

  def select_beach(country_input)
    beach_input = gets.chomp
    if beach_input == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
    elsif beach_input == "go back"
      Beach.clear_all
      list_continents
    elsif beach_input.to_i.between?(1, Beach.all.size)
      list_beach_details(beach_input)
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_beaches(country_input)
    end
  end

  def list_beach_details(beach_input)
    Scraper.scrape_beache_details(beach_input)
    puts "Here is the additional information you requested for #{Beach.all[beach_input.to_i-1].name}:"
      Beach.all.each do |beach, i|
        puts "·÷±‡± #{beach.name} ±‡±÷·"
        puts "-------------------------"
        puts "Surf: #{beach.surf_height}"
        puts "Tide: #{beach.tide_height}"
        puts "Wind: #{beach.wind}"
        puts "Water Temperature: #{beach.water_temp}"
        puts "Outside Temperature: #{beach.outside_temp}"
        puts "First Light: #{beach.first_light}"
        puts "Sunrise: #{beach.sunrise}"
        puts "Sunset: #{beach.sunset}"
        puts "Last Light: #{beach.last_light}"
        puts "........................."
      end
    puts "  "
    surf_again?
  end

  def surf_again?
    puts "Want to surf again? (Enter yes or no)".colorize(:blue)
    user_input = gets.chomp
    if user_input == "yes"
      puts "Gnarly. Let's go again.".colorize(:cyan)
      puts "  "
      list_continents
    elsif user_input == "no"
      puts "Catch you on the next wave!".colorize(:cyan)
      puts "  "
      exit
    else
      puts "Sorry, I didn't understand that entry.".colorize(:red)
      surf_again?
    end
  end


end
