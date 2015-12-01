(
f = {|string|
	var function;
	var def;


	try {

		// protect {
		function = string.compile;
		// work with the file here, which might cause an error
		def = function.def;

		function.isFunction.postln;

		def.sourceCode.postln;
		("Class" + def.selectors).postln;
		("Constats" + def.constants).postln;
		// } {
		// file.close;
		// "chyba".warn;
		// };


	}
	// {|error| \caught.postln; error.dump; };

	{ |error|
		("typErroru:" + error.species.name).postln;

		switch(error.species.name)
		{ 'Error' } {"jsem tu Error".postln;}
		{ 'DoesNotUnderstandError'} {"jsem tu".postln;}
		// default condition: unhandled exception, rethrow
		// { error.throw }
		{ "unknown exception".postln; error.dump; /*error.throw;*/ }

	};




}
)

f.value("SinOsc.ar(\\freq.kr(120), mul: 0.2)")
f.value("aSinOsc.ar(\\freq.kr(120), mul: 0.2)")