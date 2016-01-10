require 'fastly'

module FastlyRails
  # A simple wrapper around the fastly-ruby client.
  class Client < DelegateClass(Fastly)
    def initialize(opts={})
      super(Fastly.new(opts))
    end

    def purge_by_key(key)
      client.require_key!

      FastlyRails.service_id.each do |service_id|
        client.post purge_url(key, service_id)
      end
    end

    def purge_url(key, service_id)
      "/service/#{service_id}/purge/#{key}"
    end
  end
end
