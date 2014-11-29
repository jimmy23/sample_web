class User < ActiveRecord::Base
	attr_accessor :password

	before_save :encrypt_password

	validates_presence_of :password, on: :create
	validates_confirmation_of :password
	validates_presence_of :nickname
	validates_uniqueness_of :nickname

	def self.authenticate(nickname, password)
		user = find_by_nickname(nickname)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

end
