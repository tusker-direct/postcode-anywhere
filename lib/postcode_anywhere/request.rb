module PostcodeAnywhere
  class Request
    attr_accessor :client, :request_method, :path, :body, :options
    alias_method :verb, :request_method

    def initialize(client, request_method, path, body_hash = {}, options = {})
      @client = client
      @request_method = request_method.to_sym
      @path = path
      @body_hash = body_hash
      @options = options
    end

    def perform
      @client.send(@request_method, @path, @body_hash, @options).body
    end

    def perform_with_object(klass)
      result = perform
      if result.class == Array
        klass.new(result.first)
      else
        klass.new(result)
      end
    end

    def perform_with_objects(klass)
      perform.map do |element|
        klass.new(element)
      end
    end
  end
end
