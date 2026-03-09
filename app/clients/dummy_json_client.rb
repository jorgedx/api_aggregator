class DummyJsonClient
  include HTTParty

  base_uri 'https://dummyjson.com'
  default_timeout 5

  USERS_PATH  = "/users/"
  TODOS_PATH = "/todos/user/"

  def user_data(id)
    users_request id
  end

  def todos_user_data(id)
    todos_user_request id
  end

  private

  def users_request(id)
    request("#{USERS_PATH}#{id}")
  end

  def todos_user_request(id)
    request("#{TODOS_PATH}#{id}")
  end

  def request(path)
    response = self.class.get(path)
    
    return response if response.success?

    case response.code
    when 400
      raise ActionController::BadRequest, "Bad Request: #{path}"
    when 404
      raise ActiveRecord::RecordNotFound, "External Resource Not Found: #{path}"
    when 422
      raise ActiveRecord::RecordInvalid, "Unprocessable Entity: #{path}"
    else
      raise StandardError, "Error #{response.code}: #{path}"
    end
  rescue Net::OpenTimeout, Net::ReadTimeout => e
    Rails.logger.error("Timeout: #{e.message}")
    raise
  rescue StandardError => e
    Rails.logger.error("Error: #{e.message}")
    raise
  end
  
end