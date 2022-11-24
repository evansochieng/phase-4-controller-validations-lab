class Author < ApplicationRecord
    #validations 
    validates :name, presence: true
    validates :email, uniqueness: true
end
