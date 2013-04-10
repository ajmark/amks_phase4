class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.integer :student_id
      t.string :role
      t.boolean :active

      t.timestamps
    end
  end
end
