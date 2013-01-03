#ruby program to help interpret text messages where someone hit the wrong key by accident. (and did other things wrong too)
#this version shows more options 
@@numberToLetter = {"one" => ['1','"',"'",'!','?','.','(',')','@','~','&',',','-','=',':',';','/','#'], "two" => ['a','b','c','A','B','C'], "three" => ['d','e','f','D','E','F'], "four" => ['g','h','i','G','H','I'], "five" => ['j','k','l','J','K','L'], "six" => ['m','n','o','M','N','O'], "seven" => ['p','q','r','s','P','Q','R','S'], "eight" => ['t','u','v','T','U','V'], "nine" => ['w','x','y','z','W','X','Y','Z'], "zero" => ['0']}
@@reference = []
@@wordlist = []

def loadItUp!(place, filename)
  file = File.new(filename, "r")
  while (line = file.gets)
    place << line
  end
  file.close
end

def convertToInt(theString)
  return 1 if theString == "one"
  return 2 if theString == "two" 
  return 3 if theString == "three"
  return 4 if theString == "four" 
  return 5 if theString == "five" 
  return 6 if theString == "six" 
  return 7 if theString == "seven"
  return 8 if theString == "eight"
  return 9 if theString == "nine" 
  return 0 if theString == "zero" 
  return 999
end

def findWords(jumble)
  #create an array of just the symbols for each letter
  wordNums = []
  @iteration = 0
  
  jumble.chomp.each_char do |letter|
    #puts letter
    @@numberToLetter.each do |keyvalue, array1|
      #puts "  #{array1}"
      array1.each do |word1|
        #puts "    #{word1}"
        #puts "    #{word1} == #{letter}?"
        if word1.respond_to?("each") then word1.each do |char1|
          #puts "      #{char1}"
          if char1 == letter
            wordNums[@iteration] = convertToInt(keyvalue)
            #puts "wordNums[#{@iteration}] #{wordNums[@iteration]}"
          end
        end
        end
      end
    
    end
    @iteration += 1
  end
  
=begin
  wordNums.each do |stuff|
    puts stuff
  end
=end
  return wordNums  #for some reason this is returning nil
end


def findInitial(wordNums)
  #this is a binary search
  position = 0
  iteration = 1
  #puts !(@@reference[position].nil?)
  while @@reference[position][0,1].to_i != wordNums[0]
    if (@@reference[position].nil?)
      position += 1
    else
      #puts "position: #{position}"
      if @@reference[position][0,1].to_i < wordNums[0]
        position += @@reference.length/(2**iteration) #exponent
      else
        position -= @@reference.length/(2**iteration) #exponent
      end
      iteration += 1
    end
  end
  #puts "start position: #{position}"
  return position
end


def possibilities(wordNums, initialposition = 0)
  #case: correct buttons were pressed, but wrong word was sent.
  #print out all possibilities
  @keepgoing = true
  @down = true
  @position = initialposition
  while @keepgoing
    #puts "position: #{@position}"
    #puts @@wordlist[@position]
    if !@@reference[@position].nil? && @@reference[@position].chomp.length == wordNums.length && (@@reference[@position].chomp <=> wordNums.to_s.chomp) == 0
      puts "WE FOUND ONE: #{@@wordlist[@position]}"
    end
    
    if @down
      @position += 1
    else
      @position -= 1
    end
    #puts "down: #{@down}"
    #puts "wN:   "
    #puts wordNums[0]
    #puts "ref:  "
    #puts @@reference[@position][0,1]
    #puts "comb: "
    #puts @@reference[@position][0,1].to_i == wordNums[0]
    #puts @@wordlist[@position]
    if (@down && !(@@reference[@position].nil?) && @@reference[@position][0,1].to_i != wordNums[0]) || @position == @@wordlist.length
      if @down == true
        @down = false 
        @position = initialposition
      end
    elsif !@down && !(@@reference[@position].nil?) && @@reference[@position][0,1].to_i != wordNums[0]
      @keepgoing = false
    end
    
  end#end while
  
end#end possibilities



if __FILE__ == $0
  jumble = "melon"
  wordNums = []
  
  loadItUp!(@@reference, "parallelDigits.txt")
  loadItUp!(@@wordlist, "everybritishword.txt")
  
  #Maps keypad keys to the letters which they produce
  
  #puts numberToLetter[:zero][0]
  jumble = gets
  wordNums = findWords(jumble)
  puts wordNums.to_s
  puts " Same pressed digits:"
  possibilities(wordNums, findInitial(wordNums))
  puts "\n Other options:"
  
  (0..9).each do |car|
    wordNums = findWords(jumble) << car
    #puts "\nadded #{car} to the end: "
    #puts wordNums.to_s
    possibilities(wordNums, findInitial(wordNums))
  end
  
  
end









