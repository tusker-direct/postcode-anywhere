describe PostcodeAnywhere::Client do
  before do
    @keys = PostcodeAnywhere::Configuration::VALID_CONFIG_KEYS
  end

  describe 'with module configuration' do
    before do
      PostcodeAnywhere.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      PostcodeAnywhere.reset
    end

    context 'when no credentials are provided' do
      it 'does not raise an exception' do
        expect { PostcodeAnywhere::Client.new }.not_to raise_error
      end
    end

    it 'should inherit module configuration' do
      api = PostcodeAnywhere::Client.new
      @keys.each do |key|
        expect(api.send(key)).to eq key
      end
    end

    describe 'with class configuration' do
      before do
        @config = {
          api_key:       'ak',
          format:        'of',
          endpoint:      'ep',
          user_agent:    'ua',
          method:        'hm'
        }
      end

      it 'should override module configuration' do
        api = PostcodeAnywhere::Client.new(@config)
        @keys.each do |key|
          expect(api.send(key)).to eq @config[key]
        end
      end

      it 'should override module configuration after' do
        api = PostcodeAnywhere::Client.new

        @config.each do |key, value|
          api.send("#{key}=", value)
        end

        @keys.each do |key|
          expect(api.send("#{key}")).to eq @config[key]
        end
      end
    end

    describe '#connection_options' do
      it 'returns the connection options hash with user_agent' do
        client = PostcodeAnywhere::Client.new(user_agent: 'My Test Gem')
        expect(client.connection_options[:headers][:user_agent]).to eql('My Test Gem')
      end
    end

    describe '#connection' do
      let(:connection_client) { PostcodeAnywhere::Client.new(endpoint: 'http://localhost') }
      it 'looks like Faraday connection' do
        expect(connection_client.send(:connection)).to respond_to(:run_request)
      end
    end

    describe '#request' do
      let(:connection_client) { PostcodeAnywhere::Client.new(endpoint: 'http://localhost') }
      it 'catches and reraises Faraday timeout errors' do
        allow(connection_client).to receive(:connection).and_raise(
          Faraday::Error::TimeoutError.new('execution expired')
        )
        expect { connection_client.send(:request, :get, '/path') }.to raise_error(
          PostcodeAnywhere::Error::RequestTimeout
        )
      end
      it 'catches and reraises Timeout errors' do
        allow(connection_client).to receive(:connection).and_raise(
          Timeout::Error.new('execution expired')
        )
        expect { connection_client.send(:request, :get, '/path') }.to raise_error(
          PostcodeAnywhere::Error::RequestTimeout
        )
      end
      it 'catches and reraises Faraday client errors' do
        allow(connection_client).to receive(:connection).and_raise(
          Faraday::Error::ClientError.new('connection failed')
        )
        expect { connection_client.send(:request, :get, '/path') }.to raise_error(
          PostcodeAnywhere::Error
        )
      end
      it 'catches and reraises JSON::ParserError errors' do
        allow(connection_client).to receive(:connection).and_raise(
          JSON::ParserError.new('unexpected token')
        )
        expect { connection_client.send(:request, :get, '/path') }.to raise_error(
          PostcodeAnywhere::Error
        )
      end
    end

    describe '#compile_body' do
      let(:connection_client) { PostcodeAnywhere::Client.new(endpoint: 'http://localhost') }
      it 'takes a hash of body params and returns them represented as a JSON string' do
        sample_hash = { 'test_item_1' => 'this_is_a_test_item' }
        expect(connection_client.send(:compile_body, sample_hash)).to eq(
          '{"test_item_1":"this_is_a_test_item"}'
        )
      end
    end

  end
end
