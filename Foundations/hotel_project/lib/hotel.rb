require_relative "room"

class Hotel
    def initialize(name, room_cap)
        @name = name
        @rooms = {}
        room_cap.each do |name, cap|
            @rooms[name] = Room.new(cap)
        end
    end

    def name
        @name.split(" ").map(&:capitalize).join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(name)
        @rooms.keys().include? name
    end

    def check_in(person, room_name)
        if room_exists?(room_name)
            room = @rooms[room_name]
            if room.full?
                print "sorry, room is full"
            else
                 @rooms[room_name].add_occupant(person)
                print "check in successful"
            end
        else
            print "sorry, room does not exist"
        end
    end
        
    def has_vacancy?
        @rooms.values.any? {|room| return true if room.available_space > 0}
        return false
    end

    def list_rooms
        @rooms.each {|name, room| puts ("#{name} : #{room.available_space}")}
    end
    

end
