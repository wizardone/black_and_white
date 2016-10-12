require 'spec_helper'

describe BlackAndWhite, mongoid: true do
  describe '.create' do
    it 'creates an ab test with required params' do
      expect {
        BlackAndWhite.create(name: 'ab_test')
      }.to change { BlackAndWhite::Mongoid::Test.count }.by(1)
    end

    it 'creates ab test with required and optional params' do
      expect {
        BlackAndWhite.create(name: 'ab_test', active: true, description: 'some cool description')
      }.to change { BlackAndWhite::Mongoid::Test.count }.by(1)
    end
  end

  context 'Mongoid' do
    context 'Mongoid::Test' do
      subject { BlackAndWhite::Mongoid::Test }

      it 'validates the name of the test' do
        subject.create(name: 'mongoid_test')
        test_2 = subject.create(name: 'mongoid_test')

        expect(test_2).not_to be_valid
        expect(test_2.errors[:name]).to eq(['is already taken'])
      end

      it 'activates an ab test' do
        test = subject.new
        test.activate!

        expect(test.active).to be_truthy
      end

      it 'deactivates an ab test' do
        test = subject.new(active: true)
        test.deactivate!

        expect(test.active).to be_falsey
      end
    end
  end

  context 'Main model used for A/B testing' do
    subject { User.new }

    it 'does not participate in any ab tests by default' do
      expect(subject.ab_tests).to be_empty
    end
  end
end
