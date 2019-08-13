class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :itemId
      t.integer :customerId
      t.string :description
      t.float :price
      t.float :award
      t.float :total

      t.timestamps
    end
  end
end
