require 'test/unit'
include Test::Unit::Assertions
class Login
  def initialize(api)
    @api = api
  end

  def test_login
    @login = "sx1234@inbox.lv"
    @password = "Parole123"
    @login_payload = { login: "sx1234@inbox.lv",
                      password: "Parole123" }.to_json
    url = "https://www.apimation.com/login"
    headers = {"Content-Type" => 'application/json'}
    @login_response = @api.post(url, headers: headers, payload: @login_payload)
  end

  def validate_login_response
    code = @login_response.code
    raise "Unsuccessful login, #{code}" unless code == 200

    response_hash = JSON.parse(@login_response)
    assert_equal(response_hash['email'], @login, "Response email is #{response_hash['email']} instead of #{@login}")
  end

  def log_in
    login_payload = { login: "sx1234@inbox.lv",
                      password: "Parole123" }.to_json
    url = "https://www.apimation.com/login"
    headers = {"Content-Type" => 'application/json'}
    @login_response = @api.post(url, headers: headers, payload: login_payload)
    @login_cookie = @login_response.cookies
  end

  def add_environments(environments)
    @given_environments = environments.raw
    @responses = []
    environments.raw.each do |env|
      p env[0]
      add_environment_payload = {"name":"#{env[0]}"}.to_json
      url = "https://www.apimation.com/environments"
      headers = {"Content-Type" => 'application/json'}
      add_env_response = @api.post(url, headers: headers, payload: add_environment_payload, cookies: @login_cookie)
      @responses.push(add_env_response)
    end
  end

  def validate_environment_responses
    env_counter = 0
    full_error = ''
    @responses.each do |response|
      code = response.code
      unless code == 200
        full_error = full_error +
                     "Could not add env #{@given_environments[env_counter]}, #{code}" +
                     "\n" +
                     "#{JSON.parse(response)}" +
                     "\n\n"
      end
      env_counter += 1
    end
    raise full_error unless full_error == ''

    @env_ids = []
    @responses.each do |response|
      response_hash = JSON.parse(response)
      @env_ids.push(response_hash['id'])
    end
    p @env_ids
  end

  def add_global_variables
    @env_ids.each do |env_id|
      payload = {"global_vars":[{"key":"$first_var","value":"first_value"},{"key":"$second_var","value":"second_value"},{"key":"","value":""}]}.to_json
      url = "https://www.apimation.com/environments/#{env_id}"
      headers = {"Content-Type" => 'application/json'}
      add_variables_response = @api.put(url, headers: headers, payload: payload, cookies: @login_cookie)
      p add_variables_response
      code = add_variables_response.code
      add_variables_response_hash = JSON.parse(add_variables_response)
      raise "Did not add variables, #{code} \n #{add_variables_response_hash}" unless code == 200
    end
  end

  def delete_environments
    @del_env_responses = []
    @env_ids.each do |env_id|
      url = "https://www.apimation.com/environments/#{env_id}"
      headers = {"Content-Type" => 'application/json'}
      del_env_response = @api.del(url, headers: headers, cookies: @login_cookie)
      @del_env_responses.push(del_env_response)
    end
  end

  def validate_environments_deleted
    env_counter = 0
    full_error = ''
    @del_env_responses.each do |response|
      code = response.code
      p response
      unless code == 200
        full_error = full_error +
                     "Could not add env #{@given_environments[env_counter]}, #{code}" +
                     "\n" +
                     "#{JSON.parse(response)}" +
                     "\n\n"
      end
      env_counter += 1
    end
    raise full_error unless full_error == ''
  end
end
