class CreateStoreFlavors < ActiveRecord::Migration[5.2]
  def change
    create_table :store_flavors do |t|
      t.integer :store_id
      t.integer :flavor_id

      t.timestamps
    end
  end
end
