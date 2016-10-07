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
end
