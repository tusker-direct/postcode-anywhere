describe PostcodeAnywhere::CapturePlus::Interactive do
  before do
    @client = PostcodeAnywhere::CapturePlus::Client.new(api_key: 'interactive_test_key')
  end

  describe 'Searching' do
    before do
      @endpoint = 'CapturePlus/Interactive/Find/v2.00/json.ws'
      @query_params = {
        'Key' => 'interactive_test_key',
        'SearchTerm' => 'A',
        'SearchFor' => 'Everything',
        'LastId' => '',
        'Country' => 'GBR',
        'LanguagePreference' => 'EN'
      }
    end
    describe '#query' do
      before do
        stub_get(@endpoint).with(query: @query_params).to_return(
          body: fixture('capture_plus_search.json')
        )
      end
      it 'requests the correct resource' do
        @client.query('A')
        expect(a_get(@endpoint).with(query: @query_params)).to have_been_made
      end
      it 'returns a set of Postcode Anywhere search results' do
        results = @client.query('A')
        expect(results).to be_an Array
        expect(results.count).to eq 6
        item = results.first
        expect(item).to be_a PostcodeAnywhere::CapturePlus::SearchResult
        expect(item.id).to eq(
          'GBR|CN|QgB1AGMAawBpAG4AZwBoAGEAbQAgAFAAYQBsAGEAYwBlACwAIABMAG8AbgBkAG8Ab' \
          'gAsACAAUwBXADEAQQAuAC4ALgA*|2562-0-3'
        )
        expect(item.text).to eq 'Buckingham Palace, London, SW1A...'
        expect(item.highlight).to eq '1-3'
        expect(item.cursor).to eq '0'
        expect(item.description).to eq '3 Results'
        expect(item.next).to eq 'Find'

        expect(results[1].text).to eq 'Buckingham Palace Road, London, SW1W...'
        expect(results[2].text).to eq(
          'Buckingham Balti House, 42, Buckingham Palace Road, London, SW1W...'
        )
        expect(results[3].text).to eq(
          'Buckingham Coffee Lounge, 19-21, Palace Street, London, SW1E...'
        )
        expect(results[4].text).to eq(
          'Gardeners Lodge, Buckingham Palace Gardens, Lower Grosvenor Place, London, SW1W...'
        )
        expect(results[5].text).to eq(
          'Buckingham Palace Gift Shop, 7-9, Buckingham Palace Road, London, SW1W...'
        )
      end
    end
    describe '#query_postcodes' do
      before do
        @postcode_params = @query_params.merge('SearchFor' => 'PostalCodes')
        stub_get(@endpoint).with(query: @postcode_params).to_return(
          body: fixture('capture_plus_search.json')
        )
      end
      it 'requests the correct resource' do
        @client.query_postcodes('A')
        expect(a_get(@endpoint).with(query: @postcode_params)).to have_been_made
      end
      it 'returns a set of Postcode Anywhere search results' do
        results = @client.query_postcodes('A')
        expect(results).to be_an Array
        expect(results.count).to eq 6
        item = results.first
        expect(item).to be_a PostcodeAnywhere::CapturePlus::SearchResult
      end
    end
    describe '#query_companies' do
      before do
        @companies_params = @query_params.merge('SearchFor' => 'Companies')
        stub_get(@endpoint).with(query: @companies_params).to_return(
          body: fixture('capture_plus_search.json')
        )
      end
      it 'requests the correct resource' do
        @client.query_companies('A')
        expect(a_get(@endpoint).with(query: @companies_params)).to have_been_made
      end
      it 'returns a set of Postcode Anywhere search results' do
        results = @client.query_companies('A')
        expect(results).to be_an Array
        expect(results.count).to eq 6
        item = results.first
        expect(item).to be_a PostcodeAnywhere::CapturePlus::SearchResult
      end
    end
    describe '#query_places' do
      before do
        @place_params = @query_params.merge('SearchFor' => 'Places')
        stub_get(@endpoint).with(query: @place_params).to_return(
          body: fixture('capture_plus_search.json')
        )
      end
      it 'requests the correct resource' do
        @client.query_places('A')
        expect(a_get(@endpoint).with(query: @place_params)).to have_been_made
      end
      it 'returns a set of Postcode Anywhere search results' do
        results = @client.query_places('A')
        expect(results).to be_an Array
        expect(results.count).to eq 6
        item = results.first
        expect(item).to be_a PostcodeAnywhere::CapturePlus::SearchResult
      end
    end
    describe 'custom options' do
      before do
        @custom_params = @query_params.merge(
          'Country' => 'FR',
          'LanguagePreference' => 'PP',
          'LastId' => '999'
        )
        stub_get(@endpoint).with(query: @custom_params).to_return(
          body: fixture('capture_plus_search.json')
        )
      end
      it 'requests the correct resource' do
        @client.query('A', country: 'FR', language: 'PP', parent_query: '999')
        expect(a_get(@endpoint).with(query: @custom_params)).to have_been_made
      end
      it 'returns a set of Postcode Anywhere search results' do
        results = @client.query('A', country: 'FR', language: 'PP', parent_query: '999')
        expect(results).to be_an Array
        expect(results.count).to eq 6
        item = results.first
        expect(item).to be_a PostcodeAnywhere::CapturePlus::SearchResult
      end
    end
    describe '#sub_query' do
      before do
        @custom_params = @query_params.merge('LastId' => '123456')
        stub_get(@endpoint).with(query: @custom_params).to_return(
          body: fixture('capture_plus_search.json')
        )
      end
      context 'when the parent query is a string' do
        it 'requests the correct resource' do
          @client.sub_query('A', '123456')
          expect(a_get(@endpoint).with(query: @custom_params)).to have_been_made
        end
        it 'returns a set of Postcode Anywhere search results' do
          results = @client.sub_query('A', '123456')
          expect(results).to be_an Array
          expect(results.count).to eq 6
          item = results.first
          expect(item).to be_a PostcodeAnywhere::CapturePlus::SearchResult
        end
      end
      context 'when the parent query is a SearchResult object' do
        before do
          @search_result = PostcodeAnywhere::CapturePlus::SearchResult.new(id: '123456')
        end
        it 'requests the correct resource' do
          @client.sub_query('A', @search_result)
          expect(a_get(@endpoint).with(query: @custom_params)).to have_been_made
        end
        it 'returns a set of Postcode Anywhere search results' do
          results = @client.sub_query('A', @search_result)
          expect(results).to be_an Array
          expect(results.count).to eq 6
          item = results.first
          expect(item).to be_a PostcodeAnywhere::CapturePlus::SearchResult
        end
      end
    end
  end
end
