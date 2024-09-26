// Main.hx
// Option 1: Load the hdll and wrap it as an extern class:
// Notes:
// 1:  the location of @:hlNative is above the class.  All members are expected to be in the hdll
// 2: You can optionally define it as 'extern' so you don't need placeholder function bodies like '{}'.

@:hlNative("mylib")
extern class Example1 {
	// if your class isn't defined as extern, you'll need some placeholder function bodies:
	// public static function my_c_function():Void {};
	public static function say_hello():Void; // class was defined extern, no body required
}

// Option 2: The actual functions point to the hdll functions, not the class
// 1: Regular class!
// 2: the location of @:hlNative is above the individual functions.  Only those members are expected to be in the hdll
// 3: The @hlNative includes the lib name and the function (vs just the lib name for example #1)
// 4: As such, hlNative can swap whatever you call your function and maps (subsitutes?) the function in the hdll
// 5: The functions can't be extern (or if so, I didn't get it to work), so a placeholder body is required.
class Example2 {
	@:hlNative("mylib", "add")
	// public static function add(a:Int, b:Int):Int { return 0;}; // Body required!
	// public static function add(a, b) {return 0;} // hmm.. this works.  Arguments being cast to Dynamic?
	public static function sum(a, b) { // Note that we can call this 'sum' instead of the lib's 'add'.  Macro magic!
		trace("YOU SHOULDN'T SEE THIS!");
		return 0;
	}

	// Since this is a regular class, it can be instantiated like normal
	public function new() {
		trace("Example2 instance");
	}

	public function plus(a:Int, b:Int):Int {
		// the hdll function is static
		return Example2.sum(a, b);
	}
}

typedef MyCallbackType = Void->Void;

extern class Example3 {
	@:hlNative("mylib", "call_me_back")
	public static function call_me_back(callback:MyCallbackType):Void;
}

class Main {
	static function main() {
		// Call the C function (static)
		Example1.say_hello();

		// Replaced clib name
		trace(Example2.sum(4, 5));

		// instance wrapping call
		var e2 = new Example2();
		e2.plus(9, 10);

		// callbacks
		Example3.call_me_back(() -> {
			trace("You like me, you really, really like me!");
		});
	}
}
