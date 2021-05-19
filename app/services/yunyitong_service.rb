require 'net/http'
require 'net/https'

class YunyitongService < ApplicationService
  def initialize(user)
    @user = user
  end

  def create_user
    uri = URI('https://openapi.ctcfile.com/api/User/CreateThirdPartyUser')

    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    dict = {
      "thirdPartyUserId" => @user.id.to_s,
      "name" => @user.company&.name || @user.company_name || @user.email.split("@")[0]
    }
    body = JSON.dump(dict)
  
    # Create Request
    req =  Net::HTTP::Post.new(uri)
    # Add headers
    req.add_field "authorization", "Bearer #{access_token}"
    # Add headers
    req.add_field "Content-Type", "application/json; charset=utf-8"
    # Set body
    req.body = body
  
    # Fetch Request
    res = http.request(req)
    puts "Response HTTP Status Code: #{res.code}"
    puts "Response HTTP Response Body: #{res.body}"
  rescue StandardError => e
    puts "HTTP Request failed (#{e.message})"
  end

  def get_user_id
    uri = URI("https://openapi.ctcfile.com/api/User/GetUserInfo?thirdPartyUserId=#{@user.id}")

    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  
    # Create Request
    req =  Net::HTTP::Get.new(uri)
    # Add headers
    req.add_field "authorization", "Bearer #{access_token}"
  
    # Fetch Request
    res = http.request(req)
    puts "Response HTTP Status Code: #{res.code}"
    puts "Response HTTP Response Body: #{res.body}"
    JSON.parse(res.body)["data"]["openId"]
  rescue StandardError => e 
    puts "HTTP Request failed (#{e.message})"
  end

  def create_chat(company_user_id, language = 'zh-CN')
    uri = URI("https://chatservice.ctcfile.com/Chat/CreateConversation")
    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    dict = {
      "userId" => company_user_id,
      "lang" => language
    }
    body = JSON.dump(dict)

    # Create Request
    req =  Net::HTTP::Post.new(uri)
    # Add headers
    req.add_field "authorization", "Bearer #{user_token}"
    # Add headers
    req.add_field "Content-Type", "application/json; charset=utf-8"
    # Set body
    req.body = body

    # Fetch Request
    res = http.request(req)
    puts "Response HTTP Status Code: #{res.code}"
    puts "Response HTTP Response Body: #{res.body}"
  rescue StandardError => e
    puts "HTTP Request failed (#{e.message})"
  end

  def user_token
    uri = URI("https://openapi.ctcfile.com/api/User/GetIdentityToken?thirdPartyUserId=#{@user.id}")

    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  
    # Create Request
    req =  Net::HTTP::Get.new(uri)
    # Add headers
    req.add_field "authorization", "Bearer #{access_token}"
  
    # Fetch Request
    res = http.request(req)
    puts "Response HTTP Status Code: #{res.code}"
    puts "Response HTTP Response Body: #{res.body}"
    JSON.parse(res.body)["access_token"]
  rescue StandardError => e
    puts "HTTP Request failed (#{e.message})"
  end
  
  private
  def access_token
    uri = URI('https://openapi.ctcfile.com/OAuth/ClientCredentialsToken?clientId=7BVCYXtFzFXBMCFDTbm0Fn0GIC1HUiyU&clientSecret=6a06ab05-28a7-ccc9-7393-8ccf0be8f1ae')
  
    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  
    # Create Request
    req =  Net::HTTP::Get.new(uri)
    # Add headers
    req.add_field "Content-Type", "application/json; charset=utf-8"
    # Fetch Request
    res = http.request(req)
    puts "Response HTTP Status Code: #{res.code}"
    puts "Response HTTP Response Body: #{res.body}"
    JSON.parse(res.body)["access_token"]
  rescue StandardError => e
    puts "HTTP Request failed (#{e.message})"
  end

end