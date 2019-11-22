class CreateChatMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_messages do |t|
      t.integer :message_number, null: false
      t.references :chat, foreign_key: {on_delete: :cascade}
      t.text :message_body
      t.timestamps
    end
      add_index :chat_messages, [:message_number, :chat_id], :unique => true
  end
end
