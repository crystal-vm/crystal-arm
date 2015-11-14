require_relative 'arm-helper'

class TestMoves < MiniTest::Test
  include ArmHelper

  def test_mov
    code = @machine.mov  :r1,  5
    assert_code code , :mov , [0x05,0x10,0xa0,0xe3] #e3 a0 10 05
  end
  def test_mov_pc
    code = @machine.mov  :pc,  5
    assert_code code , :mov , [0x05,0xf0,0xa0,0xe3] #e3 a0 f0 06
  end
  def test_mov_max_128
    code = @machine.mov  :r1,  128
    assert_code code , :mov , [0x80,0x10,0xa0,0xe3] #e3 a0 10 80
  end
  def test_mov_256
    code = @machine.mov  :r1,  256
    assert_code code , :mov , [0x01,0x1c,0xa0,0xe3] #e3 a0 1c 01
  end
  def test_mov_big
    code = @machine.mov  :r0,  0x222  # is not 8 bit and can't be rotated by the arm system in one instruction
    code.set_position(0)
    begin  # mov 512(0x200) = e3 a0 0c 02    add 34(0x22) = e2 80 00 22
      assert_code code , :mov , [ 0x02,0x0c,0xa0,0xe3 , 0x22,0x00,0x80,0xe2]
    rescue Register::LinkException
      retry
    end
  end
  def test_mvn
    code = @machine.mvn  :r1,  5
    assert_code code , :mvn , [0x05,0x10,0xe0,0xe3] #e3 e0 10 05
  end

  def test_shiftr1
    code = @machine.mov  :r1,  :r2 , :shift_asr => Register::RegisterValue.new(:r3 , :Integer)
    assert_code code , :mov , [0x52,0x13,0xa0,0xe1] #e1 a0 13 52
  end
  def test_shiftr2
    code = @machine.mov  :r2,  :r3 , :shift_asr => Register::RegisterValue.new(:r4 , :Integer)
    assert_code code , :mov , [0x53,0x24,0xa0,0xe1] #e1 a0 24 53
  end
  def test_shiftr3
    code = @machine.mov  :r3,  :r4 , :shift_asr => Register::RegisterValue.new(:r5 , :Integer)
    assert_code code , :mov , [0x54,0x35,0xa0,0xe1] #e1 a0 35 54
  end

  def test_shiftl1
    code = @machine.mov  :r1,  :r2 , :shift_lsr => Register::RegisterValue.new(:r3 , :Integer)
    assert_code code , :mov , [0x32,0x13,0xa0,0xe1] #e1 a0 13 32
  end
  def test_shiftl2
    code = @machine.mov  :r2,  :r3 , :shift_lsr => Register::RegisterValue.new(:r4 , :Integer)
    assert_code code , :mov , [0x33,0x24,0xa0,0xe1] #e1 a0 24 33
  end
  def test_shiftl3
    code = @machine.mov  :r3,  :r4 , :shift_lsr => Register::RegisterValue.new(:r5 , :Integer)
    assert_code code , :mov , [0x34,0x35,0xa0,0xe1] #e1 a0 35 34
  end

end
