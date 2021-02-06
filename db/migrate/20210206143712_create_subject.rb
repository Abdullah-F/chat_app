class CreateSubject < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :name, null: false
      t.string :token, null: false, index: { unique: true }
    end
  end
end
