def all_words_capitalized?(words)
    words.all? {|word| word[0].upcase == word[0] && word[1..-1].downcase == word[1..-1]}
end

def no_valid_url?(urls)
    urls.none? {|url| url.end_with?(".com", ".net", ".io",  ".org")}
end

def any_passing_students?(students)
    students.any? {|student| student[:grades].sum/student[:grades].length.to_f >= 75}
end
