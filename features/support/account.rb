class Account
  attr_reader :environments
  def initialize
    @environments = ['STG', 'PROD']
    # collections, variables, requests..
  end
end
