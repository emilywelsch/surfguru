# require "surfguru/version"

class Country
  attr_accessor :name, :url, :continent
  @@all = []

  def initialize(country_hash)
    country_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.clear_all
    @@all = []
  end

  # def self.create_new(country_array)
  #   country_array.each do |country_hash|
  #     self.new(country_hash)
  #   end
  # end
  #
  # def add_attributes(details_hash)
  #   details_hash.each do |k, v|
  #     self.send(("#{k}="), v)
  #   end
  # end

  def self.all
    @@all
  end

  # def continent_name
  #   if self.continent
  #     self.continent.name
  #   else
  #     nil
  #   end
  # end
  #
  # def add_beach(beach)
  #   beach.country = self
  # end
  #
  # def add_beach_by_name(name)
  #   beach = Beach.new(name)
  #   beach.country = self
  # end
  #
  # def beaches
  #   Beach.all.select {|beach| beach.country == self}
  # end
  #
  # def self.beach_count
  #   Beach.all.count
  # end

end
