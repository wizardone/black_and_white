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
  end

  context 'Main model used for A/B testing' do
    subject { User.new }

    it 'does not participate in any ab tests by default' do
      expect(subject.ab_tests.any?).to eq false
    end

    it 'raises an error when no ab test with the given name exists' do
      expect {
        subject.participate('test')
      }.to raise_error BlackAndWhite::ActiveRecord::AbTestError
    end
  end
end
