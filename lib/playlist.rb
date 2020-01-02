class Playlist < ActiveRecord::Base
    has_and_belongs_to_many :songs
    belongs_to :user


    def self.create_new(playlist_name, user)
        Playlist.create(name: playlist_name, user_id: user)
    end

    def self.show_playlists
        playlists = Playlist.all.select{|playlist| playlist == self}
        
    end
end