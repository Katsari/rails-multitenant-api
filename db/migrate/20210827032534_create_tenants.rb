class CreateTenants < ActiveRecord::Migration[6.1]
  def change
    create_table :tenants do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
