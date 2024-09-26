#define HL_NAME(n) mylib_##n // THIS MUST COME BEFORE INCLUDING <hl.h>, IT USES THE NAMING SCHEME WHEN GENERATING EXPORTS WITH DEFINE_PRIM

#include <hl.h>  // HashLink API


// A simple function to be exposed to adds two numbers, returns the result
HL_PRIM int HL_NAME(add)(int a, int b)
{
    printf("In mylib:add(%d, %d)!\n", a, b);
    return a + b;
}

// A simple function to be exposed to HashLink, prints "Hello"
HL_PRIM void HL_NAME(say_hello)() 
{
    printf("Hello from HashLink C library!\n");
}

// simple function that takes a callback as an argument, and ivokes it (showing calling back to haxe from C)
HL_PRIM void HL_NAME(call_me_back)(vclosure *callback)
{
    printf("In mylib:call_me_back(), invoking provided callback..\n");
    hl_dyn_call(callback, NULL, 0);
}

//
// FOR HDLL's, THE FUNCTION NAMES HAVE TO BE EXPORTED WITH THE LIBRARY NAME PREFIX.  ALSO NOTE THE LOWER SNAKE CASE 
//
// When defining functions, they must declared with prefixed via the HL_NAME macro (mylib_add, mylib_hello, mylib_my_c_function)
// DEFINE_PRIM expects the non-prefixed name!
//
DEFINE_PRIM(_VOID, say_hello, _NO_ARG); // void return value, function to call, no arguments
DEFINE_PRIM(_I32, add, _I32 _I32); // int return value, function to call, two in args
DEFINE_PRIM(_VOID, call_me_back, _FUN(_VOID, _NO_ARG)); // void return value, function to call, a function callback that takes no arguments and returns no arguments 


// mylib.c