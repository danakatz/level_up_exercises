module CSVReader
  require 'csv'
  require 'json'
  require_relative 'dinosaur'

  def get_dinos(files_array)
    dinos = []
    files_array.each do |file_name|
      CSV.foreach(file_name, headers: :first_row) do |csv_dino|
        dinos << make_dinosaur(csv_dino)
      end
    end

    dinos
  end

  def make_dinosaur(csv_dino)
    new_dino = Dinosaur.new(parse_name(csv_dino))
    new_dino.period = parse_period(csv_dino)
    new_dino.continent = parse_continent(csv_dino)
    new_dino.diet = parse_diet(csv_dino)
    new_dino.weight = parse_weight(csv_dino)
    new_dino.walking = parse_walking(csv_dino)
    new_dino.description = parse_desc(csv_dino)

    new_dino
  end

  def parse_name(csv_dino)
    csv_dino['NAME'] || csv_dino['Genus']
  end

  def parse_period(csv_dino)
    csv_dino['PERIOD'] || csv_dino['Period']
  end

  def parse_continent(csv_dino)
    csv_dino['CONTINENT'] || "Africa"
  end

  def parse_diet(csv_dino)
    if csv_dino['DIET']
      csv_dino['DIET']
    elsif csv_dino['Carnivore'] == "Yes"
      "Carnivore"
    elsif csv_dino['Carnivore'] == "No"
      "Herbivore"
    end
  end

  def parse_weight(csv_dino)
    if csv_dino['WEIGHT_IN_LBS']
      csv_dino['WEIGHT_IN_LBS'].to_i
    elsif csv_dino['Weight']
      csv_dino['Weight'].to_i
    end
  end

  def parse_walking(csv_dino)
    csv_dino['WALKING'] || csv_dino['Walking']
  end

  def parse_desc(csv_dino)
    csv_dino['DESCRIPTION']
  end
end
