class Artist < ActiveRecord::Base

    has_many :songs
    
    def self.first_eight_songs(search_artist)
        # i = 0
        # x = 1
        artist = Artist.find_by(name: search_artist)
        if artist == nil
            return false
        else
            song = Song.all.select{|song| song.artist.name == search_artist}
            # while i < 8 && i < song.length do
            #     puts "#{x}. #{song[i].title}"
            #     i += 1
            #     x += 1
            #   end
            # song.each_with_index{ |song, i| puts "#{i +1}. #{song.title}"}
            #Song.all.each_with_index{|song, i| puts "#{song.title == self}"}
        end
        
    end

    def self.last_songs(search_artist)
        artist = Artist.find_by(name: search_artist)
        if artist == nil
            return false
        else
            song = Song.all.select{|song| song.artist.name == search_artist}
            # number_of_songs = song.last(8)
            # while i < 8 && i < song.length do
            #     puts "#{x}. #{song[i].title}"
            #     i += 1
            #     x += 1
            #   end
            
            #Song.all.each_with_index{|song, i| puts "#{song.title == self}"}
        end
    end

end