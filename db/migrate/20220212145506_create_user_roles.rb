class CreateUserRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_roles do |t|
      t.string :position
      t.references :user, null: false, foreign_key: true
      t.references :created_by_user, references: :users
      t.references :updated_by_user, references: :users

      t.timestamps
    end
  end
end
