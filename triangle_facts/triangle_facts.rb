# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def equilateral?
    side1 == side2 && side2 == side3
  end

  def isosceles?
    [side1, side2, side3].uniq.length == 2
  end

  def scalene?
    !(equilateral? || isosceles?)
  end

  def right?
    angles.include? 90
  end

  def angles
    calculate_angles(side1, side2, side3)
  end

  def recite_facts
    puts type_info
    puts "The angles of this triangle are #{angles.join(', ')}."
    puts "This triangle is also a right triangle!" if right?
    puts ""
  end

  def type_info
    return "This triangle is equilateral!" if equilateral?
    return "This triangle is isosceles!" if isosceles?
    return "This triangle is scalene and mathematically boring." if scalene?
  end

  def calculate_angles(a, b, c)
    angle_a = radians_to_degrees(angle_in_degrees(b, c, a))
    angle_b = radians_to_degrees(angle_in_degrees(a, c, b))
    angle_c = radians_to_degrees(angle_in_degrees(a, b, c))

    [angle_a, angle_b, angle_c]
  end

  def angle_in_degrees(a, b, c)
    Math.acos((a**2 + b**2 - c**2) / (2.0 * a * b))
  end

  def radians_to_degrees(rads)
    (rads * 180 / Math::PI).round
  end
end

triangles = [
  Triangle.new(5, 5, 5),
  Triangle.new(5, 12, 13),
]

triangles.each(&:recite_facts)
