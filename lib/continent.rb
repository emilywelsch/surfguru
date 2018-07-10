# require "surfguru/version"

class Continent
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  # def add_country(country)
  #   country.continent = self
  # end
  #
  # def add_country_by_name(name)
  #   country = Country.new(name)
  #   country.continent = self
  # end
  #
  # def countries
  #   Country.all.select {|country| country.continent == self}
  # end
  #
  # def self.country_count
  #   Country.all.count
  # end

end
