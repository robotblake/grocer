require 'delegate'
require_relative 'connection'

module Grocer
  class PushConnection < SimpleDelegator

    PRODUCTION_GATEWAY = 'gateway.push.apple.com'
    LOCAL_GATEWAY = '127.0.0.1'
    SANDBOX_GATEWAY = 'gateway.sandbox.push.apple.com'

    def initialize(options)
      options = defaults.merge(options)
      super(Connection.new(options))
    end

    private

    def defaults
      {
        gateway: find_default_gateway,
        port: 2195
      }
    end

    def find_default_gateway
      case Grocer.env
      when 'production'
        PRODUCTION_GATEWAY
      when 'test'
        LOCAL_GATEWAY
      else
        SANDBOX_GATEWAY
      end
    end

  end
end
