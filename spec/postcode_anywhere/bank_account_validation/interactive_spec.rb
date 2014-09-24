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
      it 'returns a Postcode Anywhere bank branch details' do
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

  describe '#validate_account' do
    before do
      @endpoint = 'BankAccountValidation/Interactive/Validate/v1.00/json.ws'
      @query_params = {
        'Key' => 'interactive_test_key',
        'AccountNumber' => 'A',
        'SortCode' => 'B'
      }
    end
    context 'when a single result is returned' do
      before do
        stub_get(@endpoint).with(query: @query_params).to_return(
          body: fixture('bank_account_validate_account.json')
        )
      end
      it 'requests the correct resource' do
        @client.validate_account('A', 'B')
        expect(a_get(@endpoint).with(query: @query_params)).to have_been_made
      end
      it 'returns a Postcode Anywhere bank validation result' do
        item = @client.validate_account('A', 'B')
        expect(item).to be_a PostcodeAnywhere::BankAccountValidation::ValidationResult
        expect(item.is_correct).to eq true
        expect(item.is_direct_debit_capable).to eq true
        expect(item.status_information).to eq 'OK'
        expect(item.corrected_sort_code).to eq '012345'
        expect(item.corrected_account_number).to eq '12345678'
        expect(item.iban).to eq '1111111111111111111111'
        expect(item.bank).to eq 'NATIONAL WESTMINSTER BANK PLC'
        expect(item.bank_bic).to eq 'BIKBIKBI'
        expect(item.branch).to eq 'A bank in town'
        expect(item.contact_address_line1).to eq 'Leicester Rcsc'
        expect(item.contact_address_line2).to eq 'Bede House'
        expect(item.contact_post_town).to eq 'Leicester'
        expect(item.contact_postcode).to eq 'LE2 7EJ'
        expect(item.contact_phone).to eq '0870 2403355'
        expect(item.contact_fax).to eq '222'
        expect(item.faster_payments_supported).to eq true
        expect(item.chaps_supported).to eq true
      end
    end
  end
end
