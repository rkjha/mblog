require 'digest'
class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password
	before_save :create_remember_token
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, :presence => true, :length => {:maximum => 50}
	validates :email, :presence => true,
					  :format => {:with => email_regex},
					  :uniqueness => {:case_sensitive => false}

	validates :password, length: {minimum: 6}
	validates :password_confirmation, presence: true

	private

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end

end
#	before_save :encrypt_password
#	def has_password?(submitted_password)
		#encrypt the submitted password
#		encrypted_password = encrypt(submitted_password)
#	end

#	def self.authenticate(email, submitted_password)
#		user = find_by_email(email)
#		return nil if user.nil?
#		return user if user.has_password?(submitted_password)
#	end

##	def authenticate_with_salt(id, cookie_salt)
#		user = find_by_id(id)
#		(user && user.salt == cookie_salt) ? user : nil
#	end

##	private

##		def encrypt_password
#			self.salt = make_salt if new_record?
#			self.encrypted_password = encrypt(password)
#		end

###		def encrypt(string)
#			#Create a hash with string
#			secure_hash("#{salt}--#{string}")
#		end
#		def make_salt
#			secure_hash("#{Time.now.utc}--#{password}")
#		end
#		def secure_hash(string)
#			Digest::SHA2.hexdigest(string)
#		end
