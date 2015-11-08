
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
// history = History.loadCS("C:/Users/Jachym/AppData/Local/SuperCollider/HistoryPlayer/HistoryFiles/pokus2.scd");
lines = history.lines.reverse;

// lines.printAll;

oscMsg = { |time, code|
	var oscMsg;
	var type;
	var val;
	var fnc = this.compile(code.asCompileString);
	// time.postln;
	// fnc.def.sourceCode.postln;
	// "FNC : %".format(fnc.def.sourceCode).postln;
	val = this.interpret(code);
	// "VALUE : %".format(val).postln;
	// event = fnv.asOSCArgBundle
	// "OSC : %".format(fnc).postln;

	type = case
	{ val.isKindOf(NodeProxy) } {"NODE : %".format("aaa").postln; }

	{ val.isKindOf(Event) }
	{
		"EVENT".postln;
		oscMsg = val.asOSC;
		oscMsg.do({|oneMsg|
			oneMsg[0] = oneMsg[0] + time;
			"\t%".format(oneMsg).postln;

		});
	}
	{ val.isKindOf(Pbind) } {"Pbind : %".format("p").postln; }

	{ val.isKindOf(EventStreamPlayer) }
	{
		"EventStreamPlayer : %".format("p").postln;

	}

	{ val.isKindOf(Object) } {"ELSE : %".format(val).postln; };

	/*
	val.isKindOf(Event).if({
	oscMsg = val.asOSC;
	// oscMsg[0][0].postln;
	oscMsg.do({|oneMsg|  oneMsg[0] = oneMsg[0] + time; "EVENT : %".format(oneMsg).postln; });
	// "EVENT : %".format(oscMsg).postln;

	});
	*/
	val.isKindOf(EventStreamPlayer).if({
		var event = val.routine.storeArgs;
		var routine = val.routine;
		var startTime = time;
		var finalTime;

		// event[0].def.code.postln;
		event = routine.next(Event.default);

		event.do({|oneE|
			var event;
			// event = routine.next;
			// routine.yield;
			oneE.postln;
		});

		// val.do({|aa, bb| aa.postln; bb.postln});
		// routine.value("hello routine");

		/*
		var done = false;
		while( {done == false},
		{
		var event;
		event = routine.next(Event.default);
		// event = stream.next(Event.new);
		event.notNil.if(
		{
		time = time + event.at(\dur);
		// event.at(\instrument).postln;
		// events.put(time, event);
		},
		{
		finalTime = time;
		done = true;
		}
		);

		}
		);
		*/
		// oscMsg = pbind.asScore(finalTime);

		"PBIND : %".format(routine).postln;
	});
	// msg = s.makeBundle(time.asFloat, { fnc });
	oscMsg = s.makeBundle(0, this.compile(code););
	// oscMsg = s.makeBundle(0, oscMsg;);
	// oscMsg = s.bind( this.compile(code) );
	// msg = s.makeBundle(time, fnc);

	oscMsg.do({|oneM| oneM.postln; });

	nil;
	// msg;
};

"\n//////////////////////////////////////".postln;
lines.do({|oneLine|
	var time = oneLine[0];
	var code = oneLine[2];

	"\n[%] %".format(time.round(0.01), code.asString).postln;
	oscMsg.value(time, code);
});

// s.freeAll;
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
History.lines

Server.local.status

a = {(\amp:0.5)}
a = {(\amp:0.5)}.transformEvent(Event.new)
a = {Pbind(\octave, Pstutter(Pseq([10,5]), Pseq([5,4])),  \sustain, 0.75, \degree, Pn(Pseries(1,1,5), 3), \dur, 0.25)}
a = {Pbind(\octave, Pstutter(Pseq([10,5]), Pseq([5,4])),  \sustain, 0.75, \degree, Pn(Pseries(1,1,5), 3), \dur, 0.25)}.transformEvent(Event.new)
a.postln
