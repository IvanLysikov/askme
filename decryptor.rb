require 'cgi'
require 'json'
require 'active_support'

def decrypt (cookie)
  cookie = CGI::unescape(cookie)
  salt = "authenticated encrypted cookie"
  encrypted_cookie_cipher = "aes-256-gcm"
  serializer = ActiveSupport::MessageEncryptor::NullSerializer

  secret_key_base = File.read("tmp/development_secret.txt")
  key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
  key_len = ActiveSupport::MessageEncryptor.key_len(encrypted_cookie_cipher)
  secret = key_generator.generate_key(salt, key_len)
  encryptor = ActiveSupport::MessageEncryptor.new(secret, cipher: encrypted_cookie_cipher, serializer: serializer)
  session_key = "_askme_session"
  encryptor.decrypt_and_verify(cookie, purpose: "cookie.#{session_key}")
end


def verify_and_decrypt_session_cookie(cookie, secret_key_base = File.read("tmp/development_secret.txt"))
  cookie = CGI::unescape(cookie)
  salt   = "authenticated encrypted cookie"
  encrypted_cookie_cipher = 'aes-256-gcm'
  # serializer = ActiveSupport::MessageEncryptor::NullSerializer # use this line if you don't know your serializer
  serializer = ActiveSupport::MessageEncryptor::NullSerializer

  key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
  key_len = ActiveSupport::MessageEncryptor.key_len(encrypted_cookie_cipher)
  secret = key_generator.generate_key(salt, key_len)
  encryptor = ActiveSupport::MessageEncryptor.new(secret, cipher: encrypted_cookie_cipher, serializer: serializer)

  session_key = "_askme_session"
  encryptor.decrypt_and_verify(cookie, purpose: "cookie.#{session_key}")
end

puts "enter cookie:"
cookie = gets.chomp

result = verify_and_decrypt_session_cookie(cookie)

puts result.inspect

