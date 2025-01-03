class CreateOrdersDescriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :orders_descriptions do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
