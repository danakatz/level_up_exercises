require_relative "../../models/bomb.rb"
require_relative "../../overlord.rb"
require 'capybara/cucumber'

Capybara.app = Overlord

Given(/^the bomb has been configured with default activation codes$/) do
  configure_default
end

When(/^the user inputs the default activation code$/) do
  enter_default_activation
end

When(/^the user inputs the default deactivation code$/) do
  enter_default_deactivation
end

Then(/^the status indicator should say "([^"]*)"$/) do |status|
  page.has_content?(status)
end

When(/^the user inputs an incorrect activation code$/) do
  enter_incorrect_default_code
end

When(/^the user inputs an incorrect deactivation code$/) do
  enter_incorrect_default_code
end

Given(/^the bomb is active$/) do
  activate_bomb_default
end

When(/^the user inputs three consecutive incorrect deactivation codes$/) do
  3.times { enter_incorrect_default_code }
end

Then(/^the bomb should explode$/) do
  page.has_xpath?("//img[contains(@src,'explosion-clipart-clipart-2118.svg')]")
end

When(/^the user visits the home page for the first time$/) do
  visit('/')
end

Then(/^they should see the configure page$/) do
  page.has_content?('Configure Your Bomb')
end

Given(/^the bomb has been configured$/) do
  configure_default
end

Then(/^the page should have a text field for entering a code$/) do
  find_field('code').visible?
end

Then(/^there should be a text field for the (\w+) code$/) do |code_type|
  if code_type == "actvation"
    find_field('act_code').visible?
  elsif code_type == "deactivation"
    find_field('deact_code').visible?
  end
end

Given(/^the configure page is visible$/) do
  visit('/')
end

When(/^the user leaves the activation code blank$/) do
  submit_blank_activation
end

When(/^the user leaves the deactivation code blank$/) do
  submit_blank_deactivation
end

When(/^the user submits a new activation code$/) do
  submit_new_activation
end

When(/^the user inputs the new activation code$/) do
  enter_new_activation
end

When(/^the user submits a new deactivation code$/) do
  submit_new_deactivation
end

When(/^the user inputs the new deactivation code$/) do
  enter_new_deactivation
end

def configure_default
  visit('/')
  click_button('SAVE')
end

def enter_default_activation
  fill_in('code', :with => '1234')
  click_button('GO')
end

def enter_default_deactivation
  fill_in('code', :with => '0000')
  click_button('GO')
end

def enter_incorrect_default_code
  fill_in('code', :with => '4321')
  click_button('GO')
end

def activate_bomb_default
  configure_default
  enter_default_activation
end

def submit_blank_activation
  fill_in('act_code', :with => '')
  click_button('SAVE')
end

def submit_blank_deactivation
  fill_in('deact_code', :with => '')
  click_button('SAVE')
end

def submit_new_activation
  fill_in('act_code', :with => '2222')
  click_button('SAVE')
end

def enter_new_activation
  fill_in('code', :with => '2222')
  click_button('GO')
end

def submit_new_deactivation
  fill_in('deact_code', :with => '3333')
  click_button('SAVE')
end

def enter_new_deactivation
  fill_in('code', :with => '3333')
  click_button('GO')
end

