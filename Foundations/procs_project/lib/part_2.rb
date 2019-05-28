def reverser(str, &func)
    func.call(str.reverse)
end

def word_changer(str, &func)
    new_str = []
    str.split(" ").each {|word| new_str << func.call(word)}
    new_str.join(" ")
end

def greater_proc_value(number, f1, f2)
    n1 = f1.call(number)
    n2 = f2.call(number)
    if n1 > n2
        return n1
    else
        return n2
    end
end

def and_selector(arr, f1, f2)
    new_arr = []
    arr.each {|el| new_arr << el if f1.call(el) && f2.call(el)}
    new_arr
end

def alternating_mapper(arr, f1, f2)
    new_arr = []
    arr.each_with_index do |el, i|
        if i.even?
            new_arr << f1.call(el)
        else
            new_arr << f2.call(el)
        end
    end
    new_arr
end