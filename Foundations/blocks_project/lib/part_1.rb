def select_even_nums(arr)
    arr.select(&:even?) 
end

def reject_puppies(arr)
    arr.reject {|dog| dog["age"] <= 2}
end

def count_positive_subarrays(arr)
    arr.count {|subarr| subarr.sum > 0}
end

def aba_translate(word)
   i = 0
   new_word = []
   while i < word.length
        new_word << word[i]
        if "aeiou".include? word[i]
            new_word << 'b'
            new_word << word[i]
        end
        i += 1
   end
   return new_word.join("")
end

def aba_array(words)
     words.map {|word| aba_translate(word)}
end
