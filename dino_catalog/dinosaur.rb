class Dinosaur
  attr_accessor :name, :period, :continent, :diet
  attr_accessor :weight, :walking, :description

  def initialize(name)
    @name = name
  end

  def get(attribute)
    a = attribute.to_s.downcase
    instance_variables.each do |v|
      return instance_variable_get(v).to_s if v.to_s.include? a
    end
  end

  def print
    instance_variables.each { |v| print_var v }
    puts ""
  end

  def print_var(v)
    var_value = instance_variable_get(v).to_s
    var_key = v.to_s[1..-1].capitalize
    puts "#{var_key}: #{var_value}" unless var_value.empty?
  end
end
