class UpdateTableSong < ActiveRecord::Migration[5.2]
  def change
    change_column :songs, :rating, :float
  end
end
