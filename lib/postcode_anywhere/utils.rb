require 'postcode_anywhere/request'

module PostcodeAnywhere
  module Utils
    def perform_with_object(request_method, path, options, klass, body_hash = {})
      request = PostcodeAnywhere::Request.new(self, request_method, path, body_hash, options)
      request.perform_with_object(klass)
    end

    def perform_with_objects(request_method, path, options, klass, body_hash = {})
      request = PostcodeAnywhere::Request.new(self, request_method, path, body_hash, options)
      request.perform_with_objects(klass)
    end
  end
end
