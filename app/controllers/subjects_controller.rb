class SubjectsController < ApplicationController
  def create
    result = ::Subjects::Create.execute(create_params)
    if result.success?
      render json: result.subject.as_json(except: [:id]), status: :created
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:name)
    params.permit(:name)
  end
end
