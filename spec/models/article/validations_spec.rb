RSpec.describe Article, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:sources) }

    context 'when title is blank or nil' do
      it 'is invalid without a title' do
        article = build(:article, title: nil)
        expect(article).not_to be_valid
      end

      it 'is invalid with a blank title' do
        article = build(:article, title: "")
        expect(article).not_to be_valid
      end
    end

    context 'when summary is blank or nil' do
      it 'is invalid without a summary' do
        article = build(:article, summary: nil)
        expect(article).not_to be_valid
      end

      it 'is invalid with a blank summary' do
        article = build(:article, summary: "")
        expect(article).not_to be_valid
      end
    end

    context 'when content is blank or nil' do
      it 'is invalid without content' do
        article = build(:article, content: nil)
        expect(article).not_to be_valid
      end

      it 'is invalid with blank content' do
        article = build(:article, content: "")
        expect(article).not_to be_valid
      end
    end

    context 'when sources are blank or nil' do
      it 'is invalid without sources' do
        article = build(:article, sources: nil)
        expect(article).not_to be_valid
      end

      it 'is invalid with blank sources' do
        article = build(:article, sources: "")
        expect(article).not_to be_valid
      end
    end
  end
end
