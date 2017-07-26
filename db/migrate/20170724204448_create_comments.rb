class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :text, null: false, default: ''
      t.references :user, index: true
      t.references :movie, index: true

      t.timestamps
    end
  end
end
