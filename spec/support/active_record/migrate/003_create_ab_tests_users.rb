class CreateAbTestsUsers < ActiveRecord::Migration
  def self.up
    create_table :ab_tests_users do |t|
      t.integer :user_id, null: false
      t.integer :ab_test_id, null: false
      t.timestamps null: false
    end

    add_index :ab_tests_users, :user_id
    add_index :ab_tests_users, :ab_test_id
  end
end


