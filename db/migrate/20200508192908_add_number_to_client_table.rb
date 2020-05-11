class AddNumberToClientTable < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :number, :integer
  end
end
