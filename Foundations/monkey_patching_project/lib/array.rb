# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        if !self.empty?
            self.max - self.min
        else
            nil
        end
    end

    def average
        if self.empty?
            nil
        else
            self.sum/self.length.to_f
        end
    end

    def median
        if self.empty?
            nil
        elsif self.length.even?
            sorted_arr = self.sort
            (sorted_arr[self.length/2]+sorted_arr[self.length/2-1])/2.0
        else
            sorted_arr = self.sort
            sorted_arr[self.length/2]
        end

    end

    def counts
        counter = Hash.new(0)
        self.each {|el| counter[el] += 1}
        counter
    end

    def my_count(value)
        count = 0
        self.each {|el| count += 1 if el == value}
        count
    end

    def my_index(value)
        self.each_with_index {|el, i| return i if el == value}
        return nil
    end

    def my_uniq
        new_arr = []
        self.each {|el| new_arr << el if !(new_arr.include? el)}
        return new_arr
    end

    def my_transpose
        if self.empty?
            return self
        end
        new_arr = []

        m = self.length
        n = self[0].length
        (0...n).each do |j|
            new_subarr = []
            (0...m).each do |i|
                new_subarr << self[i][j]
            end
            new_arr << new_subarr
        end
        new_arr
    end
end
