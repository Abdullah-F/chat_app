module Requests
  module Helpers
    def json_response
      case body = JSON.parse(response.body)
      when Hash
        body.with_indifferent_access
      when Array, Integer
        body
      end
    end
  end
end
