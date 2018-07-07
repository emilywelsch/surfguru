# require "surfguru/version"

class Beach
  attr_accessor :name, :surf_height, :tide_height, :wind, :country_name, :country_url, :beach_url, :continent_name
  @@all = []

  def initialize(attributes)
    attributes.each {|k, v| self.send(("#{k}="), v)}
    @@all << self unless @@all.any? {|beach| beach.beach_url == self.beach_url}
  end

  def self.create_new(beach_array)
    beach_array.each do |beach_hash|
      self.new(beach_hash)
    end
  end

  def add_attributes(details_hash)
    details_hash.each do |k, v|
      self.send(("#{k}="), v)
    end
  end

  def self.all
    @@all
  end


end
