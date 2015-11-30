[![Build Status](https://travis-ci.org/salama/salama-arm.svg?branch=master)](https://travis-ci.org/salama/salama-arm)
[![Gem Version](https://badge.fury.io/rb/salama-arm.svg)](http://badge.fury.io/rb/salama-arm)
[![Code Climate](https://codeclimate.com/github/salama/salama-arm/badges/gpa.svg)](https://codeclimate.com/github/salama/salama-arm)
[![Test Coverage](https://codeclimate.com/github/salama/salama-arm/badges/coverage.svg)](https://codeclimate.com/github/salama/salama-arm)


## Salama in Arm


Salama is about native code generation in and of ruby. Salama defines a Register OO machine.

To get running code, the Register machine code needs to be translated to machine specific binary.

This is the Arm, and as arm is salamas main target, it is the most complete and working version.

###  Assembly

Produce binary that represents code.
Traditionally called assembling, but there is no need for an external file representation.

Ie only in ruby code do i want to create machine code.

Most instructions are in fact assembling correctly. Meaning i have tests, and i can use objbump to verify the correct assembler code is disasembled

I even polished the dsl an so (from the tests), this is a valid hello world:

   hello = "Hello World\n"
   @program.main do
      mov r7, 4     # 4 == write
      mov r0 , 1    # stdout
      add r1 , pc , hello   # address of "hello World"
      mov r2 , hello.length
    	swi 0         #software interupt, ie kernel syscall
      mov r7, 1     # 1 == exit
    	swi 0
   end
   write(7 + hello.length/4 + 1 , 'hello')

### Vm implementation

The actual vm implementation is currently in flux. I tried to go from the ast to assembler, and that proved to big a step.

Hence the actual api is in flux. I just made the separate repository to remove some clutter. Especially in project searches.
