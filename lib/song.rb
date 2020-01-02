class Song < ActiveRecord::Base
    has_and_belongs_to_many :playlist
    belongs_to :artist

    def self.top_songs(number_of_songs)
        number_of_songs = 5
        five_songs = Song.all.last(number_of_songs)
    end

    def self.search(search)
        song = find_by(title: search)
        if song == nil
            return false
        else
            song
        end
    end

    def rate(user_rating, song) 
        song_rating = song.rating
        number_rates = song.number_of_rates
        if number_rates == nil || song_rating == nil
            number_rates = 0
            song_rating = 0
        end
        mult_rates = song_rating * number_rates
        sum_rating = mult_rates + user_rating
        new_rating = (sum_rating / (number_rates + 1)).round(1)
        number_rates += 1
        song.update(rating: new_rating)
        song.update(number_of_rates: number_rates)
        
    end

end


    # def self.rating_by_search(user_rating, search) ##<---- WRONG!! you are already the song, you shouldn't look up for songs
    #         song = find_by(title: search)
    #         song_rating = song.rating
    #         number_rates = song.number_of_rates

    #         if number_rates == nil || song_rating == nil
    #             number_rates = 0
    #             song_rating = 0
    #         end
    #         mult_rates = song_rating * number_rates
    #         sum_rating = mult_rates + user_rating
    #         new_rating = (sum_rating / (number_rates + 1)).round(1)
    #         # (song_rating * number_rates)  + user_rating 
    #         # total = total_rating/(number_rates + 1)
    #         number_rates += 1
    #         song.update(rating: new_rating)
    #         song.update(number_of_rates: number_rates)
            
    #     end

# def self.top_latest_songs(number_of_songs)
    #     Song.all.reverse.each_with_index {|song, i| puts "#{i + 1}. #{song.title}"}
    #     puts "6. Search a song or artist"
    #     puts "Please select one option between 1 to 6"
    #     user_choice = gets.chomp
    #     case user_choice
    #         when "1"
    #             Song.rating_song(i)
    #         when "2"
    #             Song.rating_song(i=-2)
    #         when "3"
    #             Song.rating_song(i=-3)
    #         when "4"
    #             Song.rating_song(i=-4)
    #         when "5"
    #             Song.rating_song(i=-5)
    #         when "6"
    #             puts "Please type here your song or artist"
    #             search = gets.chomp
    #             i = 0
    #             while i < Song.all.length do

    #                 artist_name = Song.all[i].artist.name
    #                 song = Song.all[i]
    #                 song_title = song.title

    #                 if  song_title == search
    #                    puts "#{song_title}"
    #                    puts "#{song.rating}"
    #                    puts "#{song.artist.name}"
    #                 elsif artist_name == search
    #                     puts "#{artist_name}"
    #                 end

    #                 i += 1
    #             end

            
                # if Song.find_by(title: search)
                #     Song.find_by(title: search)
                #     Artist.find_by(name: search)
                #     puts "Whould you like to rate this song?"
                #     puts "1. Yes"
                #     puts "2. No"
                #     user_choice = gets.chomp
                #     case user_choice
                #         when "yes" || "Yes"
                #         song_founded.rating
                # end
                #     user_choice = gets.chomp
                #     case user_choice
                #     when "1"
                # end
                 
    #     end    
    # end

    # def self.rating_song(i=0)
    #     song = Song.all[i]
    #     puts "#{song.title}"
    #     puts "#{song.artist.name}"
    #     puts "#{song.rating}"
    #     puts "Would you like to give a rating to this song?"
    #     puts "1. Yes"
    #     puts "2. No"
    #     rate = gets.chomp.to_i
    #     x = 0
    #     case rate
    #         when 1
    #             x += 1
    #             puts "Please give a rate between 1 to 5"
    #             rates = gets.chomp.to_i
    #             total_rating = song.rating + rates
    #             total = total_rating/x
    #             song.update(rating: total)
    #         when 2
    #         call
    #     end
    # end
    