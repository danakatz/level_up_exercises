class CsvReader
  require 'csv'
  require 'json'
  require_relative 'dinosaur.rb'

  def self.get_dinos(files_array)
    dinos = []
    files_array.each do |file_name|
      CSV.foreach(file_name, headers: :first_row) do |csv_dino|
        dinos << make_dinosaur(csv_dino)
      end
    end

    dinos
  end

  def self.make_dinosaur(csv_dino)
    new_dino = Dinosaur.new(csv_dino['NAME'] || csv_dino['Genus'])
    new_dino.period = csv_dino['PERIOD'] || csv_dino['Period']
    new_dino.continent = csv_dino['CONTINENT'] || "Africa"
    new_dino.diet = parse_diet(csv_dino)
    new_dino.weight = parse_weight(csv_dino)
    new_dino.walk = csv_dino['WALKING'] || csv_dino['Walking']
    new_dino.desc = csv_dino['DESCRIPTION']

    new_dino
  end

  def self.parse_diet(csv_dino)
    if csv_dino['DIET']
      csv_dino['DIET']
    elsif csv_dino['Carnivore'] == "Yes"
      "Carnivore"
    elsif csv_dino['Carnivore'] == "No"
      "Herbivore"
    end
  end

  def self.parse_weight(csv_dino)
    if csv_dino['WEIGHT_IN_LBS']
      csv_dino['WEIGHT_IN_LBS'].to_i
    elsif csv_dino['Weight']
      csv_dino['Weight'].to_i
    end
  end
end
