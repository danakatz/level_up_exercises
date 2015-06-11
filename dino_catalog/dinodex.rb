class Dinodex
  require_relative 'csv_reader.rb'
  require_relative 'dinosaur.rb'
  CSV_FILES = ['dinodex.csv', 'african_dinosaur_export.csv']

  def initialize(dinos = nil)
    if dinos.nil? then dinos = CsvReader.get_dinos(CSV_FILES) end
    @dino_list = dinos
  end

  def bipeds
    search(walk: "biped")
  end

  def carnivores
    results = @dino_list
    results.select! { |dino| dino.diet != "Herbivore" }
    Dinodex.new(results)
  end

  def from_period(period)
    search(period: period)
  end

  def big
    results = @dino_list
    results.select! { |dino| if dino.weight then dino.weight > 4000 end }
    Dinodex.new(results)
  end

  def small
    results = @dino_list
    results.select! { |dino| if dino.weight then dino.weight <= 4000 end }
    Dinodex.new(results)
  end

  def search(params)
    results = @dino_list
    params.each do |key, value|
      results.select! { |dino| dino.get(key) =~ /\b#{value}\b/i }
    end
    Dinodex.new(results)
  end

  def print
    @dino_list.each { |dino| dino.print }
  end
end
