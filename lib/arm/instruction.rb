module Arm
  # The arm machine has following instruction classes
  # - Memory
  # - Stack
  # - Logic
  # - Math
  # - Control/Compare
  # - Move
  # - Call  class Instruction
  class Instruction
    include Positioned

    def initialize  options
      @attributes = options
    end
    attr_reader :attributes
    def opcode
      @attributes[:opcode]
    end

    # for the shift handling that makes the arm so unique
    def shift val , by
      raise "Not integer #{val}:#{val.class} #{inspect}" unless val.is_a? Fixnum
      val << by
    end

    # this is giving read access to the attributes hash via .attibute syntax
    # so for an instruction pop you can write pop.opcode to get the :opcode attribute

    # TODDO: review (don't remember what the "set_" stuff was for)
    def method_missing name , *args , &block
      return super unless (args.length <= 1) or block_given?
      set , attribute = name.to_s.split("set_")
      if set == ""
        @attributes[attribute.to_sym] = args[0] || 1
        return self
      else
        return super
      end
      return @attributes[name.to_sym]
    end
  end
end

require_relative "constants"
require_relative "instructions/call_instruction"
require_relative "instructions/compare_instruction"
require_relative "instructions/logic_instruction"
require_relative "instructions/memory_instruction"
require_relative "instructions/move_instruction"
require_relative "instructions/stack_instruction"
