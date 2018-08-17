class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, unique: true
      t.string :password, null: false
      t.string :session_token, null: false

      t.timestamps
    end
  end
end
