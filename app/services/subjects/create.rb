module Subjects
  class Create < BaseService
    def execute
      success(subject: Subject.create!(@params))
    rescue ActiveRecord::NotNullViolation => e
      failure(error: e.message)
    end
  end
end
