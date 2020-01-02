# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_01_213029) do

  create_table "artists", force: :cascade do |t|
    t.string "name"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
  end

  create_table "playlists_songs", force: :cascade do |t|
    t.integer "playlist_id"
    t.integer "song_id"
    t.index ["playlist_id"], name: "index_playlists_songs_on_playlist_id"
    t.index ["song_id"], name: "index_playlists_songs_on_song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.float "rating"
    t.integer "artist_id"
    t.integer "number_of_rates"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
  end

end
