# require "surfguru/version"

class Country
  attr_accessor :name, :continent, :url
  @@all = []

  def initialize(name)
    @name = name
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

end
