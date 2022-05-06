class User < ActiveRecord::Base
    has_secure_password
    validates :email, presence: true, format: { with:  /\A[^@\s]+@[^@\s]+\z/, message: "Must be a valid email address." }
end
