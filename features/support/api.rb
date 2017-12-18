require 'rest-client'

class Api
  def post(url, payload: data, headers: {}, cookies: {})
    RestClient::Request.execute(
      method: :post,
      url: url,
      payload: payload,
      headers: headers,
      cookies: cookies
    ) do |response|
      response
    end
  end

  def put(url, payload: data, headers: {}, cookies: {})
    RestClient::Request.execute(
      method: :put,
      url: url,
      payload: payload,
      headers: headers,
      cookies: cookies
    ) do |response|
      response
    end
  end

  def get(url, headers: {}, cookies: {})
    RestClient::Request.execute(
      method: :get,
      url: url,
      headers: headers,
      cookies: cookies
    ) do |response|
      response
    end
  end

  def del(url, headers: {}, cookies: {})
    RestClient::Request.execute(
      method: :delete,
      url: url,
      headers: headers,
      cookies: cookies
    ) do |response|
      response
    end
  end
end
