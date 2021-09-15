class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.string :title, default: 'untitled subscription'
      t.float :price
      t.integer :status, default: 0
      t.integer :frequency, default: 1
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
