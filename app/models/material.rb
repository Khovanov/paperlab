class Material < ApplicationRecord
  belongs_to :course
  has_attached_file :file, styles: { thumb: "100x>" }
  do_not_validate_attachment_file_type :file
  # validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
