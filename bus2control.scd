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

p = ProxySpace.push(s).makeTempoClock
p.clock.tempo_(1)

(
~aa = NodeProxy.audio(s, 2);
~aa.play;
~aa[0] = {|freq = 120, amp = 0.2| SinOsc.ar(freq!2, mul:amp)};
)
w = nil
t.clear
f.value(~aa, \amp, 4, Env([0,0.8,0.1,0.4,0.0], [0.35,0.25,0.05, 6.5], \sin));
f.value(~aa, \amp, 4, Env([0.2,0.8,0.0,0.2], [0.35, 0.5, 1.5], \sin));
f.value(~aa, \freq, 2, Env([120,1800,120], [0.35, 1.5], \sin));
(
f = {|proxy, key, quant, env|

	var synthDef, synth;
	var time2quant = TempoClock.default.timeToNextBeat(quant);
	// var node = NodeProxy.new(s, \control, 1);
	// var node = NodeProxy.control(s, 1);
	var node = NodeProxy.for(c);

	node.group = proxy.group;
	// node.fadeTime = 16;
	c = node.bus;
	c.postln;
	proxy.bus.postln;

	node.source = { EnvGen.kr(env, doneAction:2) };
	synthDef = node.nameDef("quantFnc [ % ]".format(key.asSymbol), 0);


	t.clear;
	"time2quant [%]".format(time2quant).postln;

	// t = TempoClock.default.sched(time2quant, {
		TempoClock.default.sched(time2quant, {

		"\ntick quant [%]".format(quant).postln;
		// node.send;

		// synth = synthDef.play(node.nodeID, addAction:\addToTail);
		// synth.group = node.group;
		node.source = synthDef;
		// "objects[index].synthDef.func: %".format(node.objects[0].synthDef.func).postln;
		"\t-cBusIndex [%]".format(node.index).postln;
		"\t-nodeNameDef [%]".format(synthDef.name).postln;
		"\t-cBusChannels [%]".format(node.numChannels).postln;
		"\t-nodeID [%]".format(node.nodeID).postln;
		"\t-envDuration [%]".format(env.duration).postln;
		{
			node.scope;
			// synth.scope;
			// { w = env.plot(); },

		}.defer();

		~aa.set(key.asSymbol, node);
		// s.queryAllNodes(true);
		quant;
	});

	nil;
};


)

