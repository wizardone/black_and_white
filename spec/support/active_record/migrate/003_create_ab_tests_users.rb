class CreateAbTestsUsers < ActiveRecord::Migration
  def self.up
    create_table :ab_tests_users do |t|
      t.references :user, index: true
      t.references :ab_test, index: true
      t.timestamps null: false
    end
  end
end


