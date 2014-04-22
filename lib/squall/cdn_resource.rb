module Squall
  # OnApp User
  class CdnResource < Base
    # Return a list of all users
    def list
      response = request(:get, '/cdn_resources.json')
      response["cdn_resources"]
    end

    # Get the billing stats for a given resource
    #
    # ==== Params
    #
    # * +id*+ - ID of user
    def billing(id, options = {})
      request(:get, "/cdn_resources/#{id}/billing.json", { :query => options } )
    end
  end
end
