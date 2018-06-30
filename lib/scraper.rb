# require "surfguru/version"
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/beach.rb'

class Scraper

  def self.scrape_continents
    continents = ["Africa", "Asia", "Europe", "North America", "Oceania", "South America", "Everywhere"]
    # continents = []
    #   doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams/"))
    #   binding.pry
    #   continent.name = doc.search('a').attr('data-reactid').text.strip
    #   continents << continent
  end

  def self.scrape_countries
    # countries = ["Algeria", "Angola", "Cape Verde", "Ghana", "Ivory Coast", "Liberia", "Madagascar"]
    countries = []

  end

  def self.scrape_beaches
    # beaches = ["Annaba", "Decaplage", "Plage Mandjane", "Pipeline", "Chia"]
    beaches = []

  end

  def self.scrape_beach_details
    beach_details = {}
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
