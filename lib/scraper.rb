# require "surfguru/version"
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/beach.rb'
require_relative '../lib/cli.rb'

class Scraper

  def self.scrape_continents
    doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams"))
    str = doc.search('div.quiver-world-taxonomy__continents').text.split /(?=[A-Z])/
    continents = [str[0], str[1], str[2], str[3] << str[4], str[5], str[6] << str[7], "Everywhere"]
  end

  def self.scrape_countries#(country_slug)
    countries = ["Algeria", "Angola", "Cape Verde", "Ghana", "Ivory Coast", "Liberia", "Madagascar"]
    countries

    # https://www.surfline.com/surf-reports-forecasts-cams
    # https://www.surfline.com/surf-reports-forecasts-cams#africa
    # https://www.surfline.com/surf-reports-forecasts-cams#asia
    # https://www.surfline.com/surf-reports-forecasts-cams#europe
    # https://www.surfline.com/surf-reports-forecasts-cams#north-america
    # https://www.surfline.com/surf-reports-forecasts-cams#oceania
    # https://www.surfline.com/surf-reports-forecasts-cams#south-america

    # countries = []
    # country_page = "https://www.surfline.com/surf-reports-forecasts-cams" + country_slug
    # doc = Nokogiri::HTML(open(country_page))
    # doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#africa"))
    # binding.pry
    # doc.css("li ~ ul").text
    # binding.pry
    # country.name = doc.search('div.quiver-world-taxonomy__letter').text
    # country.url = doc.search('div.quiver-world-taxonomy__letter').attr('href').value


  end

  def self.scrape_beaches#(country_beaches_slug)
    # beaches = ["Annaba", "Decaplage", "Plage Mandjane", "Pipeline", "Chia"]
    # beaches
    beaches = []
    country_beaches_slug = "surf-reports-forecasts-cams/algeria/2589581"
    beaches_page = "https://www.surfline.com/" + country_beaches_slug #this will come as the variable to the method
    doc = Nokogiri::HTML(open(beaches_page))
    doc.css('div.sl-spot-list__ref').each do |beach|
      beach_details = {}
      beach_details[:name] = beach.css('h3.sl-spot-details__name').text
      beach_details[:surf_height] = beach.css('span.quiver-surf-height').text
      beach_details[:tide_height] = beach.css('div.sl-spot-report-summary__value').text.scan /^(.*?)T/
      beach_details[:wind] = beach.css('div.sl-spot-report-summary__value').text
      # beach_details[:beach_url] = beach.css('a').attribute('href').value          # nokogiri error message!
      beaches << beach_details
    end
    beaches
  end

  def self.scrape_beach_details#(beach_slug)
    # beach_details = {:surf_height=>"flat", :wind=>"23 kts", :swell=>"1-2 ft"}
    # beach_details
    beach_details = []
    beach_slug = "surf-report/decaplage/584204214e65fad6a7709ce3"
    beach_page = "https://www.surfline.com/" + beach_slug #this will come as the variable to the method
    doc = Nokogiri::HTML(open(beach_page))
      doc.css('div.sl-spot-report').each do |beach|
        beach_details = {}
        beach_details[:name] = beach.css('h3.sl-spot-details__name').text
        beach_details[:surf_height] = beach.css('span.quiver-surf-height').text
        beach_details[:tide_height] = beach.css('div.sl-spot-report-summary__value').text.scan /^(.*?)T/
        beach_details[:wind] = beach.css('div.sl-spot-report-summary__value').text
        # beach_details[:beach_url] = beach.css('a').attribute('href').value          # nokogiri error message!
        beaches << beach_details
      end
      beaches
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
