require 'pry'
class User < ActiveRecord::Base

    has_many :playlists

    def self.create_new(username)    
        user = find_by(username: username)
        if user == nil
            user = create(username: username)
            return true
        else
            puts "User already exist"
            return false
        end
    end

    def self.check_user(username) ##<--- Verb like: Verify.. Validate.. or Check
        user_check = find_by(username: username)
        if user_check != nil
            return true
        else
            puts "This username doesn't exist"
            return false
        end
    end

    def each_song
        
    end
end