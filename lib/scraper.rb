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

  def self.scrape_countries
    # countries = ["Algeria", "Angola", "Cape Verde", "Ghana", "Ivory Coast", "Liberia", "Madagascar"]
    # countries

    countries = []

      case user_input

        when "1"
          doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#africa"))
          countries = doc.search('div.quiver-world-taxonomy__countries')[0].css('a').text.split(" Surf Reports & Cams")
          # urls = doc.search('div.quiver-world-taxonomy__countries')[0].attribute('href').value if(doc.css('a').length > 0)
        when "2"
          doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#asia"))
          countries = doc.search('div.quiver-world-taxonomy__countries')[1].css('a').text.split(" Surf Reports & Cams")
        when "3"
          doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#europe"))
          countries = doc.search('div.quiver-world-taxonomy__countries')[2].css('a').text.split(" Surf Reports & Cams")
        when "4"
          doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#north-america"))
          countries = doc.search('div.quiver-world-taxonomy__countries')[3].css('a').text.split(" Surf Reports & Cams")
        when "5"
          doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#oceania"))
          countries = doc.search('div.quiver-world-taxonomy__countries')[4].css('a').text.split(" Surf Reports & Cams")
        when "6"
          doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#south-america"))
          countries = doc.search('div.quiver-world-taxonomy__countries')[5].css('a').text.split(" Surf Reports & Cams")
        # when "Everywhere"
        #   doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams"))
        #   countries = doc.search('div.quiver-world-taxonomy__countries').css('a').text.split(" Surf Reports & Cams")
        else
          puts "Uh oh... something has gone terribly wrong."
      end

  end

  def self.scrape_beaches#(country_beaches_slug)
    # beaches = ["Annaba", "Decaplage", "Plage Mandjane", "Pipeline", "Chia"]
    # beaches
    beaches = []
    country_beaches_slug = "surf-reports-forecasts-cams/algeria/2589581"
    beaches_page = "https://www.surfline.com/" + country_beaches_slug #this will come as the variable to the method
    doc = Nokogiri::HTML(open(beaches_page))
    doc.css('div.sl-spot-list__ref').each do |beach|
      # binding.pry
      beach_details = {}
      beach_details[:name] = beach.css('h3.sl-spot-details__name').text
      beach_details[:surf_height] = beach.css('span.quiver-surf-height').text
      # Need to split array below for tide height and wind better
      beach_details[:tide_height] = beach.css('div.sl-spot-report-summary__value').text.scan /^(.*?)T/
      beach_details[:wind] = beach.css('div.sl-spot-report-summary__value').text
      beach_details[:beach_url] = beach.css('a')[0].attribute('href').value if(beach.css('a').length > 0) # nokogiri error message! because some of the beaches don't have a url
      beaches << beach_details
    end
    beaches
  end

  def self.scrape_beach_details#(beach_slug)
    # beach_details = {:surf_height=>"flat", :wind=>"23 kts", :swell=>"1-2 ft"}
    # beach_details
    beaches = []
    beach_details = {}
    beach_slug = "surf-report/decaplage/584204214e65fad6a7709ce3"
    beach_page = "https://www.surfline.com/" + beach_slug #this will come as the variable to the method
    doc = Nokogiri::HTML(open(beach_page))
        doc.css('div.sl-spot-report').each do |beach|
        # binding.pry
        beach_details[:name] = beach.css('h3.sl-spot-details__name').text
        beach_details[:surf_height] = beach.css('span.quiver-surf-height').text
        beach_details[:tide_height] = beach.css('span.sl-reading').text
        beach_details[:wind] = beach.css('span.sl-reading').text
        beach_details[:swells] = beach.css('div.sl-swell-measurements.sl-swell-measurements--1').text
        beaches << beach_details
      end
      doc.css('div.sl-wetsuit-recommender__weather').each do |beach|
        beach_details[:water_temp] = beach.css('div').attr('alt').text # parse with regex
        beach_details[:air_temp] = beach.css('div').attr('alt').text # parse with regex
        beach_details[:sun_table] = beach.css('table.sl-forecast-graphs__table sl-forecast-graphs__table--sunlight-times').text # parse with regex
        beaches << beach_details
      end
      beaches
    end

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
