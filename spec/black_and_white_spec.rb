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

end
