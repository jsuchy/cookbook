class Float
  def number_decimal_places
    self.to_s.length - 2
  end

  def to_fraction
    higher = 10 ** self.number_decimal_places
    lower = self * higher

    gcd = _greatest_common_divisor(higher, lower)

    return (lower / gcd).round, (higher / gcd).round
  end

  def _greatest_common_divisor(a, b)
     while a % b != 0
       a, b = b.round, (a % b).round
     end
     b
  end
end
