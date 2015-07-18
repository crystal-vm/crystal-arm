module Arm

  module Constants
    OPCODES = {
      :adc => 0b0101, :add => 0b0100,
      :and => 0b0000, :bic => 0b1110,
      :eor => 0b0001, :orr => 0b1100,
      :rsb => 0b0011, :rsc => 0b0111,
      :sbc => 0b0110, :sub => 0b0010,

      # for these Rn is sbz (should be zero)
      :mov => 0b1101,
      :mvn => 0b1111,
      # for these Rd is sbz and S=1
      :cmn => 0b1011,
      :cmp => 0b1010,
      :teq => 0b1001,
      :tst => 0b1000,

      :b => 0b1010,
      :call=> 0b1011
    }
    #return the bit patter that the cpu uses for the current instruction @attributes[:opcode]
    def op_bit_code
      bit_code = OPCODES[opcode]
      bit_code or raise "no code found for #{opcode} #{inspect}"
    end

    #codition codes can be applied to many instructions and thus save branches
    # :al => always   , :eq => equal  and so on
    # eq mov if equal :moveq r1 r2 (also exists as function) will only execute
    #  if the last operation was 0
    COND_CODES = {
      :al => 0b1110, :eq => 0b0000,
      :ne => 0b0001, :cs => 0b0010,
      :mi => 0b0100, :hi => 0b1000,
      :cc => 0b0011, :pl => 0b0101,
      :ls => 0b1001, :vc => 0b0111,
      :lt => 0b1011, :le => 0b1101,
      :ge => 0b1010, :gt => 0b1100,
      :vs => 0b0110
    }
    # return the bit pattern for the @attributes[:condition_code] variable,
    # which signals the conditional code
    def cond_bit_code
      COND_CODES[@attributes[:condition_code]] or throw "no code found for #{@attributes[:condition_code]}"
    end

    REGISTERS = { 'r0' => 0, 'r1' => 1, 'r2' => 2, 'r3' => 3, 'r4' => 4, 'r5' => 5,
                  'r6' => 6, 'r7' => 7, 'r8' => 8, 'r9' => 9, 'r10' => 10, 'r11' => 11,
                  'r12' => 12, 'r13' => 13, 'r14' => 14, 'r15' => 15, 'a1' => 0, 'a2' => 1,
                  'a3' => 2, 'a4' => 3, 'v1' => 4, 'v2' => 5, 'v3' => 6, 'v4' => 7, 'v5' => 8,
                  'v6' => 9, 'rfp' => 9, 'sl' => 10, 'fp' => 11, 'ip' => 12, 'sp' => 13,
                  'lr' => 14, 'pc' => 15 }
    def reg r_name
      code = reg_code r_name
      raise "no such register #{r_name}" unless code
      Arm::Register.new(r_name.to_sym , code )
    end
    def reg_code r_name
      raise "double r #{r_name}" if( :rr1 == r_name)
      if r_name.is_a? ::Register::RegisterReference
        r_name = r_name.symbol
      end
      if r_name.is_a? Fixnum
        r_name = "r#{r_name}"
      end
      r = REGISTERS[r_name.to_s]
      raise "no reg #{r_name}" if r == nil
      r
    end

   def calculate_u8_with_rr(arg)
     parts = arg.to_s(2).rjust(32,'0').scan(/^(0*)(.+?)0*$/).flatten
     pre_zeros = parts[0].length
     imm_len = parts[1].length
     if ((pre_zeros+imm_len) % 2 == 1)
       u8_imm = (parts[1]+'0').to_i(2)
       imm_len += 1
     else
       u8_imm = parts[1].to_i(2)
     end
     if u8_imm.fits_u8?
       # can do!
       rot_imm = (pre_zeros+imm_len) / 2
       if (rot_imm > 15)
         return nil
       end
       return u8_imm | (rot_imm << 8)
     else
       return nil
     end
   end

   #slighly wrong place for this code, but since the module gets included in instructions anyway . . .
   # implement the barrel shifter on the operand (which is set up before as an integer)
   def shift_handling
     op = 0
     #codes that one can shift, first two probably most common.
     # l (in lsr) means logical, ie unsigned, a (in asr) is arithmetic, ie signed
     shift_codes = {'lsl' => 0b000, 'lsr' => 0b010, 'asr' => 0b100, 'ror' => 0b110, 'rrx' => 0b110}
     shift_codes.each do |short, bin|
       long = "shift_#{short}".to_sym
       if shif = @attributes[long]
         # TODO delete this code, AFTER you understand it
         # tests do pass without it, maybe need more tests ?
         #if (shif.is_a?(Numeric))
        #   raise "should not be supported, check code #{inspect}"
      #     bin |= 0x1;
      #     shift = shif.register << 1
      #   end
         raise "0 < shift <= 32  #{shif} #{inspect}"  if (shif >= 32) or( shif < 0)
         op |=   shift(bin  , 4 )
         op |=   shift(shif , 4+3)
         break
       end
     end
     return op
   end

   # arm intrucioons are pretty sensible, and always 4 bytes (thumb not supported)
   def byte_length
     4
   end

  end
end
