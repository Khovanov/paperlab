class Course < ApplicationRecord
  has_many :materials, dependent: :destroy

  def duplicate
    CourseDuplicationJob.perform_now(self)
  end
end
