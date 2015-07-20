class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.attachment :image
      t.string :location
      t.integer :phone, precision: 10
      t.belongs_to :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
