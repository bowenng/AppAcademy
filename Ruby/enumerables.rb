class Array 
    def my_each (&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
    end

    def my_select(&prc)
        selected = []
        self.each {|el| selected << el if prc.call(el)}
        return selected
    end

    def my_reject(&prc)
        rejected = []
        self.each {|el| rejected << el if !prc.call(el)}
        rejected
    end

    def my_any?(&prc)
        self.each {|el| return true if prc.call(el)}
        return false
    end

    def my_all?(&prc)
        self.each {|el| return false if !prc.call(el)}
        return true
    end
    
    def my_flatten(arr=nil)
        arr ||= self
        if !arr.is_a?(Array)
            return [arr]
        end

        master_arr = []
        arr.each do |subarr|
            master_arr += my_flatten(subarr)
        end
        return master_arr

    end

    def my_zip(*arrs)
        zipped = []
        self.each_with_index do |el, i|
            to_join = []
            arrs.each {|sub_arr| to_join << sub_arr[i]}
            zipped << ([el] + to_join)
        end
        return zipped
    end

    def my_rotate(indices=1)
        to_shift = indices % self.length
        to_rotate = self[0...to_shift]
        self[0...self.length-to_shift] = self[to_shift...self.length]
        self[self.length-to_shift...self.length] = to_rotate
        self
    end

    def my_join(delimiter="")
        str = ""
        (0...self.length-1).each {|i| str += self[i].to_s + delimiter}
        str + self[-1].to_s
    end

    def my_reverse
        reversed = []
        self.each {|el| reversed.unshift(el)}
        reversed
    end
end

def printf(str)
    print str
    print "\n"
end

if __FILE__ == $0
    # my_each
    puts "my_each"
    return_value = [1, 2, 3].my_each do |num|
        puts num
    end
    puts "="*20

    # my_select
    puts "my_select"
    a = [1, 2, 3]
    printf a.my_select { |num| num > 1 } # => [2, 3]
    printf a.my_select { |num| num == 4 } # => []
    puts "="*20

    # my_reject
    puts "my_reject"
    a = [1, 2, 3]
    a = [1, 2, 3]
    printf a.my_reject { |num| num > 1 } # => [1]
    printf a.my_reject { |num| num == 4 } # => [1, 2, 3]
    puts "="*20

    # my_any?/all?
    puts "my_any?all?"
    printf a.my_any? { |num| num > 1 } # => true
    printf a.my_any? { |num| num == 4 } # => false
    printf a.my_all? { |num| num > 1 } # => false
    printf a.my_all? { |num| num < 4 } # => true
    puts "="*20

    # my_flatten
    puts "my_flatten"
    printf [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]
    puts "="*20

    # my_zip
    puts "my_zip"
    a = [ 4, 5, 6 ]
    b = [ 7, 8, 9 ]
    printf [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
    printf a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
    printf [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

    c = [10, 11, 12]
    d = [13, 14, 15]
    printf [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
    puts "="*20

    # my_rotate
    puts "my_rotate"
    a = [ "a", "b", "c", "d" ]
    printf a.my_rotate         #=> ["b", "c", "d", "a"]
    a = [ "a", "b", "c", "d" ]
    printf a.my_rotate(2)      #=> ["c", "d", "a", "b"]
    a = [ "a", "b", "c", "d" ]
    printf a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
    a = [ "a", "b", "c", "d" ]
    printf a.my_rotate(15)     #=> ["d", "a", "b", "c"]
    puts "="*20

    # my_join
    puts "my_join"
    a = [ "a", "b", "c", "d" ]
    printf a.my_join         # => "abcd"
    printf a.my_join("$")    # => "a$b$c$d"
    puts "="*20

    # my_reverse
    puts "my_reverse"
    printf [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
    printf [ 1 ].my_reverse               #=> [1]
    puts "="*20
end