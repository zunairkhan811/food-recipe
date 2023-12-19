require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'John', email: 'john@example.com') }
  subject do
    described_class.new(
      name: 'Delicious Recipe',
      preparation_time: 30,
      cooking_time: 45,
      description: 'A tasty recipe.',
      public: 1,
      user:
    )
  end

  describe 'validations' do
    it 'requires name to be present' do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include("can't be blank")
    end

    it 'requires preparation_time to be present and greater than or equal to 0' do
      subject.preparation_time = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:preparation_time]).to include("can't be blank")

      subject.preparation_time = -1
      expect(subject).to_not be_valid
      expect(subject.errors[:preparation_time]).to include('must be greater than or equal to 0')
    end

    it 'requires cooking_time to be present and greater than or equal to 0' do
      subject.cooking_time = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:cooking_time]).to include("can't be blank")

      subject.cooking_time = -1
      expect(subject).to_not be_valid
      expect(subject.errors[:cooking_time]).to include('must be greater than or equal to 0')
    end

    it 'requires description to be present' do
      subject.description = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:description]).to include("can't be blank")
    end

    it 'requires public to be either 0 or 1' do
      subject.public = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:public]).to include("can't be blank")

      subject.public = 2
      expect(subject).to_not be_valid
      expect(subject.errors[:public]).to include('is not included in the list')
    end
  end
end
