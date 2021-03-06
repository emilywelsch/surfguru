class Beach
  attr_accessor :name, :url, :surf_height, :tide, :wind, :wind_direction, :swell_direction, :water_temp, :outside_temp, :ideal_surf_height, :ideal_tide, :ideal_wind, :ideal_swell_direction, :country, :continent
  @@all = []

  def initialize(beach_hash)
    beach_hash.each do |key, value|
      self.send("#{key}=", value) if value.length > 0
    end
    @@all << self
  end

  def self.clear_all
    @@all = []
  end

  def add_attributes(beach_details)
    beach_details.each do |k, v|
      self.send(("#{k}="), v)
    end
  end

  def self.all
    @@all
  end
end
