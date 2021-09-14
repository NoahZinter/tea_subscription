class CreateTeas < ActiveRecord::Migration[5.2]
  def change
    create_table :teas do |t|
      t.string :type
      t.text :description
      t.integer :temperature
      t.integer :brew_time
      t.string :origin

      t.timestamps
    end
  end
end
