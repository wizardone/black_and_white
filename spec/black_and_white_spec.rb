require 'spec_helper'

describe BlackAndWhite do
  it 'has a version number' do
    expect(BlackAndWhite::VERSION).not_to be nil
  end

  describe '.configure' do
    it 'yields the passed block to .configure' do
      bl = proc { |config| config.bw_class = 'Person' }
      expect { |bl|
        BlackAndWhite.configure(&bl)
      }.to yield_with_args(&bl)
    end
  end

  describe '.config' do
    it 'returns the default config instance' do
      expect(BlackAndWhite.config).to be_a(BlackAndWhite::Config)
      expect(BlackAndWhite.config.bw_main_table).to eq(BlackAndWhite::Config.new.bw_main_table)
      expect(BlackAndWhite.config.bw_join_table).to eq(BlackAndWhite::Config.new.bw_join_table)
      expect(BlackAndWhite.config.bw_class).to eq(BlackAndWhite::Config.new.bw_class)
      expect(BlackAndWhite.config.bw_class_table).to eq(BlackAndWhite::Config.new.bw_class_table)
    end
  end

  describe '.create' do
    it 'creates an ab test with required params' do
      expect {
        BlackAndWhite.create(name: 'ab_test')
      }.to change { BlackAndWhite::ActiveRecord::Test.count }.by(1)
    end

    it 'creates ab test with required and optional params' do
      expect {
        BlackAndWhite.create(name: 'ab_test', active: true)
      }.to change { BlackAndWhite::ActiveRecord::Test.count }.by(1)
    end
  end

  context 'ActiveRecord' do
    context 'helper methods' do
      subject do
        Class.new { extend BlackAndWhite::Helpers::Database }
      end

      it 'returns the configuration main table name' do
        expect(subject.bw_tests_table_name).to eq(BlackAndWhite.config.bw_main_table)
      end

      it 'returns the configuration relation table name' do
        expect(subject.bw_relations_table_name).to eq(BlackAndWhite.config.bw_join_table)
      end

      it 'returns the configuration class name for a/b testing' do
        expect(subject.bw_tests_class).to eq(BlackAndWhite.config.bw_class)
      end

      it 'returns the configuration main model table' do
        expect(subject.bw_tests_class_table)
          .to eq(BlackAndWhite.config.bw_class_table)
      end
    end
  end

  context 'ActiveRecord::Test' do
    subject { BlackAndWhite::ActiveRecord::Test }

    it 'returns the proper table name' do
      expect(subject.table_name.to_sym).to eq(BlackAndWhite.config.bw_main_table)
    end

    it 'activates an a/b test' do
      test = subject.new
      test.activate!

      expect(test.active).to eq(true)
    end

    it 'deactivates an a/b test' do
      test = subject.new
      test.deactivate!

      expect(test.active).to eq(false)
    end
  end

  context 'Main model used for A/B testing' do
    subject { User.new }

    it 'does not participate in any ab tests by default' do
      expect(subject.ab_tests.any?).to eq false
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
          }.to raise_error BlackAndWhite::ActiveRecord::AbTestError
        end

        it 'does not join inactive ab test if join_inactive is set' do
          create_ab_test!(name: 'inactive_ab_test')
          subject.ab_participate!('inactive_ab_test', join_inactive: false)

          expect(subject.ab_tests).to be_empty
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
    BlackAndWhite::ActiveRecord::Test.create!(name: name)
  end
end
