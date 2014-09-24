describe PostcodeAnywhere::ModelBase do
  before do
    @base = PostcodeAnywhere::ModelBase.new(id: 1)
  end
  describe '#attrs' do
    it 'returns a hash of attributes' do
      expect(@base.attrs).to eq(id: 1)
    end
  end
end
