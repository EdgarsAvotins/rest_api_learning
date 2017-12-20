Before do
  api = Api.new
  @test_login = Login.new(api)
end

After do
  @test_login.delete_environments
  @test_login.delete_collections
end
