class BaseService
    class <<self
      def execute(params)
        self.new(params).execute
      end
    end

    def initialize(params)
      @params = params.dup
    end

    def execute
      raise NotImplementedError, "Execute Method Is Not Implemented"
    end

    private

    def success(result)
      @result = OpenStruct.new(result.merge(success?: true))
    end

    def failure(result)
      @result = OpenStruct.new(result.merge(success?: false))
    end
end
