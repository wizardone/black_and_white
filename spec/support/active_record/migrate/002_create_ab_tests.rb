class CreateAbTests < ActiveRecord::Migration
  def self.up
    create_table :ab_tests do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end

