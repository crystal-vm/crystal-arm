module Arm

  # Registers have off course a name (r1-16 for arm)
  # but also refer to an address. In other words they can be an operand for instructions.
  # Arm has addressing modes abound, and so can add to a register before actually using it
  # If can actually shift or indeed shift what it adds, but not implemented
  class Register
    attr_accessor :name , :offset , :bits
    def initialize name , bits
      @name = name
      @bits = bits
      @offset = 0
    end

    # this is for the dsl, so we can write pretty code like r1 + 4
    # when we want to access the next word (4) after r1
    def + number
      @offset = number
      self
    end
  end

end
