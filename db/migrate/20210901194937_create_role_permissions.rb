class CreateRolePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :name, null: false
      t.index [:name, :tenant_id], unique: true

      t.timestamps
    end

    create_table :permissions do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :subject_class, null: false # Model name
      t.string :action, null: false        # Action name
      t.string :action_name                # User understandable action name
      t.string :subject_name               # User understandable subject (model) name
      t.string :subject_group              # User understandable subject group

      t.timestamps
    end

    create_table :role_permissions do |t|
      t.references :role, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true

      t.timestamps
    end

    create_policy :roles, version: 1
    create_policy :permissions, version: 1
  end
end
