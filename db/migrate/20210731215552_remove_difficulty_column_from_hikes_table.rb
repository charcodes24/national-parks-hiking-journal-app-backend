class RemoveDifficultyColumnFromHikesTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :hikes, :difficulty
  end
end
