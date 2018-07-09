# require "surfguru/version"

class Beach
  attr_accessor :name, :url, :surf_height, :tide_height, :wind, :country, :continent
  @@all = []

  def initialize(attributes)
    attributes.each {|k, v| self.send(("#{k}="), v)}
    @@all << self unless @@all.any? {|beach| beach.url == self.url}
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
