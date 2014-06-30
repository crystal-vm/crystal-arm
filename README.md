## Crystal in Arm


Crystal is about native code generation in and of ruby. Crystal defines a virtual OO machine.

To get running code, the virtual machine code needs to be translated to machine specific binary.

This is the Arm, and as arm is crystals main target, it is the most complete and working version.

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

Hence the actual api is in flux. I just made the seperate repository to remove some clutter. Especially in project searches.