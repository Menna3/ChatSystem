class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :token, index: { unique: true }, null: false
      t.string :app_name, null: false
      t.integer :chats_count
      t.string :created_by

      t.timestamps
    end
  end
end
