require_relative "../../models/bomb.rb"

Given (/^the bomb is (\w+)$/) do |status|
  @bomb ||= Bomb.new
  @bomb.active = true if status == 'active'
  @bomb.active = false if status == 'inactive'
  @start_active = @bomb.active
end

Given(/^a new bomb$/) do
  @bomb = Bomb.new
end

Then (/^the status indicator should say "This bomb is (\w+)"/) do |display|
  expect(@bomb.status).to eq(display)
end

When (/^a user inputs the correct activation code$/) do
  @bomb.input_code(@bomb.act_code)
end

Then (/^the bomb should become active$/) do
  expect(@start_active).to be false
  expect(@bomb.active).to be true
end

When (/^a user inputs an incorrect activation code$/) do
  @bomb.input_code(wrong_code)
end

When (/^a user inputs a code other than the deactivation code$/) do
  @bomb.input_code(wrong_code)
end

Then (/^the bomb should do nothing$/) do
  expect(@bomb.active).to equal(@start_active)
end

When (/^a user inputs the correct deactivation code$/) do
  @bomb.input_code(@bomb.deact_code)
end

Then (/^the bomb should become inactive$/) do
  expect(@start_active).to be true
  expect(@bomb.active).to be false
end

When (/^a user inputs an incorrect deactivation code$/) do
  @bomb.input_code(wrong_code)
end

When(/^a user sets a new (\w+) code$/) do |code_type|
  @new_code = wrong_code
  if code_type == "activation"
    @bomb.set_activation_code @new_code
  elsif code_type == "deactivation"
    @bomb.set_deactivation_code @new_code
  end
end

Then(/^the bomb should have the new (\w+) code$/) do |code_type|
  if code_type == "activation"
    expect(@bomb.act_code).to eq(@new_code)
  elsif code_type == "deactivation"
    expect(@bomb.deact_code).to eq(@new_code)
  end
end

When(/^a user sets the (\w+) code to nil$/) do |code_type|
  if code_type == "activation"
    @old_code = @bomb.act_code
    @bomb.set_activation_code(nil)
  elsif code_type == "deactivation"
    @old_code = @bomb.deact_code
    @bomb.set_deactivation_code(nil)
  end
end

When(/^a user sets the (\w+) code to empty$/) do |code_type|
  if code_type == "activation"
    @old_code = @bomb.act_code
    @bomb.set_activation_code("")
  elsif code_type == "deactivation"
    @old_code = @bomb.deact_code
    @bomb.set_deactivation_code("")
  end
end

Then(/^the bomb should keep its original (\w+) code$/) do |code_type|
  if code_type == "activation"
    expect(@bomb.act_code).to eq(@old_code)
  elsif code_type = "deactivation"
    expect(@bomb.deact_code).to eq(@old_code)
  end
end

def wrong_code
  wrong_code = ((@bomb.act_code.to_i + @bomb.deact_code.to_i) / 2) + 2
  wrong_code.to_s
end
