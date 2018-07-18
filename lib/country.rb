# require "surfguru/version"

class Country
  attr_accessor :name, :url, :continent
  @@all = []

  def initialize(country_hash)
    country_hash.each do |key, value|
      self.send("#{key}=", value) if value.length > 0
    end
    @@all << self
  end

  def self.clear_all
    @@all = []
  end

  def self.all
    @@all
  end
end
