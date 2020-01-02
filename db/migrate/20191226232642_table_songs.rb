class TableSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :title
      t.integer :rating
      t.integer :artist_id
    end
  end
end
