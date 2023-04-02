class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :email
      t.integer :length
      t.integer :width
      t.string :name
      t.integer :mines
      t.json :state, array: true, default: []

      t.timestamps
    end
  end
end
