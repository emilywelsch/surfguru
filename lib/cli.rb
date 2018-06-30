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
    continents = Scraper.scrape_continents
    user_input = gets.chomp
    if user_input == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
    elsif user_input.to_i.between?(1, Scraper.scrape_continents.size)
      puts "Nice choice! There are lots of great surf spots in #{continents[user_input.to_i-1]}.".colorize(:cyan)
      list_countries
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_continents
    end
  end

  def list_countries
    countries = Scraper.scrape_countries
    puts "Select Country: (Enter number, go back, or exit)".colorize(:blue)
    countries.each.with_index(1) { |country, i| puts "#{i}. #{country}" }
    puts "  "
    select_country
  end

  def select_country
    countries = Scraper.scrape_countries
    user_input = gets.chomp
    if user_input == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
    elsif user_input == "go back"
      list_continents
    elsif user_input.to_i.between?(1, Scraper.scrape_countries.size)
      puts "Here's a list of some amazing surf spots in #{countries[user_input.to_i-1]} with their current swell conditions.".colorize(:cyan)
      list_beaches
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_countries
    end
  end

  def list_beaches
    beaches = Scraper.scrape_beaches
    puts "Select a beach below for more detailed information: (Enter number, go back, or exit)".colorize(:blue)
    beaches.each.with_index(1) { |beach, i| puts "#{i}. #{beach} - Surf Swell Condition Currently" }
    puts "  "
    select_beach
  end

  def select_beach
    beaches = Scraper.scrape_beaches
    user_input = gets.chomp
    if user_input == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
    elsif user_input == "go back"
      list_countries
    elsif user_input.to_i.between?(1, Scraper.scrape_beaches.size)
      list_beach_details
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_beaches
    end
  end

  def list_beach_details
    # Scraper.scrape_beach_details
    puts "Beach details will go here.".colorize(:blue)
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
