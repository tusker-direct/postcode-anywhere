describe PostcodeAnywhere::Error do
  before do
    @client = PostcodeAnywhere::CleansePlus::Client.new(api_key: 'error_test_key')
  end

  describe '#message' do
    it 'returns the error message' do
      error = PostcodeAnywhere::Error.new('execution expired')
      expect(error.message).to eq('execution expired')
    end
  end

  describe '#code' do
    it 'returns the error code' do
      error = PostcodeAnywhere::Error.new('execution expired', 123)
      expect(error.code).to eq(123)
    end
  end

  describe '#cause' do
    it 'returns the error cause message' do
      error = PostcodeAnywhere::Error.new('execution expired', 1, 'some cause')
      expect(error.cause).to eq('some cause')
    end
  end

  describe '#resolution' do
    it 'returns the error resolution message' do
      error = PostcodeAnywhere::Error.new('execution expired', 1, '', 'some resolution')
      expect(error.resolution).to eq('some resolution')
    end
  end

  context "when JSON body contains an 'Error:'" do
    before do
      body =
        '[{"Error":"2","Description":"UK","Cause":"CS","Resolution":"RS"}]'

      endpoint = PostcodeAnywhere::CleansePlus::Interactive::CLEANSE_ADDRESS_ENDPOINT
      query_params = { 'Key' => 'error_test_key', 'Address' => 'A' }
      stub_get(endpoint).with(query: query_params).to_return(
        status: 200,
        body: body,
        headers: { content_type: 'application/json; charset=utf-8' }
      )
    end
    it 'raises an exception with the proper message' do
      expect { @client.address_candidates_for('A') }.to raise_error do |error|
        expect(error).to be_a PostcodeAnywhere::Error::UnknownKey
        expect(error.message).to eq 'UK'
        expect(error.cause).to eq 'CS'
        expect(error.resolution).to eq 'RS'
      end
    end
  end

  PostcodeAnywhere::Error.errors.each do |status, exception|
    context "when HTTP status is #{status}" do
      before do
        endpoint = PostcodeAnywhere::CleansePlus::Interactive::CLEANSE_ADDRESS_ENDPOINT
        query_params = { 'Key' => 'error_test_key', 'Address' => 'A' }
        stub_get(endpoint).with(query: query_params).to_return(status: status)
      end
      it "raises #{exception}" do
        expect { @client.address_candidates_for('A') }.to raise_error(exception)
      end
    end
  end

end
