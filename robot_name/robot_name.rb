NameCollisionError = Class.new(RuntimeError)
NameFormatError = Class.new(RuntimeError)

class Robot
  require 'set'
  attr_accessor :name

  def self.registry
    @registry ||= Set.new
  end

  def self.add_to_registry(name)
    unless @registry.add? name
      raise NameCollisionError, "That name is already taken!"
    end
  end

  def initialize(args = {})
    @name_generator = args[:name_generator]
    @name_generator ? @name = @name_generator.call : assign_random_name
    validate_name_format
    self.class.add_to_registry name
  end

  def assign_random_name
    until name && !self.class.registry.include?(name)
      @name = NameGenerator.generate_name
    end
  end

  def validate_name_format
    unless name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
      raise NameFormatError, "Invalid name format!"
    end
  end
end

class NameGenerator
  def self.generate_name
    "#{generate_chars}#{generate_nums}"
  end

  def self.generate_chars
    chars = ""
    2.times do
      chars << ('A'..'Z').to_a.sample
    end
    chars
  end

  def self.generate_nums
    nums = ""
    3.times do
      nums << rand(10).to_s
    end
    nums
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him Sparky."

# Format Error
# generator = -> { 'B2' }
# Robot.new(name_generator: generator)

# Collision Error
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
