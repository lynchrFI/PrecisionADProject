class User < ActiveRecord::Base
    has_many :clients
    has_many :products
    has_secure_password
    validates :username, uniqueness: true
    validates :password
end
