class Dinosaur
  attr_accessor :name
  attr_accessor :period
  attr_accessor :continent
  attr_accessor :diet
  attr_accessor :weight
  attr_accessor :walk
  attr_accessor :desc

  def initialize(name)
    @name = name
  end

  def get(attribute)
    a = attribute.to_s.downcase
    case
    when a.include?("name")
      name
    when a.include?("period")
      period
    when a.include?("continent")
      continent
    when a.include?("diet")
      diet
    when a.include?("weight")
      weight
    when a.include?("walk")
      walk
    when a.include?("desc")
      description
    else
      raise ArgumentError, "Dinos don't have the '#{attribute}' attribute."
    end
  end

  def print
    puts "Name: #{name}" if name
    puts "Period: #{period}" if period
    puts "Continent: #{continent}" if continent
    puts "Diet:  #{diet}" if diet
    puts "Weight in LBS: #{weight}" if weight
    puts "Walking: #{walk}" if walk
    puts "Description: #{desc}" if desc
    puts ""
  end
end
