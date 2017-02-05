class MaterialsController < ApplicationController
  before_action :set_material, only: [:edit, :update, :destroy]
  before_action :set_course, only: [:index, :new, :create]

  def index
    @materials = @course.materials.order('created_at')
  end

  def new
    @material = @course.materials.build
  end

  def edit
  end

  def create
    @material = @course.materials.build(material_params)
    if @material.save
      redirect_to course_materials_url(@material.course, @material), notice: 'Material was successfully created.'
    else
      render :new
    end
  end

  def update
    if @material.update(material_params)
      redirect_to course_materials_url(@material.course, @material), notice: 'Material was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @material.destroy
    redirect_to course_materials_url(@material.course, @material), notice: 'Material was successfully destroyed.'
  end

  private
    def set_material
      @material = Material.find(params[:id])
    end

    def material_params
      params.require(:material).permit(:name, :course_id, :file)
    end

    def set_course
      @course = Course.find(params[:course_id])
    end
end
