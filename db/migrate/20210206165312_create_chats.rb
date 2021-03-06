class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :order, null: false
      t.string :subject_token, null: false

      t.timestamps
    end
    add_foreign_key :chats, :subjects, column: :subject_token, primary_key: :token
    add_index :chats, [:order, :subject_token], unique: true
  end
end
