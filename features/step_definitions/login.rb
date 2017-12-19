require 'test/unit'
include Test::Unit::Assertions
class Login
  def initialize(api)
    @api = api
    @user = User.new
  end

  def test_login
    @login_payload = { login: @user.email,
                      password: @user.password }.to_json
    url = "https://www.apimation.com/login"
    headers = {"Content-Type" => 'application/json'}
    @login_response = @api.post(url, headers: headers, payload: @login_payload)
    @user.set_cookie(@login_response.cookies)
  end

  def validate_login_response
    code = @login_response.code
    raise "Unsuccessful login, #{code}" unless code == 200

    response_hash = JSON.parse(@login_response)
    assert_equal(response_hash['email'], @user.email, "Response email is #{response_hash['email']} instead of #{@user.email}")
  end

  def log_in
    login_payload = { login: "sx1234@inbox.lv",
                      password: "Parole123" }.to_json
    url = "https://www.apimation.com/login"
    headers = {"Content-Type" => 'application/json'}
    @login_response = @api.post(url, headers: headers, payload: login_payload)
    code = @login_response.code
    raise "Unsuccessful login, #{code}" unless code == 200
    @user.set_cookie(@login_response.cookies)
  end

  def add_environments(environments)
    @given_environments = environments.raw
    @responses = []
    environments.raw.each do |env|
      add_environment_payload = {"name":"#{env[0]}"}.to_json
      url = "https://www.apimation.com/environments"
      headers = {"Content-Type" => 'application/json'}
      add_env_response = @api.post(url, headers: headers, payload: add_environment_payload, cookies: @user.cookie)
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
  end

  def add_global_variables
    @env_ids.each do |env_id|
      payload = {"global_vars":[{"key":"$first_var","value":"first_value"},{"key":"$second_var","value":"second_value"},{"key":"","value":""}]}.to_json
      url = "https://www.apimation.com/environments/#{env_id}"
      headers = {"Content-Type" => 'application/json'}
      add_variables_response = @api.put(url, headers: headers, payload: payload, cookies: @user.cookie)
      code = add_variables_response.code
      raise "Did not add variables, #{code} \n #{add_variables_response}" unless code == 204
    end
  end

  def delete_environments
    @del_env_responses = []
    env_ids = get_env_ids
    unless env_ids.empty?
      env_ids.each do |hash|
        id = hash['id']
        url = "https://www.apimation.com/environments/#{id}"
        headers = {"Content-Type" => 'application/json'}
        del_env_response = @api.del(url, headers: headers, cookies: @user.cookie)
        @del_env_responses.push(del_env_response)
      end
    end
  end

  def get_env_ids
    url = "https://www.apimation.com/environments"
    response = @api.get(url, cookies: @user.cookie)
    return JSON.parse(response)
  end

  def validate_environments_deleted
    env_counter = 0
    full_error = ''
    @del_env_responses.each do |response|
      code = response.code
      unless code == 204
        full_error = full_error +
                     "Could not delete env #{@given_environments[env_counter]}, #{code}" +
                     "\n" +
                     "#{response}" +
                     "\n\n"
      end
      env_counter += 1
    end
    raise full_error unless full_error == ''
  end

  def delete_all_environments
    url = "https://www.apimation.com/environments"
    response = @api.get(url, cookies: @user.cookie)
    response_hash = JSON.parse(response)
    response_hash.each do |env|
      name = env['name']
      id = env['id']
      url = "https://www.apimation.com/environments/#{id}"
      headers = {"Content-Type" => 'application/json'}
      del_env_response = @api.del(url, headers: headers, cookies: @user.cookie)
    end
  end

  def add_collection(name)
    url = "https://www.apimation.com/collections"
    payload = {"name":"#{name}","description":""}.to_json
    @collection_response = @api.post(url, payload: payload, cookies: @user.cookie)
    hash = JSON.parse(@collection_response)
    @collection_id = hash['id']
  end

  def validate_collection_added
    code = @collection_response.code
    hash = JSON.parse(@collection_response)
    raise "Unlucky, #{code}, #{hash}" unless code == 200
  end

  def add_request_to_collection
    url = "https://www.apimation.com/steps"
    headers = {"Content-Type" => 'application/json'}
    payload = {"name":"login","description":"request for logging in apimation.. inception or smth",
              "request":
                {"method":"GET","url":"https://www.apimation.com/login","type":"raw","body":"{login:#{@user.email},password:#{@user.password}}","binaryContent":
                  {"value":"","filename":""},
                "urlEncParams":
                  [{"name":"","value":""}],
                "formData":
                  [{"type":"text","value":"","name":"","filename":""}],
                "headers":
                  [{"name":"Content-Type","value":"application/json"}],
                "greps":[],
                "auth":
                  {"type":"noAuth","data":{}}
                },
              "paste":false,"collection_id":"#{@collection_id}"}.to_json
    @add_request_response = @api.post(url, headers: headers, payload: payload, cookies: @user.cookie)
  end

  def validate_added_request
    code = @add_request_response.code
    raise "Did not add request, #{code} \n #{@add_variables_response}" unless code == 200
  end

  def delete_collections
    collection_ids = get_collection_ids
    unless collection_ids.empty?
      collection_ids.each do |hash|
        url = "https://www.apimation.com/collections/#{hash['id']}"
        response = @api.del(url, cookies: @user.cookie)
        code = response.code
        raise "not deleted, #{code}" unless code == 204
      end
    end
  end

  def get_collection_ids
    url = "https://www.apimation.com/collections"
    response = @api.get(url, cookies: @user.cookie)
    return JSON.parse(response)
  end
end
