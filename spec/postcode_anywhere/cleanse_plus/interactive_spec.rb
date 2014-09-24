describe PostcodeAnywhere::CleansePlus::Interactive do
  before do
    @client = PostcodeAnywhere::CleansePlus::Client.new(api_key: 'interactive_test_key')
  end
  describe '#address_candidates_for' do
    before do
      @endpoint = 'CleansePlus/Interactive/Cleanse/v1.00/json.ws'
      @query_params = { 'Key' => 'interactive_test_key', 'Address' => 'A' }
    end
    context 'when a single result is returned' do
      before do
        stub_get(@endpoint).with(query: @query_params).to_return(
          body: fixture('cleanse_address_single.json')
        )
      end
      it 'requests the correct resource' do
        @client.address_candidates_for('A')
        expect(a_get(@endpoint).with(query: @query_params)).to have_been_made
      end
      it 'returns a Postcode Anywhere cleaned address' do
        candidates = @client.address_candidates_for('A')
        expect(candidates).to be_an Array
        item = candidates.first
        expect(item).to be_a PostcodeAnywhere::CleansePlus::CleansedAddress
        expect(item.udprn).to eq 26_742_632
        expect(item.company).to eq 'some company'
        expect(item.department).to eq 'some department'
        expect(item.line1).to eq 'Enigma House'
        expect(item.line2).to eq 'Elgar Business Centre'
        expect(item.line3).to eq 'Moseley Road'
        expect(item.line4).to eq 'Hallow'
        expect(item.line5).to eq 'where is this'
        expect(item.post_town).to eq 'Worcester'
        expect(item.county).to eq 'Worcestershire'
        expect(item.postcode).to eq 'WR2 6NJ'
        expect(item.mailsort).to eq 94_141
        expect(item.barcode).to eq '(WR26NJ3UT)'
        expect(item.type).to eq 'Residential'
        expect(item.delivery_point_suffix).to eq '3U'
        expect(item.sub_building).to eq 'Enigma House'
        expect(item.building_name).to eq 'Elgar Business Centre'
        expect(item.building_number).to eq '3'
        expect(item.primary_street).to eq 'Moseley Road'
        expect(item.secondary_street).to eq 'secondy'
        expect(item.double_dependent_locality).to eq 'ddlocal'
        expect(item.dependent_locality).to eq 'Hallow'
        expect(item.po_box).to eq 'po123'
      end
    end
    context 'when a multiple candidates returned' do
      before do
        stub_get(@endpoint).with(query: @query_params).to_return(
          body: fixture('cleanse_address_multi.json')
        )
      end
      it 'returns a set of candidates for a postcode anywhere address' do
        candidates = @client.address_candidates_for('A')
        expect(candidates).to be_an Array
        expect(candidates.count).to be 2
        expect(candidates.first.udprn).to eq 26_742_632
        expect(candidates.last.udprn).to eq 2_222
      end
    end
  end
end
