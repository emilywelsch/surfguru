# require "surfguru/version"
require 'nokogiri'
require 'colorize'
require_relative '../lib/beach.rb'
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
    Scraper.scrape_country_urls #remove this after testing
    # select_continent # uncomment out after testing
  end

  def select_continent
    continents = Scraper.scrape_continents
    continent_input = gets.chomp
    if continent_input == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
    elsif continent_input.to_i.between?(1, Scraper.scrape_continents.size-1)
      puts "Nice choice! There are lots of great surf spots in #{continents[continent_input.to_i-1]}.".colorize(:cyan)
      list_countries(continent_input)
    elsif continent_input == "7"
      puts "The world is your oyster! Let's check out the surf #{continents[continent_input.to_i-1].downcase}.".colorize(:cyan)
      list_all_beaches
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_continents
    end
  end

  def list_countries(continent_input)
    countries = Scraper.scrape_countries(continent_input)
    puts "Select Country: (Enter number, go back, or exit)".colorize(:blue)
    countries.each.with_index(1) { |country, i| puts "#{i}. #{country}" }
    puts "  "
    select_country(continent_input)
  end

  def select_country(continent_input)
    country_input = gets.chomp
    if country_input == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
    elsif country_input == "go back"
      list_continents
    elsif country_input.to_i.between?(1, Scraper.scrape_countries(continent_input).size) # <-- this is the problem
      puts "Here's a list of some amazing surf spots in #{Scraper.scrape_countries(continent_input)[country_input.to_i-1]} with their current swell conditions.".colorize(:cyan)
      list_beaches#(country_input) #need to have already scraped the country url to read this...
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_countries(continent_input)
    end
  end

  def list_beaches#(country_input)
    beaches = Scraper.scrape_beaches#(country_input) #<-- make this scrape the right countries
    puts "Select a beach below for more detailed information: (Enter number, go back, or exit)".colorize(:blue)
    beaches.each.with_index(1) { |beach, i| puts "#{i}. #{beach} - Surf Swell Condition Currently" }
    puts "  "
    select_beach
  end

  def select_beach#(country_input)
    beaches = Scraper.scrape_beaches#(country_input)
    beach_input = gets.chomp
    if beach_input == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
    elsif beach_input == "go back"
      list_countries
    elsif beach_input.to_i.between?(1, Scraper.scrape_beaches.size)
      list_beach_details
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_beaches#(country_input)
    end
  end

  def list_all_beaches
    puts "Let's check out all the best surf beaches in the world."
    puts "Select a beach below for more detailed information: (Enter number, go back, or exit)".colorize(:blue)
    Beach.all.each.with_index(1) { |beach, i| puts "#{i}. #{beach} - Surf Swell Condition Currently" }
    puts "  "
    select_beach
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
