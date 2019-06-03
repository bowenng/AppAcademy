# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple 
# of both of the given numbers
def least_common_multiple(num_1, num_2)
    if num_1 < num_2
        temp = num_1
        num_1 = num_2
        num_2 = temp
    end
    return num_1 * num_2 / gcd(num_1, num_2)
end

def gcd(num_1, num_2)
    if num_2 == 0
        return num_1
    end
    return gcd(num_2, (num_1 % num_2))
end


# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    counter = Hash.new(0)
    (0...str.length-1).each do |i|
        bigram = str[i]+str[i+1]
        counter[bigram] += 1
    end

    sorted = counter.sort_by {|k,v| -v}
    return sorted[0][0]
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        inversed = {}
        self.each {|k,v| inversed[v] = k}
        return inversed
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        count = 0
        (0...self.length).each do |i|
            (i+1...self.length).each do |j|
                count += 1 if (self[i]+self[j]) == num
            end
        end
        return count
    end


    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    def bubble_sort(&prc)
        prc ||= Proc.new {|x,y| (x <=> y)}
        (0...self.length-1).each do |t|
            (0...self.length-t-1).each do |i|
                if prc.call(self[i], self[i+1]) > 0
                    swap(self, i, i+1)
                end
            end
        end
        return self
    end
    
    def swap(arr,i,j)
        temp = arr[i]
        arr[i] = arr[j]
        arr[j] = temp
    end
end
