describe PostcodeAnywhere::BankAccountValidation::Interactive do
  before do
    @client = PostcodeAnywhere::BankAccountValidation::Client.new(
      api_key: 'interactive_test_key'
    )
  end
  describe '#address_candidates_for' do
    before do
      @endpoint = 'BankAccountValidation/Interactive/RetrieveBySortcode/v1.00/json.ws'
      @query_params = { 'Key' => 'interactive_test_key', 'SortCode' => 'A' }
    end
    context 'when a single result is returned' do
      before do
        stub_get(@endpoint).with(query: @query_params).to_return(
          body: fixture('bank_account_retrieve_by_sort.json')
        )
      end
      it 'requests the correct resource' do
        @client.retrieve_by_sortcode('A')
        expect(a_get(@endpoint).with(query: @query_params)).to have_been_made
      end
      it 'returns a Postcode Anywhere cleaned address' do
        item = @client.retrieve_by_sortcode('A')
        expect(item).to be_a PostcodeAnywhere::BankAccountValidation::BankBranch
        expect(item.bank).to eq 'HSBC BANK PLC'
        expect(item.bank_bic).to eq 'MIDLGB21'
        expect(item.branch).to eq 'Cheltenham Bath Road'
        expect(item.contact_address_line1).to eq '109 Bath Road'
        expect(item.contact_address_line2).to eq 'l2'
        expect(item.contact_post_town).to eq 'Cheltenham'
        expect(item.contact_postcode).to eq 'GL53 7RA'
        expect(item.contact_phone).to eq '01234567890'
        expect(item.contact_fax).to eq '111'
        expect(item.faster_payments_supported).to eq true
        expect(item.chaps_supported).to eq true
      end
    end
  end
end
