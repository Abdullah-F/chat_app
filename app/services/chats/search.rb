module Chats
  class Search < BaseService
    def execute
      result = Message.search(
        @params[:body],
        fields: [:body],
        match: :text_middle,
        where: { subject: @params[:subject_token], chat: @params[:order] }
      ).to_a
      success(records: result.to_a)
    end

    private
  end
end
