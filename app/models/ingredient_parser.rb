class IngredientParser

  def initialize(str, ingredient)
    @tokens = str.split
    @result = ingredient
    @state = :quantity
    @ingredient_words = []
    @instruction_words = []
  end

  UNITS = %w{ cups pounds ounces tablespoons teaspoons cans cloves }

  def parse
    @tokens.each do |token|
      redo unless self.send(@state, token)
    end

    @result.ingredient = @ingredient_words.join(" ")
    @result.instruction = @instruction_words.join(" ")
    @result
  end

  def quantity(token)
    if token.include?("/")
      numerator, denominator = token.split("/")
      fraction = Rational(numerator.to_i, denominator.to_i)
      @result.quantity += fraction.to_f
    elsif token.to_f > 0
      @result.quantity += token.to_f
    end

    @state = :uom
  end

  def uom(token)
    if is_a_number?(token)
      @state = :quantity
      return false
    else
      @state = :ingredient
      if is_a_unit?(token)
        @result.uom = token.pluralize
        return true
      else
        return false
      end
    end
  end

  def ingredient(token)
    @ingredient_words << token

    if is_start_of_instructions?(token)
      chop_last_ingredient
      @state = :instruction
    end
    return true
  end

  def instruction(token)
    @instruction_words << token
  end

  def is_a_number?(token)
    return token.to_i > 0
  end

  def is_a_unit?(token)
    return UNITS.include?(token) || UNITS.include?(token.pluralize)
  end

  def is_start_of_instructions?(token)
    return token.ends_with?(",")
  end

  def chop_last_ingredient
    @ingredient_words.last.chop!
  end
end
