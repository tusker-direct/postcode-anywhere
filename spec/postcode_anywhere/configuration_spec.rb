describe 'configuration' do

  after do
    PostcodeAnywhere.reset
  end

  describe '.configure' do
    PostcodeAnywhere::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        PostcodeAnywhere.configure do |config|
          config.send("#{key}=", key)
          expect(PostcodeAnywhere.send(key)).to eq key
        end
      end
    end
  end

  describe '.api_key' do
    subject { PostcodeAnywhere.api_key }
    it 'should return default api key' do
      expect(PostcodeAnywhere::Configuration::DEFAULT_API_KEY).to eq ''
      is_expected.to eq PostcodeAnywhere::Configuration::DEFAULT_API_KEY
    end
  end

  describe '.endpoint' do
    subject { PostcodeAnywhere.endpoint }
    it 'should return default api endpoint' do
      expect(PostcodeAnywhere::Configuration::DEFAULT_ENDPOINT).to eq(
        'https://services.postcodeanywhere.co.uk/'
      )
      is_expected.to eq PostcodeAnywhere::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe '.format' do
    subject { PostcodeAnywhere.format }
    it 'should return default REST content format of json' do
      expect(PostcodeAnywhere::Configuration::DEFAULT_FORMAT).to eq :json
      is_expected.to eq PostcodeAnywhere::Configuration::DEFAULT_FORMAT
    end
  end

  describe '.user_agent' do
    subject { PostcodeAnywhere.user_agent }
    it 'should return default user agent' do
      expect(PostcodeAnywhere::Configuration::DEFAULT_USER_AGENT).to eq(
        "Postcode Anywhere Ruby Gem/#{PostcodeAnywhere::VERSION}"
      )
      is_expected.to eq PostcodeAnywhere::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe '.method' do
    subject { PostcodeAnywhere.method }
    it 'should return default user agent' do
      expect(PostcodeAnywhere::Configuration::DEFAULT_METHOD).to eq :post
      is_expected.to eq PostcodeAnywhere::Configuration::DEFAULT_METHOD
    end
  end

end
