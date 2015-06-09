NameCollisionError = Class.new(RuntimeError)
NameFormatError = Class.new(RuntimeError)

class Robot
  attr_accessor :name

  def initialize(args = {})
    @@registry ||= []
    @name_generator = args[:name_generator]

    if @name_generator
      @name = @name_generator.call 
    else
      until (name && !@@registry.include?(name))
        @name = NameGenerator.generate_name
      end
    end

    validate_name
    @@registry << name
  end

  def validate_name
    unless (name =~ /[[:alpha:]]{2}[[:digit:]]{3}/)
      raise NameFormatError, "There was a problem generating the robot name!"
    end

    if @@registry.include?(name)
      raise NameCollisionError, "There was a problem generating the robot name!"
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
    return chars
  end

  def self.generate_nums
    nums = ""
    3.times do
      nums << rand(10).to_s
    end
    return nums
  end
end

robot = Robot.new
puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Format Error
# generator = -> { 'B2' }
# Robot.new(name_generator: generator)

# Collision Error
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
