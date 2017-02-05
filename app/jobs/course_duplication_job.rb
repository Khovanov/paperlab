class CourseDuplicationJob < ApplicationJob
  queue_as :default

  def perform(course)
    copy_course = course.dup
    copy_course.name = "Copy of #{course.name}"
    copy_course.save

    # copy_course.materials = course.materials.map &:dup
    copy_course.materials = course.materials.map do |material|
      copy_material = material.dup
      copy_material.file = material.file
      copy_material
    end
    # Rails.logger.debug copy_course.inspect
    # Rails.logger.debug copy_course.materials.each &:inspect
  end
end
