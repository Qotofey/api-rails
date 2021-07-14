class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.integer :position
      t.references :user, null: false, foreign_key: true
      t.references :created_by_user, references: :users
      t.references :updated_by_user, references: :users

      t.timestamps
    end

    add_index :roles, %i[prosition user_id], unique: true
  end
end
