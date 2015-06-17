class Bomb
  attr_accessor :active, :act_code, :deact_code

  def initialize(active = false)
    @active = active
    @act_code = "1234"
    @deact_code = "0000"
  end

  def input_code(code)
    @active = true if code == act_code
    @active = false if code == deact_code
  end

  def set_activation_code(code)
    @act_code = code unless code.nil? || code == ""
  end

  def set_deactivation_code(code)
    @deact_code = code unless code.nil? || code == ""
  end

  def status
    if active
      "ACTIVE"
    else
      "INACTIVE"
    end
  end
end
