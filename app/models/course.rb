class Course < ApplicationRecord
  has_many :materials, dependent: :destroy

  def duplicate
    # CourseDuplicationJob.perform_now(self)
    job = CourseDuplicationJob.perform_later(self)
    job.provider_job_id
  end
end
