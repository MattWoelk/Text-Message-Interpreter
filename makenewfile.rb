#this program should take every british word and store a parallel text file 
#that contains the key-code for that word
#this should make searching for words much MUCH quicker


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

def writeDigits(jumble)
  #create an array of just the symbols for each letter
  wordNums = []
  @iteration = 0
  filename = 'parallelDigits.txt' 
  bool = false
  
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
            wordNums[@iteration] = keyvalue
            #puts "wordNums[#{@iteration}] #{wordNums[@iteration]}"
            File.open filename, 'a' do |f|
              f.print convertToInt(keyvalue).to_s
            end
            bool = true
            
          end
          
        end
        
        end
        
      end
    
    end
    @iteration += 1
    
  end
  
  if(bool) 
    File.open filename, 'a' do |f|
      f.print "\n"
      bool = false
    end
  end
=begin
  wordNums.each do |stuff|
    puts stuff
  end
=end
  
=begin
if(bool) 
  File.open filename, 'a' do |f|
    f.print "\n"
    bool = false
  end
end
=end

end



if __FILE__ == $0
  jumble = "melon"
  wordNums = []
  #Maps keypad keys to the letters which they produce
  
  #this wipes the file that we will append to
  filename = 'parallelDigits.txt' 
  File.open filename, 'w' do |f|
    f.print ""
  end
  
  file = File.new("everybritishword.txt", "r")
  while (line = file.gets)
    writeDigits(line.chomp)
  end
  file.close
end

