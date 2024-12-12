require 'rails_helper'

RSpec.describe Prompt, type: :model do
  describe 'validations' do
    context 'when a prompt already exists' do
      let!(:existing_prompt) { create(:prompt, text: 'Existing prompt') }

      it 'does not allow creating another prompt' do
        new_prompt = build(:prompt, text: 'New prompt')
        expect(new_prompt).not_to be_valid
        expect(new_prompt.errors[:base]).to include('Only one prompt can exist at a time.')
      end
    end

    context 'when no prompt exists' do
      it 'allows creating a prompt' do
        prompt = build(:prompt, text: 'First prompt')
        expect(prompt).to be_valid
      end
    end
  end

  describe 'scopes' do
    describe '.current' do
      let!(:prompt_with_id_1) { create(:prompt, id: 1) }

      it 'returns the prompt with ID 1 if it exists' do
        expect(Prompt.current).to eq(prompt_with_id_1)
      end

      it 'returns nil if no prompt exists' do
        Prompt.destroy_all
        expect(Prompt.current).to be_empty
      end
    end
  end

  describe 'paper_trail tracking' do
    let!(:prompt) { create(:prompt, text: 'Initial text', sentiment: 'neutral', usage_count: 0) }

    it 'tracks changes only to text, sentiment, and usage_count' do
      prompt.update(text: 'Updated text')
      expect(prompt.versions.count).to eq(2)

      prompt.update(sentiment: 'positive')
      expect(prompt.versions.count).to eq(3)

      prompt.update(usage_count: 1)
      expect(prompt.versions.count).to eq(4)

      prompt.update(created_at: Time.zone.now - 1.day)
      expect(prompt.versions.count).to eq(4)

      prompt.update(updated_at: Time.zone.now - 1.day)
      expect(prompt.versions.count).to eq(4)
    end
  end
end
