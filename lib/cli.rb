class CLI

  def surf
    puts "  "
    puts ">>>>---------------- ·÷±‡± Welcome to SurfGuru ±‡±÷· ---------------->".colorize(:blue)
    puts "                     your guide to surfing the world ".colorize(:cyan)
    puts "  "
    list_continents
  end

  def list_continents
    if Continent.all.length < 1
      continents = Scraper.scrape_and_create_continents
    else
      continents = Continent.all.map {|continent| continent.name}
    end
    puts "Select Continent: (Enter number or exit)".colorize(:blue)
    continents.each.with_index(1) { |continent, i| puts "#{i}. #{continent}" }
    puts "  "
    select_continent
  end

  def select_continent
    continent_input = gets.chomp
    if continent_input.downcase == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
  elsif continent_input.to_i.between?(1, Continent.all.size)
      puts "Nice choice! There are lots of great surf spots in #{Continent.all[continent_input.to_i-1].name}.".colorize(:cyan)
      list_countries(continent_input)
    else
      puts "Invalid entry. Please try again.".colorize(:red)
      puts "  "
      list_continents
    end
  end

  def list_countries(continent_input)
    Scraper.scrape_and_create_countries(continent_input)
    puts "Select Country: (Enter number, go back, or exit)".colorize(:blue)
    Country.all.each.with_index(1) {|country, i| puts "#{i}. #{country.name}"} #for refractoring, add "if country.continent == desired value"
    puts "  "
    select_country(continent_input)
  end

  def select_country(continent_input)
    country_input = gets.chomp
    if country_input.downcase == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
    elsif country_input.downcase == "go back"
      Country.clear_all
      puts "  "
      puts "Select Continent: (Enter number or exit)".colorize(:blue)
      Continent.all.each.with_index(1) { |continent, i| puts "#{i}. #{continent.name}" }
      puts "  "
      select_continent
    elsif country_input.to_i.between?(1, Country.all.size)
      puts "Here's a list of some amazing surf spots in #{Country.all[country_input.to_i-1].name} with their current swell conditions.".colorize(:cyan)
      list_beaches(country_input)
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_countries(continent_input)
    end
  end

  def list_beaches(country_input)
    Scraper.scrape_and_create_beaches(country_input)
    puts "Select a beach below for more detailed information: (Enter number, go back, or exit)".colorize(:blue)
    Beach.all.each.with_index(1) {|beach, i| puts "#{i}. #{beach.name}: #{beach.surf_height}" if beach.name != nil}
    puts "  "
    select_beach(country_input)
  end

  def select_beach(country_input)
    beach_input = gets.chomp
    if beach_input.downcase == "exit"
      puts "Catch you on the next wave!".colorize(:blue)
      exit
    elsif beach_input.downcase == "go back"
      Country.clear_all
      Beach.clear_all
      puts "  "
      puts "Select Continent: (Enter number or exit)".colorize(:blue)
      Continent.all.each.with_index(1) { |continent, i| puts "#{i}. #{continent.name}" }
      puts "  "
      select_continent
    elsif beach_input.to_i.between?(1, Beach.all.size)
      list_beach_details(beach_input)
    else
      puts "Invalid entry. Please try again".colorize(:red)
      puts "  "
      list_beaches(country_input)
    end
  end

  def list_beach_details(beach_input)
    Scraper.scrape_and_add_beach_details(beach_input)
    puts "Here is the additional information you requested for #{Beach.all[beach_input.to_i-1].name}:".colorize(:cyan)
      beach = Beach.all[beach_input.to_i-1]
        puts "  "
        puts "·÷±‡± #{beach.name} ±‡±÷·"
        puts "  "
        puts "Location: #{beach.country}, #{beach.continent}"
        puts "Swell Direction: #{beach.swell_direction}"
        puts "Wind: #{beach.wind} at #{beach.wind_direction}"
        puts "Surf Height: #{beach.surf_height}"
        puts "Tide: #{beach.tide}"
        puts "Water Temperature: #{beach.water_temp}"
        puts "Outside Temperature: #{beach.outside_temp}"
        puts "........................."
        puts "Ideal Swell Direction: #{beach.ideal_swell_direction}"
        puts "Ideal Wind: #{beach.ideal_wind}"
        puts "Ideal Surf Height: #{beach.ideal_surf_height}"
        puts "Ideal Tide: #{beach.ideal_tide}"
        puts "........................."
        puts "For more information about #{beach.name}, visit #{beach.url}."
        puts "  "
    surf_again?
  end

  def surf_again?
    puts "Want to surf again? (Enter yes or no)".colorize(:blue)
    user_input = gets.chomp
    if user_input.downcase == "yes"
      puts "Gnarly. Let's go again.".colorize(:cyan)
      puts "  "
      Country.clear_all
      Beach.clear_all
      list_continents
    elsif user_input.downcase == "no"
      puts "Catch you on the next wave!".colorize(:cyan)
      puts "  "
      exit
    else
      puts "Sorry, I didn't understand that entry.".colorize(:red)
      surf_again?
    end
  end

end
