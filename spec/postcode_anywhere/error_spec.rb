describe PostcodeAnywhere::Error do
  before do
    @client = PostcodeAnywhere::Client.new
  end

  describe '#message' do
    it 'returns the error message' do
      error = PostcodeAnywhere::Error.new('execution expired')
      expect(error.message).to eq('execution expired')
    end
  end

  # context 'when returned body references an error message' do
  #   before do
  #     body =
  #       "<p class=\"heading1\">Request Error</p><p xmlns=\"\">The server " \
  #       'encountered an error processing the request. Please see the <a ' \
  #       "rel=\"help-page\" href=\"\">" \
  #     stub_post('SubmitMethod').to_return(status: 400, body: body)
  #   end
  #   it 'raises an exception with the proper message' do
  #     expect { @client.method_call('', '', '') }.to raise_error(
  #       PostcodeAnywhere::Error::BadRequest,
  #       'Object reference not set to an instance of an object.'
  #     )
  #   end
  # end

  # PostcodeAnywhere::Error.errors.each do |status, exception|
  #   context "when HTTP status is #{status}" do
  #     before do
  #       stub_post('SubmitMethod').to_return(status: status)
  #     end
  #     it "raises #{exception}" do
  #       expect { @client.submit_method('', '', '') }.to raise_error(exception)
  #     end
  #   end
  # end

end
