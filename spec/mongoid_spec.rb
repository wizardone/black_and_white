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

    describe '#ab_participate!' do
      it 'returns false when no ab test with the given name is present' do
        expect(subject.ab_participate!('test')).to eq(false)
      end

      it 'participates in an ab test without any conditions' do
        create_ab_test!(name: 'ab_test')
        subject.ab_participate!('ab_test')

        expect(subject.ab_tests).not_to be_empty
        expect(subject.ab_tests.first.name).to eq('ab_test')
      end

      it 'participates in multiple ab tests' do
        create_ab_test!(name: 'ab_test_1')
        create_ab_test!(name: 'ab_test_2')

        subject.ab_participate!('ab_test_1')
        subject.ab_participate!('ab_test_2')

        expect(subject.ab_tests).not_to be_empty
        expect(subject.ab_tests.map(&:name)).to eq(['ab_test_1', 'ab_test_2'])
      end

      it 'participates in an ab test if certain conditions met' do
        create_ab_test!(name: 'ab_test_with_conditions')
        subject.ab_participate!('ab_test_with_conditions') do |subject|
          subject.active == true
        end

        expect(subject.ab_tests).not_to be_empty
        expect(subject.ab_tests.first.name).to eq('ab_test_with_conditions')
      end

      it 'does not participates in an ab test if certain conditions are not met' do
        create_ab_test!(name: 'ab_test_with_conditions')
        subject.ab_participate!('ab_test_with_conditions') do |subject|
          subject.active == false
        end

        expect(subject.ab_tests).to be_empty
      end

      it 'does not participates in an ab test if foreign conditions are not met' do
        test = true
        test_lambda = -> { test == true }

        create_ab_test!(name: 'ab_test_with_conditions')
        subject.ab_participate!('ab_test_with_conditions') do |subject|
          test_lambda.call
        end

        expect(subject.ab_tests).not_to be_empty
        expect(subject.ab_tests.first.name).to eq('ab_test_with_conditions')
      end

      context 'custom options' do
        it 'raises an error message if raise_on_error option is set' do
          expect {
            subject.ab_participate!('test', raise_on_missing: true)
          }.to raise_error BlackAndWhite::AbTestError
        end

        it 'does not join inactive ab test if join_inactive is set' do
          create_ab_test!(name: 'inactive_ab_test')
          subject.ab_participate!('inactive_ab_test', join_inactive: false)

          expect(subject.ab_tests).to be_empty
        end
      end

      context 'Extra logic addition to BlackAndWhite' do
        it 'evaluates extra code passed to black and white module' do
          subject.instance_eval do
            BlackAndWhite.add(self) do
              def added_method
                "added method"
              end

              def is_added?
                true
              end
            end
          end
          expect(subject.added_method).to eq('added method')
          expect(subject.is_added?).to be_truthy
        end
      end
    end

    describe '#ab_participates?' do
      before { create_ab_test!(name: 'ab_test') }

      it 'returns TRUE, the object participates in the test' do
        subject.ab_participate!('ab_test')

        expect(subject.ab_participates?('ab_test')).to eq(true)
      end

      it 'returns FALSE, the object does not participate in the test' do
        expect(subject.ab_participates?('ab_test')).to eq(false)
      end
    end
  end

  private

  def create_ab_test!(name:)
    BlackAndWhite::Mongoid::Test.create!(name: name)
  end
end
