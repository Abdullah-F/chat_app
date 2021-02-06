class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :order, null: false
      t.integer :chat_order, null: false
      t.string :subject_token, null: false
      t.text :body

      t.timestamps
    end
    add_index :messages, [:order, :chat_order, :subject_token], unique: true
    add_column :subjects, :chats_count, :integer, null: false, default: 0
    add_column :chats, :messages_count, :integer, null: false, default: 0
  end
end
