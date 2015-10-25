s.reboot;
p = ProxySpace.push(s).makeTempoClock;
p.clock.tempo = 1;
p.clock.tempo

~sin = NodeProxy.audio(s,2);
~sin.play(vol:1, fadeTime: 2);
~sin.fadeTime = 1;
~sin[0] = {|amp = 0.4, freq = 80| SinOsc.ar(freq!2, mul:amp)};

~sin.xset(\amp, QuantNode(30, 1, [0,1,0], [1.75,0.25], fadeTime:0))
~sin.xset(\amp, QuantNode(30, 1, [0,1,0], [0.15,3.25], fadeTime:0))

QuantNode(30, 1, 1, inf, [0,1,0], [1.15,0.45])
s.scope(30)
~sin.scope
~sin.stop;
(
f = {|proxy, key, source|
	var pnm = ProxyNodeMap.new;
	var node = NodeProxy.new(s, \control, 1);
	node.group = proxy.group;
	node.source = source;
	"\n/////////////////////////////////\n".postln;
	pnm = proxy.nodeMap;
	// pnm.put(key, node.source.def.sourceCode);
	pnm.put(key, node);

	thisFunctionDef.context.postln;

	// pnm.asCode.postln;
	pnm.controlNames.do({|cntName, bus|
		var source = cntName.defaultValue;
		"cntName: %".format(cntName).postln;
		"\t - name : %".format(cntName.name).postln;
		"\t - index : %".format(cntName.index).postln;
		"\t - defaultValue : %".format(cntName.defaultValue).postln;
		source.isKindOf(NodeProxy).if ({
			"\t\t - nodeBus : %".format(source.bus).postln;
			"\t\t - node isPlaying : %".format(source.isPlaying).postln;
			"\t\t - busPlug busArg : %".format(source.busArg).postln;
			"\t\t - node group : %".format(source.group ).postln;

		});
		"\t - rate : %".format(cntName.rate).postln;
		"\t - numChannels : %".format(cntName.numChannels).postln;
		// var cnt = ControlName(

		// args.postln;

		"nodeBus?: %".format(bus).postln;


	});

	// pnm.at(key).postln;
	// pnm.settingKeys.postln;
	// pnm.mappingKeys.postln;
	// pnm.parents.postln;

	pnm.asCode("~sin", true).interpret;
	pnm.asCode("~sin", true).postln;

	// proxy.addNodeMapControlNames(key,
	// proxy.nodeMap = pnm;
	// pnm
	nil
}
)
f.value(~sin, \amp, 0.1)
f.value(~sin, \amp, { SinOsc.kr(1) })
f.value(~sin, \amp, ~test)
~test = NodeProxy.control(s, 1).source_({ SinOsc.kr(1/4) });

f.value(~sin, \amp, NodeProxy.control(s, 1).source_({ SinOsc.kr(1) }))

NodeProxy.control(s, 1).source_({ SinOsc.kr(1) }).asCode(true, false, currentEnvironment);


(
var t = NodeProxy.control(s, 1).source_({ SinOsc.kr(1) });
)
NodeProxy.control(s, 1).source_({ SinOsc.kr(1) }).postln


~sin.map(\amp, 0.2)
~sin.nodeMap_(f.value(~sin, \amp, 0.0));


(
~sin.xset(\amp,
	NodeProxy
	.control(s, 2)
	.quant_(4)
	.group_(currentEnvironment[\sin].group)

	.source_({
		// var Detec
		Pbind.free;
		EnvGen.free;
		Pbind(\type, \set, \args, [\trigEnv], \trigEnv, 1, \dur, 4).play(currentEnvironment.clock,quant:4);
		EnvGen.kr(Env([0,1,0],[0.05,1.95]), \trigEnv.tr, timeScale: 1.05, doneAction:0) //, timeScale: 1/currentEnvironment.clock.tempo )
}))
)
m.proxy = p;
m.parent = p
m.controlNames
p.proxyControlClass.synthDef

~sin[1] = \control ->
~sin.controls
~sin.xsetn(\freq, [60,167])
~sin.xmap(\freq, NodeProxy.control(s, 2).source_({ SinOsc.kr(1, mul:2, add:80) }))
(
~sin.xset(\amp, NodeProxy.control(s, 2).source_({
	DemandEnvGen.kr(
		Dseq([0,1,0.0], inf),
		Dseq([0.05, 0.45], inf),
		1, [-5,5], 1, 1,
		doneAction:0
	)
}))
)

(
~sin.xset(\amp, NodeProxy.control(s, 2).source_({
	QuantNode(1, [0,1,0], [0.1,0.4])
}))
)

(
~sin.xset(\amp, NodeProxy.control(s, 2).quant_(4).source_({
	EnvGen.kr(Env([0,1,0],[0.25,6.75]), Impulse.kr(1/4*p.clock.tempo), timeScale: 1/p.clock.tempo )
}))
)

s.controlBusAllocator

currentEnvironment[\sin].group

~sin.findInOpenDocuments(0)
~sin.asCode
~sin.asGroup
~sin.asNodeID
~sin.asTarget
~sin.defaultGroupID
~sin.getDefaultVal(\amp)
~sin.getStructure
~sin.key
~sin.objects[0]
~sin.supplementNodeMap

~sin.nodeMap
~sin.nodeMap[\amp].scope
~sin.krNames

~sin.stop(4)
~sin.clear;

~sin[0].numArgs
~sin[0].numVars
~sin[0].valueEnvir.postString

~a = NodeProxy.control(s, 1)
~a[0]= {(SinOsc.kr(1, mul:200, add:600))}
.bus


f = QuantNode(30, 1, 0, inf, [0,1,0], [0.1,0.4]);
f.scope
~a = QuantNode(1, [0,1,0], [0.1,0.4])
~a.play
~a.scope


s.reboot
p = ProxySpace.push(s).makeTempoClock;

a = NodeProxy(s); a.play;
a.source = { Splay.ar(Blip.ar(\freq.kr(18 ! 4))) * 0.2 };
a.set(\freq, [1, 3, 56, 13]);
a.source = { Splay.ar(SinOsc.ar(LFSaw.ar(\freq.kr(18 ! 4)) * 250 + 400)) * 0.2 };
b = NodeProxy(s); b.source = { MouseX.kr(0, 3) *  [1, 3, 56, 13] };
a.set(\freq, b);
a.clear; b.clear;