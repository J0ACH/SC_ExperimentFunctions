p = ProxySpace.push(s).makeTempoClock

(
~aa = NodeProxy.audio(s, 2);
~aa.play;
~aa[0] = {|freq = 220, amp = 0.2| SinOsc.ar(freq!2, mul:amp)};
)

~aa.controlKeysValues
~aa.controlNames
~aa.controlKeys

~aa.bus
~aa.busArg
~aa.nodeMap

~aa.nameDef
~aa.nameDef.func.def.sourceCode
~aa.nameDef.controlNames
~aa.nameDef.controls
~aa.nameDef.allControlNames

~aa.nameDef.controlIndex
~aa.nameDef.constantSet
~aa.nameDef.children
~aa.nameDef.controls.do({|aaa| aaa.postln});
(
f = {|fnc|
	var busNum;
	b = Bus.control(s, 1);
	// b = Bus.new(\control, busNum, 1, s);
	// b = Bus.alloc(\control, s, 1);
	busNum = b.index;
	fnc.play(outbus:busNum);
	b.value_(fnc);

	"busIndex [%]".format(b.index).postln;
	"busChannels [%]".format(b.numChannels).postln;

	b.scope;

	~aa.set(\amp, NodeProxy.control(s, 1).source_(b));
	// ~aa.nodeMap.postln;
	// ~aa.map(\amp, b.value);

	nil;
	// b.postln;
	// b;
};


)
f.value({Saw.kr(2, mul:0.4 , add:0.2)});
f.value({SinOsc.kr(1/2, mul:0.25, add:0.35 )});
f.value({EnvGen.kr(Env([0,0.8,0.2,1,0], [0.35,0.25,0.05, 2.5], \sin), doneAction:2)});

(
t = TempoClock.default.sched(0, {
	"tick".postln;
	f.value({EnvGen.kr(Env([0,1,0], [0.5, 2.5], \sin), doneAction:2)});
	4;
})
)
t.clear;