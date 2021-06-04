class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :promo
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :email
      t.string :phone
      t.string :password_digest
      t.date :birth_date
      t.integer :gender
      t.datetime :confirmed_at
      t.datetime :deleted_at
      t.references :created_by_user, references: :users
      t.references :updated_by_user, references: :users
      t.references :deleted_by_user, references: :users
      t.references :confirmed_by_user, references: :users

      t.timestamps
    end
  end
end
