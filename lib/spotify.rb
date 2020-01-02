class Spotify

    @@username = "Guest"
    @@logged_in_user = nil
    @@selected_song = nil
    @@selected_playlist = nil


    def home
        puts "\t\t░██████╗██████╗░░█████╗░████████╗██╗███████╗██╗░░░██╗"
        puts "\t\t██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██║██╔════╝╚██╗░██╔╝"
        puts "\t\t╚█████╗░██████╔╝██║░░██║░░░██║░░░██║█████╗░░░╚████╔╝░"
        puts "\t\t░╚═══██╗██╔═══╝░██║░░██║░░░██║░░░██║██╔══╝░░░░╚██╔╝░░"
        puts "\t\t██████╔╝██║░░░░░╚█████╔╝░░░██║░░░██║██║░░░░░░░░██║░░░"
        puts "\t\t╚═════╝░╚═╝░░░░░░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░░░░╚═╝░░░"
        puts "                                  The best music player\n\n"
        puts "\t1. New user"
        puts "\t2. Existing user"
        puts "\t3. Guest"
        puts "\t0. Exit\n\n"
        puts "Please select an option"
        option = gets.chomp
        while option != "0"
            case option
            when 1 ## CREATE NEW USER
                print "Please enter a username: "
                @@username = gets.chomp
                user_created = User.create_new(@@username)
                if user_created
                    @@logged_in_user = User.find_by(username: @@username)
                    puts "Your username is: #{@@username}"
                    show_latest_songs
                end
            when "2" ## EXISTING USER
                print "Please enter a username: "
                @@username = gets.chomp
                user = User.check_user(@@username)
                if user
                    @@logged_in_user = User.find_by(username: @@username)
                    show_latest_songs
            end
            when "3" #GUEST
                show_latest_songs
            when "0" #EXIT  
            else
                print "Please enter a valid option: "
                option = gets.chomp
            end 
        end
        exit!
    end

    #### LOGO ####

    def logo
        puts "-------------------------------------------------------------------------------------"
        puts "|                                    SPOTIFY                                        |"
        puts "-------------------------------------------------------------------------------------"
        puts "                             The best music player\n\n"
    end

    ### LATEST SONGS ###

    def show_latest_songs
        logo
        puts "Welcome #{@@username}, what song would you like to select?\n\n" ## <-- DOESN'T WORK FOR GUESTS
        puts "Here are the latest songs:\n\n"
        latest_songs = Song.last(5)
        latest_songs.each_with_index {|song, i| puts "\t#{i + 1}. #{song.title}"} ## <-- SHOWING LAST 5 SONGS
        puts "\t--------------------------"
        puts "\t6. Search a song or artist"
        puts "\t7. Your playlists\n\n"
        puts "\t0. Exit\n\n"
        print "Please select one option: "
        option = gets.chomp.to_i
        while option != 0
            case option
            when 6
                search_artist_song
            when 7
                check_if_user_has_playlist
            else
                if option > 0 && option < 6 
                    @@selected_song = latest_songs[option - 1]
                    show_song_options
                else
                    print "Please enter a valid option: "
                    user_choice = gets.chomp.to_i
                end
            end     
        end
        exit!
    end

    ### SELECT FROM PLAYLIST ####

    def select_from_playlist
        print "Please type here one of the options: "
        user_input = gets.chomp.to_i
        while user_input != 0 || user_input != "0"
            case user_input
            when user_input
                logo
                @@selected_playlist = @@logged_in_user.playlists[user_input - 1]
                list_songs = @@selected_playlist.songs.map{|song| song}.last(6)
                each_song = list_songs.each_with_index{|song, i| puts "\t#{i + 1}. #{song.title}"}
                puts "-------------------------"
                puts "\t7. Delete song from this playlist"
                puts "\t8. Delete playlist"
                puts "\t9. Rename your playlist"
                puts "\t0. Back\n\n"
                print "Please choose one of the options: "
                user_choice = gets.chomp.to_i
                case user_choice
                when 7
                    print "Type the number of the song: "
                    song_number = gets.chomp.to_i
                    @@selected_song = list_songs[song_number - 1]
                    puts "Are you sure you want to delete the song: #{@@selected_song.title}"
                    puts "1. Yes"
                    puts "2. No"
                    user_decision = gets.chomp.to_i
                    while user_decision !=2
                        case user_decision
                        when 1
                            playlist_songs = @@selected_playlist.songs
                            position_of_song = playlist_songs.where(title: @@selected_song.title)
                            playlist_songs.delete(position_of_song)
                            show_latest_songs
                        #  @@selected_playlist.select{|playlist| (playlist.songs == @@selected_song).delete()}
                        #  song.delete()
                        else
                            print "Please type a valid option: "
                            user_decision = gets.chomp.to_i
                        end
                    end
                    select_from_playlist
                when 8
                    puts "Are you sure you want to delete this playlist?"
                    puts "1. Yes"
                    puts "2. No"
                    user_decision = gets.chomp.to_i
                    case user_decision
                    when 1 
                        @@selected_playlist.delete()
                        # @@logged_in_user.save
                        puts "Your playlist has been deleted"
                        @@logged_in_user = User.find(@@logged_in_user.id)
                        check_if_user_has_playlist
                    when 2
                        select_from_playlist
                    end
                when 9
                    puts "Would you like to rename your playlist?"
                    puts "1. Yes"
                    puts "2. No"
                    print "Choose an option: "
                    user_input = gets.chomp.to_i
                    case user_input
                    when 1
                        puts "How would you like to rename your playlist called: #{@@selected_playlist.name}?"
                        print "Please type here the new name: "
                        new_name = gets.chomp
                        @@selected_playlist.update(name: new_name)
                    when 2
                        select_from_playlist
                    end
            else
                if user_choice > 0 && user_choice < 9
                    @@selected_song = list_songs[user_choice - 1]
                    show_song_options
                end
            end
            end
            show_latest_songs
        end
        
    end

    ### CHECK IF USER HAS PLAYLISTS ###

    def check_if_user_has_playlist
        logo
        user_playlists = @@logged_in_user.playlists.last(5)
        if user_playlists.first != nil
            puts "Hey #{@@username}. Your latest 7 playlists created:\n\n"
            playlist = user_playlists.each_with_index{|playlist, i| puts "\t#{i + 1}. #{playlist.name}"}
            puts "------------------------------------------------"
            puts "\t9. Create a new playlist"
            puts "\t0. Back\n\n"
            print "Choose an option: "
            user_input = gets.chomp.to_i
            case user_input
            when 9 
                logo
                print "How would you like to name your playlist?\n\n"
                playlist_name = gets.chomp
                create_playlist(playlist_name)
                select_from_playlist
            end
            select_from_playlist
        else
            logo
            puts "Hey #{@@username} you don't have any playlist yet, would you like to create one?\n\n"
            puts "1. Yes"
            puts "2. No\n\n"
            print "Please select here your option: " 
            user_input = gets.chomp.to_i
            case user_input
            when 1
                puts "How would you like to name your playlist?\n\n"
                print "Type here please: "
                playlist_name = gets.chomp
                create_playlist(playlist_name)
                check_if_user_has_playlist
            when 2 
                show_latest_songs
            end
        end
        show_latest_songs
    end

    def create_playlist(playlist_name)
        @@logged_in_user.playlists << Playlist.create(name: playlist_name)
    end
    
    ### SHOW SONGS ###

    def show_song_options(search = false)
        logo
        if search
            puts "This is the search result:\n\n"
        else
            puts "You have selected:\n\n"
        end
        puts "\t - Song: #{@@selected_song.title}"
        puts "\t - Artist: #{@@selected_song.artist.name}"
        puts "\t - Rating: #{@@selected_song.rating}\n\n"
        puts "What would you like to do with this song?\n\n"
        puts "1. Rate this song"
        puts "2. Add to playlist"
        puts "0. Go back\n\n"
        print "Please select one option: "
        user_choice = gets.chomp.to_i
        while user_choice != 0
            case user_choice
                when 1 ## RATE THE SONG
                    print "Please give a rating between 1 to 5 "
                    user_rate = gets.chomp.to_i
                    if user_rate < 6 && user_rate > 0
                        song = @@selected_song
                        song.rate(user_rate, song)
                        logo
                        puts "Thank you for your rating, would you like to check this song again?\n\n"
                        puts "\t1. Yes"
                        puts "\t2. No (Go back to latest songs)\n\n"
                        print "Please type here your decision: "
                        user_decision = gets.chomp
                        while user_decision != "0"
                            if user_decision == "1" || user_decision == "yes" || user_decision == "Yes"
                                show_song_options
                            elsif user_decision == "2" || user_decision == "no" || user_decision == "No"
                                show_latest_songs
                            else
                                print "Please enter a valid option: "
                                user_decision = gets.chomp
                            end
                        end
                    else
                        logo
                        puts "Please you have to choose between 1 and 5."
                        puts "Redirecting to the song options in: "
                        puts "3"
                        sleep(1)
                        puts "2"
                        sleep(1)
                        puts "1"
                        sleep(1)
                        show_song_options
                    end
                when 2 ## ADD TO A PLAYLIST
                    if @@logged_in_user.playlists != []
                        show_playlists
                        print "\n\nSelect a playlist to add the song:"
                        user_input = gets.chomp.to_i
                        @@selected_playlist = @@logged_in_user.playlists[user_input - 1].songs
                        song = @@selected_song
                        @@selected_playlist << song
                        show_latest_songs
                        puts "Would you like to add this song to your playlist?\n\n"
                    else 
                        check_if_user_has_playlist
                    end
                else
                    puts "You have to select a valid option: "
                    user_choice = gets.chomp
            end
        end
        show_latest_songs
    end

    ### SHOW PLAYLISTS ###

    def show_playlists
        logo
        playlists = @@logged_in_user.playlists
        
        if playlists.count > 0 
            latest_five_playlists = playlists.last(5)
            latest_five_playlists.each_with_index{|playlist, i| puts "\t#{i+1}. #{playlist.name}"}
        elsif
            check_if_user_has_playlist
        end
        
    end

    ### SEARCH METHOD FOR ARTIST AND SONGS ###

    def search_artist_song
        logo
        puts "\t1. Search artist"
        puts "\t2. Search song"
        puts "\t0. Back\n\n"
        print "Please select an option: "
        option = gets.chomp
        while option != "0"
            case option
                when "1"
                    search_artist
                when "2"
                    search_song
                else
                    print "Please select a valid option: "
                    option = gets.chomp
            end
        end
        show_latest_songs

        # artist = search_artist(user_input)
        # song = search_song(user_input)
    end

    def show_rate_options
    
    end

    def show_artist_options(artist)
    
    end

    ### SEARCH SONG ####

    def search_song
        print "Which song would you like to search: "
        user_input = gets.chomp
        does_song_exist = Song.find_by(title: user_input) 
        if does_song_exist
            @@selected_song = Song.find_by(title: user_input)
            show_song_options(true)
        else
            logo
            puts "This song doesn't exist in Spotify yet"
            puts "Redirecting to our latest song in"
            puts "5"
            sleep(1)
            puts "4"
            sleep(1)
            puts "3"
            sleep(1)
            puts "2"
            sleep(1)
            puts "1"
            show_latest_songs
        end   
    end

    ### SEARCH ARTIST ###

    def search_artist
        print "What artist would you like to search: "
        user_input = gets.chomp
        all_songs = Artist.last_songs(user_input)
        if all_songs != false
            logo
            puts "Hey #{@@username} this are the last 8 songs from this artist:\n\n"
            last_eigth_songs = all_songs
            last_eigth_songs.each_with_index{ |song, i| puts "\t #{i + 1}. #{song.artist.name}: #{song.title}"}
            puts "\t 9. Show all songs from this artist"
            puts "\t 0. Go back to latest 5 songs\n\n"
            print "Please select an option: "
            user_input = gets.chomp.to_i
            while user_input != 0 do
                case user_input
                when 9 ## <-- new method for below code
                    logo
                    puts "This are all the songs from this artist: "
                    all_songs.each{|song| puts "\t * #{song.artist.name}: #{song.title}"}
                    puts "What would you like to do?"
                    puts "1. Search for a song or an artist"
                    puts "2. Go back to latest songs"
                    puts "3. Log out\n\n"
                    print "Please type an option: "
                    user_input = gets.chomp.to_i
                    case user_input
                    when 1
                        search_artist_song
                    when 2
                        show_latest_songs
                    when 3
                        home
                    else
                        print "Please type a valid option: "
                        user_input = gets.chomp.to_i
                    end
        else
            if user_input <= 8 && user_input > 0
                @@selected_song = last_eigth_songs[user_input - 1]
                show_song_options
            else
            print "Please type a valid option: "
            user_input = gets.chomp.to_i
            end
        end
            end
            show_latest_songs
        else
            puts "This artist doesn't exist in Spotify yet"
            puts "Redirecting to our latest song in"
            puts "5"
            sleep(1)
            puts "4"
            sleep(1)
            puts "3"
            sleep(1)
            puts "2"
            sleep(1)
            puts "1"
            show_latest_songs
        end
        
    end

    # def self.load_test_data


    # end

end