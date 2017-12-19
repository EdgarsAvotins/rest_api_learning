class User
  attr_reader :email, :password, :cookie
  def initialize
    @email = 'sx1234@inbox.lv'
    @password = 'Parole123'
    @cookie = {}
  end

  def set_cookie(cookie)
    @cookie = cookie
  end
end
