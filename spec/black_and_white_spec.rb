require 'spec_helper'

describe BlackAndWhite do
  it 'has a version number' do
    expect(BlackAndWhite::VERSION).not_to be nil
  end

  describe '.configure' do
    skip
  end

  describe '.config' do
    it 'returns a config instance' do
      expect(BlackAndWhite.config).to be_a(BlackAndWhite::Config)
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

    context 'participate!' do
      it 'raises an error when no ab test with the given name exists' do
        expect {
          subject.ab_participate!('test')
        }.to raise_error BlackAndWhite::ActiveRecord::AbTestError
      end

      it 'participates in an ab test without any conditions' do
        BlackAndWhite::ActiveRecord::Test.create!(name: 'ab_test')
        subject.ab_participate!('ab_test')

        expect(subject.ab_tests).not_to be_empty
        expect(subject.ab_tests.first.name).to eq('ab_test')
      end

      it 'participates in an ab test if certain conditions met' do
        BlackAndWhite::ActiveRecord::Test.create!(name: 'ab_test_with_conditions')
        subject.ab_participate!('ab_test_with_conditions') do |subject|
          subject.active == true
        end

        expect(subject.ab_tests).not_to be_empty
        expect(subject.ab_tests.first.name).to eq('ab_test_with_conditions')
      end

      it 'does not participates in an ab test if certain conditions are not met' do
        BlackAndWhite::ActiveRecord::Test.create!(name: 'ab_test_with_conditions')
        subject.ab_participate!('ab_test_with_conditions') do |subject|
          subject.active == false
        end

        expect(subject.ab_tests).to be_empty
        expect(subject.participates?('ab_test_with_conditions')).to eq(false)
      end
    end
  end
end
