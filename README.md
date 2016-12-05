# Pipeline_RISC_Microprocessor
Take a look at the pdf document to know the problem statement for the project.
Many things are NOT designed in the standard manner. For example the zero and carry flags are set before the writeback stage itself (in execute itself). Also the register file doesn't contain R7. 
All the instructions as asked in the PS are executed properly though. Adding interrupts etc might require a design overhaul due to non-standard implementation.
Also there is scope for optimization like
i. When PC branches to PC+1 or PC+2 say, currently all the instructions after the branch instruction are flushed to accomodate the change. But in these special cases, not all need to be flushed.
ii. The extra cycle required for LM and SM instructions can be removed. However it will lead to dependency issues akin to that in Load instruction and will have to be dealt with.
