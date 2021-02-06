module Subjects
  class Create
    def initialize(params)
      @params = params.dup
    end

    def execute
      success(subject: Subject.create!(@params))
    rescue ActiveRecord::NotNullViolation => e
      failure(error: e.message)
    end

    private

    def success(result)
      @result = OpenStruct.new(result.merge(success?: true))
    end

    def failure(result)
      @result = OpenStruct.new(result.merge(success?: false))
    end
  end
end
