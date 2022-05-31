class Customer < ActiveRecord::Base
    belongs_to :user
    validates :name, length: { minimum: 6 }
    validates :email,
              format: {with: /\A[^@\s]+@[^@\s]+\z/, message: "Enter the valid email address."},
              :presence => {:message => "can't be blank." },
              :uniqueness => {:message => "already exists."}
    validates :phone, presence: true, format: {with: /\A[7-9][0-9]{9}\z/, message:"Enter the valid phone number."}
    validates :address, length: { minimum: 4 }
    validates :user_id, presence: true

    def self.search(search)
        where("name LIKE ?", "%#{search}%")
    end

end
