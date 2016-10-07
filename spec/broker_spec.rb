require 'spec_helper'

describe BlackAndWhite::Helpers::Broker do
  subject { described_class }

  describe '.register' do
    it 'registers ActiveRecord for later use' do
      described_class.register(:active_record)

      expect(described_class.orm).to eq(:active_record)
    end

    it 'registers Mongoid for later use' do
      described_class.register(:mongoid)

      expect(described_class.orm).to eq(:mongoid)
    end
  end

  describe '.invoke' do
    it 'invokes a custom method and passes it to the proper ORM' do
      activerecord = class_double('BlackAndWhite::ActiveRecord::Test').as_stubbed_const
      expect(activerecord).to receive(:create).with(name: 'Tester')

      described_class.register(:active_record)
      described_class.invoke(:create, name: 'Tester')
    end

    it 'invokes a custom method and passes it to the proper ORM' do
      mongoid = class_double('BlackAndWhite::Mongoid::Test').as_stubbed_const
      expect(mongoid).to receive(:create).with(name: 'Tester')

      described_class.register(:mongoid)
      described_class.invoke(:create, name: 'Tester')
    end
  end
end
