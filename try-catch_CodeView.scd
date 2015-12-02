(
~safeTry = {|string|
	var function;

	// ~validCode = function;
	try {
		function = string.compile;
		~validDef = function.def;
		"ok".warn;
	}
	{ |error|
		// error.what.postln;
		// error.reportError;
		// error.errorString.die;
		// error.errorString.postln;
		'jsem tu'.postln; // neni spravny syntax
	};


	("\nValidCode:" + ~validDef.sourceCode).postln;
	("Class" + ~validDef.selectors).postln;
	("Constats" + ~validDef.constants).postln;
	("VarNames" + ~validDef.varNames).postln;
	"done";
}
)

~safeTry.value("")
~safeTry.value("SinOsc.ar(\\freq.kr(120), mul: 0.2)")
~safeTry.value("SinOsc.ar(\\freq.kr (120), mul: 0.2)a")



Exception.inProtectedFunction_(false)

postInlineWarnings