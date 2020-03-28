class CreateClientsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :vehicle
      t.string :client_info
      t.string :user_id
      t.timestamps
    end
  end
end
