
p = ProxySpace.push(s)

(
f = {|code|

	var fnc = this.compile(code);
	fnc.isKindOf(Pbind).postln;
	"\n//////////////////////".postln;
	fnc.def.sourceCode.postln;

	m = s.makeBundle(0,  fnc );

	m.do({|oneM| oneM.postln; });
	nil;
};
)
f.value("x = Synth.new('default')")
f.value("x.release(2);")

f.value("p = ProxySpace.push(s)")
f.value("~a = NodeProxy.audio(s,2); ~a.play; ~a[0] = {Dust.ar([1,1] * 30 ) * 0.3 }; ")
f.value("~a.stop(4);")
f.value("~a.rebuild;")

f.value("Pbind('dur', 0.25, 'octave', 3, 'degree', Pseq([3,4,3,7], 2))")

s.dumpOSC(1)


this.interpret("x=Synth.new('default')")
this.interpret("().play")
this.interpret("x.release(2);")
(
this.interpret("p = Pbind('dur', 0.25, 'octave', 3, 'degree', Pseq([3,4,3,7], 2)).play");
this.cmdLine.postln
)

f = this.compile("~a = NodeProxy.audio(s,2); ~a[0] = {Dust.ar([1,1] * 30 ) * 0.3 }; ~a.play;")
f = this.compile("x=Synth.new('default')")
f = this.compile("Pbind('dur', 0.25, 'octave', 3, 'degree', Pseq([3,4,3,7], 2)).play")
f.def.sourceCode.postln
this.functionCompileContext("x=Synth.new('default')")
"{x.release(2);}".compile

(
z = this.compile("(123 + 4000).postln");
z.postln;
z.value;
)



(
var oscMsg;
var history, lines;
// s.freeAll;
// p = ProxySpace.push(s);

history = History.loadCS("C:/Users/Jachym/AppData/Local/SuperCollider/HistoryPlayer/HistoryFiles/test.scd");
lines = history.lines.reverse;

// lines.printAll;

oscMsg = { |time, code|
	var msg;
	var fnc = this.compile(code.asCompileString);
	// time.postln;
	// fnc.def.sourceCode.postln;

	// msg = s.makeBundle(time.asFloat, { fnc });
	msg = s.makeBundle(0, this.compile(code););
	// msg = s.makeBundle(time, fnc);

	msg.do({|oneM| oneM.postln; });

	nil;
	// msg;
};

lines.do({|oneLine|
	var time = oneLine[0];
	var code = oneLine[2];

	"\n[%] %".format(time.round(0.01), code.asString).postln;
	oscMsg.value(time, code);
})


)

oscMsg.value( "p = ProxySpace.push(s);" );
oscMsg.value( "~a = NodeProxy.audio(s, 2);");
oscMsg.value( "~a[0] = { SinOsc.ar('freq'.kr(120)!2) };");
oscMsg.value( "~a.play");

// oscMsg.value( "x = Synth.new(\\default);");
// oscMsg.value( "x.set('freq', 200);");
// oscMsg.value( "Synth.new(\\default);");

History.loadCS("C:/Users/Jachym/AppData/Local/SuperCollider/HistoryPlayer/HistoryFiles/pokus2.scd")
History.play



