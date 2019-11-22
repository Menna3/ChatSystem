class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.integer :chat_number, null: false
      t.string :chat_name, null: false
      t.references :application, foreign_key: {on_delete: :cascade}
      t.integer :messages_count
      t.timestamps
    end
      add_index :chats, [:chat_number, :application_id], :unique => true
  end
end
