module Squall
  class Hypervisor < Client

    URI_PREFIX = 'settings/hypervisors'

    def list
      if get(URI_PREFIX)
        @message.collect { |res| res['hypervisor'] }
      else
        []
      end
    end

    def show(id)
      get("#{URI_PREFIX}/#{id}") ? @response['hypervisor'] : false
    end

    def create(params = {})
      required = { :ip_address, :label }
      required_options!(required, params)
      post(URI_PREFIX, { :hypervisor => params })
      @response.code == 201
    end

    def destroy(id)
      delete("#{URI_PREFIX}/#{id}")
    end

  end
end