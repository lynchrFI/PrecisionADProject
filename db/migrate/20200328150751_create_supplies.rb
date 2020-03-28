class CreateSuppliesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :supplies do |t|
      t.string :brand
      t.string :name
      t.string :product_info
      t.integer :price
      t.integer :stock
      t.timestamps
    end
  end
end
