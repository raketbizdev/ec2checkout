class CreateStorefronts < ActiveRecord::Migration[7.0]
  def change
    create_table :storefronts do |t|
      t.string :store_name
      t.string :subdomain
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
