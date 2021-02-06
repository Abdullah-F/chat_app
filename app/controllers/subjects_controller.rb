class SubjectsController < ApplicationController
  def create
    subject = Subject.create(name: params[:name])
    render json: subject.as_json(except: [:id]), status: :created
  end
end
