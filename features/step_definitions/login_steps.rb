require_relative 'login'
When(/^I try to log in Apimation$/) do
  @test_login.test_login
end

Then(/^I get a positive response$/) do
  @test_login.validate_login_response
end

Given(/^I log in$/) do
  @test_login.log_in
end

When(/^I add new environments:$/) do |table|
  @test_login.add_environments(table)
end

Then(/^environments have been added$/) do
  @test_login.validate_environment_responses
end

And(/^I add global variables$/) do
  @test_login.add_global_variables
end

When(/^I delete environments$/) do
  @test_login.delete_environments
end

Then(/^environments are successfully deleted$/) do
  @test_login.validate_environments_deleted
end
