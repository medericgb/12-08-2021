str = "minimiser"

def occurence(word)
  list = word.chars
  hash = Hash.new
  list.each do |char|
    # hash[char] += 1
    hash[char] = word.count(char)
  end
  p hash
end

occurence(str)