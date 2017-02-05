class Course < ApplicationRecord
  has_many :materials, dependent: :destroy
end
