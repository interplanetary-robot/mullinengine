// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vmullin_8row_c_wrapper__Syms.h"
#include "Vmullin_8row_c_wrapper.h"

// FUNCTIONS
Vmullin_8row_c_wrapper__Syms::Vmullin_8row_c_wrapper__Syms(Vmullin_8row_c_wrapper* topp, const char* namep)
	// Setup locals
	: __Vm_namep(namep)
	, __Vm_activity(false)
	, __Vm_didInit(false)
	// Setup submodule names
{
    // Pointer to top level
    TOPp = topp;
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOPp->__Vconfigure(this, true);
    // Setup scope names
}
