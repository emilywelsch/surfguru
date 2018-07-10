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
    # countries = Scraper.scrape_countries(continent_input)
    # country_urls = Scraper.scrape_country_urls(continent_input)
    puts "Select Country: (Enter number, go back, or exit)".colorize(:blue)
    # binding.pry
    Country.all.each.with_index(1) { |country, i| puts "#{i}. #{country.name}" } # this is where I left off
    # countries.each.with_index(1) { |country, i| puts "#{i}. #{country}" }
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
    elsif country_input.to_i.between?(1, Scraper.scrape_countries(continent_input).size)
      puts "Here's a list of some amazing surf spots in #{Scraper.scrape_countries(continent_input)[country_input.to_i-1]} with their current swell conditions.".colorize(:cyan)
      list_beaches(country_input)
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_countries(continent_input)
    end
  end

  def list_beaches(country_input)
    puts "Select a beach below for more detailed information: (Enter number, go back, or exit)".colorize(:blue)
    make_beaches(country_input)
    add_attributes_to_beaches
    display_beaches
  end

  def make_beaches
    beaches_array = Scraper.scrape_beaches(beach.country_url)
    Beaches.create_new(beaches_array)
  end

  def add_attributes_to_beaches
    Beach.all.each do |beach|
      attributes = Scraper.scrape_beach_details(beach.beach_url)
      beach.add_attributes(details_hash)
    end
  end

  def display_beaches
    Beaches.all.each.with_index(1) { |beach, i| puts "#{i}. #{beach.name} - Current Surf Height: #{beach.surf_height}" }
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
