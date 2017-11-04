class Movie
  @@CHILDRENS = 2
  @@REGULAR = 0
  @@NEW_RELEASE = 1

  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title = title
    @price_code = price_code
  end
end

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end
end

class Customer
  attr_reader :name, :rentals

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    rentals << rental
  end

  def statement
    total_amount = 0
    frequent_rental_points = 0
    result = "Rental Record for #{name} \n"

    while rentals.any?
      this_amount = 0
      each = rentals.shift

      case each.movie.price_code
      when Movie.REGULAR
        this_amount += 2
        if each.days_rented > 2
          this_amount += (each.days_rented - 2) * 1.5
        end
        break
      when Movie.NEW_RELEASE
        this_amount += each.days_rented * 3
      when Movie.CHILDRENS
        this_amount += 1.5
        if each.days_rented > 3
          this_amount += (each.days_rented - 3) * 1.5
        end
        break
      end
      
      frequent_rental_points += 1
  
      if each.movie.price_code == Movie.NEW_RELEASE && each.days_rented > 1
        frequent_rental_points += 1
      end
  
      result += "\t#{each.movie.title}\t#{this_amount}\n"
      total_amount += this_amount
    end

    result += "Amount owed is #{total_amoubt}\n"
    result += "You earned #{frequent_rental_points} frequent renter points"
    result
  end
end
