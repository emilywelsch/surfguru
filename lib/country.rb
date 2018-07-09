# require "surfguru/version"

class Country
  attr_accessor :name, :continent, :url
  @@all = []

  def initialize(name)
    @name = name
    @continent = continent
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def continent_name
    if self.continent
      self.continent.name
    else
      nil
    end
  end

  def add_beach(beach)
    beach.country = self
  end

  def add_beach_by_name(name)
    beach = Beach.new(name)
    beach.country = self
  end

  def beaches
    Beach.all.select {|beach| beach.country == self}
  end

  def self.beach_count
    Beach.all.count
  end

end
