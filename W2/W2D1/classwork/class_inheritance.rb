class Employee
  attr_accessor :salary, :boss
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end



class Manager < Employee
  attr_accessor :employees
  def initialize(name, title, salary, boss, employees)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @employees = [employees]
  end

  def bonus(multiplier)
    my_big_bonus_mult = 0
    @employees.each do |employee|
      my_big_bonus_mult += employee.salary
    end

    my_big_bonus_mult * multiplier
  end
end
