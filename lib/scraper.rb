# require "surfguru/version"
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative '../lib/beach.rb'
require_relative '../lib/country.rb'
require_relative '../lib/continent.rb'
require_relative '../lib/cli.rb'

class Scraper

  def self.scrape_continents
    doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams"))
    str = doc.search('div.quiver-world-taxonomy__continents').text.split /(?=[A-Z])/
    continents = [str[0], str[1], str[2], str[3] << str[4], str[5], str[6] << str[7]]
    continents.each {|continent| Continent.new(continent)}
  end

  def self.scrape_countries(continent_input)
    countries = []
    country_urls = []
    x = 0

    case continent_input

      when "1"
        doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#africa"))
        countries = doc.search('div.quiver-world-taxonomy__countries')[0].css('a').text.split(" Surf Reports & Cams")

        while x < 16 # Would be nice if nums weren't hardcoded but instead stopped at a nil return...
        country_urls << "https://www.surfline.com/" + doc.search('div.quiver-world-taxonomy__countries')[0].css('a')[x].attr('href')
        x += 1
        end

      when "2"
        doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#asia"))
        countries = doc.search('div.quiver-world-taxonomy__countries')[1].css('a').text.split(" Surf Reports & Cams")

        while x < 18
        country_urls << "https://www.surfline.com/" + doc.search('div.quiver-world-taxonomy__countries')[1].css('a')[x].attr('href')
        x += 1
        end

      when "3"
        doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#europe"))
        countries = doc.search('div.quiver-world-taxonomy__countries')[2].css('a').text.split(" Surf Reports & Cams")

        while x < 21
        country_urls << "https://www.surfline.com/" + doc.search('div.quiver-world-taxonomy__countries')[2].css('a')[x].attr('href')
        x += 1
        end

      when "4"
        doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#north-america"))
        countries = doc.search('div.quiver-world-taxonomy__countries')[3].css('a').text.split(" Surf Reports & Cams")

        while x < 24
        country_urls << "https://www.surfline.com/" + doc.search('div.quiver-world-taxonomy__countries')[3].css('a')[x].attr('href')
        x += 1
        end

      when "5"
        doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#oceania"))
        countries = doc.search('div.quiver-world-taxonomy__countries')[4].css('a').text.split(" Surf Reports & Cams")

        while x < 11
        country_urls << "https://www.surfline.com/" + doc.search('div.quiver-world-taxonomy__countries')[4].css('a')[x].attr('href')
        x += 1
        end

      when "6"
        doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams#south-america"))
        countries = doc.search('div.quiver-world-taxonomy__countries')[5].css('a').text.split(" Surf Reports & Cams")

        while x < 8
        country_urls << "https://www.surfline.com/" + doc.search('div.quiver-world-taxonomy__countries')[5].css('a')[x].attr('href')
        x += 1
        end

      else
        puts "Something has gone terribly wrong."
    end
    arr = countries.zip(country_urls)
    country_array = arr.map{|country, country_url| {name: country, url: country_url}}
    country_array.each {|country_hash| Country.new(country_hash)}
  end

  def self.scrape_beaches(country_input)
    beaches = []
    doc = Nokogiri::HTML(open(Country.all[country_input.to_i-1].url))
    doc.css('div.sl-spot-list__ref').each do |beach|
      beach_details = {}
      beach_details[:name] = beach.css('h3.sl-spot-details__name').text
      beach_details[:surf_height] = beach.css('span.quiver-surf-height').text
      beach_details[:url] = "https://www.surfline.com" + beach.css('a')[0].attribute('href').value if(beach.css('a').length > 0) # nokogiri error message! because some of the beaches don't have a url
      beaches << beach_details
    end
    beaches.each {|beach_hash| Beach.new(beach_hash)}
  end

  def self.scrape_beach_details(beach_input)
    doc = Nokogiri::HTML(open(Beach.all[beach_input.to_i-1].url))
      beach_details = {}

      wind_tide_array = doc.css('span.sl-reading').text.split /(?<=FT)/
      if wind_tide_array.length == 1
        beach_details[:tide_height] = ["Tide height information not available."]
        beach_details[:wind] = wind_tide_array[0]
      elsif wind_tide_array.length == 2
        beach_details[:tide_height] = wind_tide_array[0]
        beach_details[:wind] = wind_tide_array[1]
      else
      end

      swells_array = doc.css('div.sl-spot-forecast-summary__stat-swells').text.split("Swells")
      if swells_array.length > 0
        beach_details[:swells] = swells_array[1].split /(?<=º)/
      else beach_details[:swells] = ["Swell information not available."]
      end

      water_air_temp_array = doc.css('div.sl-wetsuit-recommender__weather').text.split /(?<=F)/
        beach_details[:water_temp] = water_air_temp_array[0]
        beach_details[:air_temp] = water_air_temp_array[1]

      arr1 = doc.css('div.sl-ideal-conditions__condition__description').text.split /(Tide)/
        beach_details[:ideal_tide] = arr1[2]
      arr2 = arr1[0].split /(Surf Height)/
        beach_details[:ideal_surf_height] = arr2[2]
      arr3 = arr2[0].split /(Wind)/
        beach_details[:ideal_wind] = arr3[2]
      arr4 = arr3[0].split /(Swell Direction)/
        beach_details[:ideal_swell_direction] = arr4[2]

      beaches << beach_details
      beaches
    end
    Beach.all[beach_input.to_i-1].add_attributes(beach_details)

end
