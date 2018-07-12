# require "surfguru/version"

class Beach
  attr_accessor :name, :url, :surf_height, :tide_height, :wind, :water_temp, :outside_temp, :first_light, :sunrise, :sunset, :last_light, :country, :continent
  @@all = []

  def initialize(beach_hash)
    beach_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  def self.clear_all
    @@all = []
  end

  # def self.create_new(beach_array)
  #   beach_array.each do |beach_hash|
  #     self.new(beach_hash)
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


end
