class Dinodex
  require_relative 'csv_reader.rb'
  require_relative 'dinosaur.rb'
  CSV_FILES = ['dinodex.csv', 'african_dinosaur_export.csv']

  def initialize(dinos = nil)
    dinos = CsvReader.get_dinos(CSV_FILES) if dinos.nil?
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
    results.select! { |dino| dino.weight ? dino.weight > 4000 : false }
    Dinodex.new(results)
  end

  def small
    results = @dino_list
    results.select! { |dino| dino.weight ? dino.weight <= 4000 : false }
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
    @dino_list.each(&:print)
  end
end

dinodex = Dinodex.new
dinodex.big.from_period("Cretaceous").search(walk: "biped").print
