describe PostcodeAnywhere::EmailValidation::Interactive do
  before do
    @client = PostcodeAnywhere::EmailValidation::Client.new(api_key: 'interactive_test_key')
  end
  describe '#validate_email_address' do
    before do
      @endpoint = 'EmailValidation/Interactive/Validate/v1.10/json3.ws'
      @query_params = { 'Key' => 'interactive_test_key', 'Email' => 'A', 'Timeout' => 4 }
    end
    context 'when a single result is returned' do
      before do
        stub_get(@endpoint).with(query: @query_params).to_return(
          body: fixture('email_validation_validate_email.json')
        )
      end
      it 'requests the correct resource' do
        @client.validate_email_address('A', 4)
        expect(a_get(@endpoint).with(query: @query_params)).to have_been_made
      end
      it 'returns a Postcode Anywhere email validation result' do
        item = @client.validate_email_address('A', 4)
        expect(item).to be_a PostcodeAnywhere::EmailValidation::ValidationResult
        expect(item.email).to eq 'info@google.com'
        expect(item.mail_server).to eq 'alt4.aspmx.l.google.com'
        expect(item.valid_format).to eq true
        expect(item.found_dns_record).to eq true
      end
    end
  end
end
