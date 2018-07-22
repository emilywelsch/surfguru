require_relative '../lib/beach.rb'
require_relative '../lib/country.rb'
require_relative '../lib/continent.rb'

class Scraper

  def self.scrape_and_create_continents
    doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams"))
    str = doc.search('div.quiver-world-taxonomy__continents').text.split /(?=[A-Z])/
    continents = [str[0], str[1], str[2], str[3] << str[4], str[5], str[6] << str[7]]
    continents.each {|continent| Continent.new(continent)}
  end

  def self.scrape_and_create_countries
    doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams"))

    x = 0
    while x < 6
      arr = doc.search('div.quiver-world-taxonomy__countries')[x].css('a').text.split(" Surf Reports & Cams")
      arr.each do |country|
        country_details = {}
        country_details[:name] = country
        country_details[:continent] = Continent.all[x].name
        Country.new(country_details)
      end
      x += 1
    end

    doc.search('div.quiver-world-taxonomy__countries').each do |country|
      country_urls = {}
      country_urls[:url] = "https://www.surfline.com/" + country.css('a').attr('href') #this isn't scraping all urls

      arr = country.css('a').attr('href').value.split("surf-reports-forecasts-cams/")
      arr1 = arr[1].split /\/.*$/
      arr2 = arr1[0].gsub("-"," ").split
      arr2.each {|word| word.capitalize!}
      country_urls[:name] = arr2.join(" ")

      Country.all.each do |country_object|
        if country_urls[:name] == country_object.name
          country_object.send(("#{:url}="), country_urls[:url])
        end
      end
    end
  end

  def self.scrape_country_urls
    doc = Nokogiri::HTML(open("https://www.surfline.com/surf-reports-forecasts-cams"))
    x = 0
    y = 0
    while x < 5
      country_details = {}
      country_details[:url] = "https://www.surfline.com/" + doc.search('div.quiver-world-taxonomy__countries')[x].css('a')[y].attr('href')

      arr = doc.search('div.quiver-world-taxonomy__countries')[x].css('a')[y].attr('href').value.split("surf-reports-forecasts-cams/")
      arr1 = arr[1].split /\/.*$/
      arr2 = arr1[0].gsub("-"," ").split
      arr2.each {|word| word.capitalize!}
      country_urls[:name] = arr2.join(" ")

      case x
      when x == 0
        country_details[:continent] = "Africa"
      when x == 1
        country_details[:continent] = "Asia"
      when x == 2
        country_details[:continent] = "Europe"
      when x == 3
        country_details[:continent] = "North America"
      when x == 4
        country_details[:continent] = "Oceania"
      when x == 5
        country_details[:continent] = "South America"
      else x < 5
        break
      end

      y += 1

      # Can I do each for the y variable inside a loop?

    end
  end

  def self.scrape_and_create_beaches(country_input)
    beaches = []
    doc = Nokogiri::HTML(open(Country.all[country_input.to_i-1].url))
    doc.css('div.sl-spot-list__ref').each do |beach|
      beach_details = {}
      beach_details[:name] = beach.css('h3.sl-spot-details__name').text
      beach_details[:surf_height] = beach.css('span.quiver-surf-height').text
      beach_details[:url] = "https://www.surfline.com" + beach.css('a')[0].attribute('href').value if(beach.css('a').length > 0)
      # beach_details[:country] = Country.all[country_input.to_i-1].country
      # beach_details[:continent] = Country.all[country_input.to_i-1].continent
      Beach.new(beach_details)
    end
  end

  def self.scrape_and_add_beach_details(beach_input)
    doc = Nokogiri::HTML(open(Beach.all[beach_input.to_i-1].url))
      beach_details = {}

      wind_tide_array = doc.css('span.sl-reading').text.split /(?<=FT)/
      if wind_tide_array.length == 1
        beach_details[:tide] = "Not available for this spot"
        beach_details[:wind] = wind_tide_array[0]
      elsif wind_tide_array.length == 2
        beach_details[:tide] = wind_tide_array[0]
        beach_details[:wind] = wind_tide_array[1]
      else
      end

      wind_direction_array = doc.css('span.sl-reading-description').text.split /(?=[A-Z])+/
      beach_details[:wind_direction] = wind_direction_array.last

      swells_array = doc.css('div.sl-spot-forecast-summary__stat-swells').text.split("Swells")
      if swells_array.length > 0
        swells = swells_array[1].split /(?<=º)/
        if swells.uniq.length == 1
          beach_details[:swell_direction] = "#{swells[0]}"
        elsif swells.uniq.length == 2
          beach_details[:swell_direction] = "#{swells[0]}, #{swells[1]}"
        elsif swells.uniq.length == 3
          beach_details[:swell_direction] = "#{swells[0]}, #{swells[1]}, #{swells[2]}"
        end
      else beach_details[:swell_direction] = "Not available for this spot"
      end

      water_air_temp_array = doc.css('div.sl-wetsuit-recommender__weather').text.split /(?<=F)/
        beach_details[:water_temp] = water_air_temp_array[0]
        beach_details[:outside_temp] = water_air_temp_array[1]

      arr1 = doc.css('div.sl-ideal-conditions__condition__description').text.split /(Tide)/
        beach_details[:ideal_tide] = arr1[2]
      arr2 = arr1[0].split /(Surf Height)/
        beach_details[:ideal_surf_height] = arr2[2]
      arr3 = arr2[0].split /(Wind)/
        beach_details[:ideal_wind] = arr3[2]
      arr4 = arr3[0].split /(Swell Direction)/
        beach_details[:ideal_swell_direction] = arr4[2]

      beach_details

    Beach.all[beach_input.to_i-1].add_attributes(beach_details)
  end
end
