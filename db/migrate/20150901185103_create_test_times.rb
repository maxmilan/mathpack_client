class CreateTestTimes < ActiveRecord::Migration
  def change
    create_table :test_times do |t|
      t.string :text

      t.timestamps
    end
  end
end
