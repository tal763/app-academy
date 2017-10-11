#
# Exercise #1 - sum to n

def sum_to(n)
  return 1 if n == 1
  return 0 if n == 0
  return nil if n < 0
  n + sum_to(n - 1)
end

# Exercise #2 - add numbers

def add_numbers(arr)
  return arr.first if arr.length <= 1
  arr.pop + add_numbers[arr]
end

# Exercise #3 - Gamma Function
# Gamma function defined as gamma(n) = (n - 1)!

def gamma_fnc(n)
  return 1 if n == 1
  (n - 1) * gamma_fnc(n - 1)
end

# Exercise #4 - Ice Cream Shop

def ice_cream_shop(flavors, favorite)
  return false if flavors.empty?
  return true if flavors.last == favorite
  ice_cream_shop(flavors[0..-1], favorite)
end


# Exercise #5 - Reverse

def reverse(string)
  return string if string.length <= 1
  string[-1] + reverse(string[0..-2])
end
