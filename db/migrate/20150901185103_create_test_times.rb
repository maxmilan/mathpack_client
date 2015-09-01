class CreateTestTimes < ActiveRecord::Migration
  def change
    create_table :test_times do |t|

      t.timestamps
    end
  end
end
