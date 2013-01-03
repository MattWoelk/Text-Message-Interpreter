#ruby program to help interpret text messages where someone hit the wrong key by accident. (and did other things wrong too)
#THIS VERSION IS VERY INCOMPLETE
@@numberToLetter = {"one" => ['1','"',"'",'!','?','.','(',')','@','~','&',',','-','=',':',';','/','#'], "two" => ['a','b','c','A','B','C'], "three" => ['d','e','f','D','E','F'], "four" => ['g','h','i','G','H','I'], "five" => ['j','k','l','J','K','L'], "six" => ['m','n','o','M','N','O'], "seven" => ['p','q','r','s','P','Q','R','S'], "eight" => ['t','u','v','T','U','V'], "nine" => ['w','x','y','z','W','X','Y','Z'], "zero" => ['0']}

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



def possibilities(wordNums)
  #case: correct buttons were pressed, but wrong word was sent.
  #print out all possibilities
  file = File.new("parallelDigits.txt", "r")
  while (line = file.gets)
    if line.nil? == false && line.chomp.length == wordNums.length && findWords(line.chomp).length == wordNums.length && (findWords(line) <=> wordNums.to_s) == 0
      puts "WE FOUND ONE: #{line}"
    end
  end
  file.close
  
end



if __FILE__ == $0
  jumble = "melon"
  wordNums = []
  
  #Maps keypad keys to the letters which they produce
  
  #puts numberToLetter[:zero][0]
  
  jumble = gets
  wordNums = findWords(jumble)
  puts wordNums.to_s
  possibilities(wordNums)
  
  
end

