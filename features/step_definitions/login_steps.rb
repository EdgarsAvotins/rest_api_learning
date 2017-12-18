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

When(/^I delete all environments$/) do
  @test_login.delete_all_environments
end

When(/^I add collection$/) do
  @test_login.add_collection('TESTAPIb')
end

Then(/^collection was added successfully$/) do
  @test_login.validate_collection_added
end

When(/^I add request to this collection$/) do
  @test_login.add_request_to_collection
end

Then(/^request was added successfully$/) do
  @test_login.validate_added_request
end
