class CreateHikesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :hikes do |t|
      t.string :name
      t.integer :distance
      t.string :difficulty
      t.string :note 
      t.belongs_to :national_park
    end
  end
end
