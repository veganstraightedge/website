class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.date   :birthday

      t.string :name
      t.string :username
      t.string :email
      t.string :city
      t.string :zipcode
      t.string :me_gender
      t.string :me_gender_map
      t.string :you_gender
      t.string :you_gender_map

      t.boolean :visible, default: false

      t.text   :bio

      t.belongs_to :label
      t.belongs_to :state
      t.belongs_to :country
      t.belongs_to :diet

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
