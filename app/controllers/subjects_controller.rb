class SubjectsController < ApplicationController
  def create
    subject = Subject.create(name: create_params[:name])
    render json: subject.as_json(except: [:id]), status: :created
  rescue ActionController::ParameterMissing => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def create_params
    params.require(:name)
    params.permit(:name)
  end
end
