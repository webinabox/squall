module Squall
  class VirtualMachine < Client

    URI_PREFIX = 'virtual_machines'

    def list
      servers = []
      if get(URI_PREFIX)
        @response.each { |res| servers.push(res['virtual_machine']) }
        servers
      else
        false
      end
    end

    def show(id)
      begin
        get("#{URI_PREFIX}/#{id}") ? @response['virtual_machine'] : false
      rescue RestClient::ResourceNotFound
        false
      end
    end

    def edit(id, params = {})
      valid = [ :primary_network_id, 
                :cpus, 
                :label, 
                :cpu_shares, 
                :template_id, 
                :swap_disk_size,
                :memory, 
                :required_virtual_machine_build, 
                :hypervisor_id, 
                :required_ip_address_assignment,
                :rate_limit, 
                :primary_disk_size,
                :hostname,
                :initial_root_password ]
      valid_options!(valid, params)
     
      begin 
        put("#{URI_PREFIX}/#{id}", { :virtual_machine => params }) 
      rescue RestClient::ResourceNotFound
        false
      end
    end

    def create(params = {})
      required = { :memory, :cpus, :label, :template_id, :hypervisor_id, :initial_root_password }
      required_options!(required, params)
      parse(post(URI_PREFIX, { :virtual_machine => params }), 201)
    end

    def destroy(id)
      begin
        delete("#{URI_PREFIX}/#{id}")
      rescue RestClient::ResourceNotFound
        false
      end
    end
  end
end