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
~aa[0] = {|freq = 120, amp = 0.0| SinOsc.ar(freq!2, mul:amp)};
)
w = nil
t.clear
f.value(4, Env([0,0.8,0.1,0.7,0.0], [0.35,0.25,0.05, 2.5], \sin));
(
f = {|quant, env|
	var proxy = ~aa;
	var time2quant = TempoClock.default.timeToNextBeat(quant);
	// var node = NodeProxy.new(s, \control, 1);
	// var node = NodeProxy.control(s, 1);
	var node = NodeProxy.for(c);
	var update = true;
	node.group = proxy.group;
	node.fadeTime = 16;
	// node.reshaping = \elastic;
	c = node.bus;
	c.postln;
	proxy.bus.postln;
	// ~aa.group
	// node.clock = TempoClock.default;
	// node.clock = p.clock;

	node.source = { EnvGen.kr(env, doneAction:2) };
	// node.nameDef("zzz",0);
	t.clear;
	// w.isNil.if({ update = false; });
	"time2quant [%]".format(time2quant).postln;

	t = TempoClock.default.sched(time2quant, {
		"\ntick quant [%]".format(quant).postln;
		node.send;

		// node.nameDef.postln;

		"\t-cBusIndex [%]".format(node.index).postln;
		"\t-cBusChannels [%]".format(node.numChannels).postln;
		"\t-nodeID [%]".format(node.nodeID).postln;
		"\t-envDuration [%]".format(env.duration).postln;
		{
			// w = Window.new(
			node.scope;
			update.if(
				// { w.refresh; },
				// { w = env.plot(); },
			);
			// w.postln;
		}.defer();

		~aa.xset(\amp, node);

		quant;
	});

	nil;
	// b.postln;
	// b;
};


)

