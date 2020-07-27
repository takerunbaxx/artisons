class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.text :bio
      t.string :curiosity
      t.string :country
      t.string :gender
      t.string :string

      t.timestamps
    end
  end
end
