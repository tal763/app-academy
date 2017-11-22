# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue ArgumentError
    puts "Enter a number"
    str = gets.chomp
    retry
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  else
    raise StandardError.new("That's not a fruit")
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue StandardError
    p "I'll let you try again after I have some coffee!"
    give_coffee = gets.chomp
    if give_coffee == "coffee"
      retry
    end
  end
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    begin
    @name = name
      if @name.length <= 0
        raise ArgumentError.new "You don't know your BFFs name??!?"
      end

    @yrs_known = yrs_known
      unless @yrs_known > 5
        raise ArgumentError.new "You haven't known them long enough to be BFFs!"
      end
    
    @fav_pastime = fav_pastime
      if @fav_pastime.length <= 0
        raise ArgumentError.new "No pastime!"
      end
    end
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end

# Questions:
# if you raise and error, does it automatically look for a rescue block
