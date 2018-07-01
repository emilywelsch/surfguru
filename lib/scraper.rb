# require "surfguru/version"
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/beach.rb'
require_relative '../lib/cli.rb'

class Scraper

  def self.scrape_continents
    # continents = ["Africa", "Asia", "Europe", "North America", "Oceania", "South America", "Everywhere"]
    # continents
      doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams/"))
      str = doc.search('div.quiver-world-taxonomy__continents').text.split /(?=[A-Z])/
      continents = [str[0], str[1], str[2], str[3] << str[4], str[5], str[6] << str[7]]
  end

  def self.scrape_countries
    countries = ["Algeria", "Angola", "Cape Verde", "Ghana", "Ivory Coast", "Liberia", "Madagascar"]
    countries
    # countries = []

  end

  def self.scrape_beaches
    beaches = ["Annaba", "Decaplage", "Plage Mandjane", "Pipeline", "Chia"]
    beaches
    # beaches = []

  end

  def self.scrape_beach_details
    beach_details = {:surf_height=>"flat", :wind=>"23 kts", :swell=>"1-2 ft"}
    beach_details
    # name
    # surf height
    # wind (kts)
    # swell (ft)
    # water temp (f)
    # outside temp (f)
    # ideal swell direction
    # ideal wind direction
    # ideal surf height (ft)
    # ideal tide
    # first light
    # sunrise
    # sunset
    # last light
  end


end
