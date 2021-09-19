module ApiHelper
  def auth_headers(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    # Returns authentication headers needed by devise-token-auth (access-token, client, uid, expiry and token-type)
    headers.merge!(user.create_new_auth_token)
  end
end
