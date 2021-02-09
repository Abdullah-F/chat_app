class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :order, null: false
      t.references :chat, index: true, null: :false, foreign_key: true
      t.text :body

      t.timestamps
    end
    add_index :messages, [:order, :chat_id], unique: true
    add_column :subjects, :chats_count, :integer, null: false, default: 0
    add_column :chats, :messages_count, :integer, null: false, default: 0
  end
end
