p = ProxySpace.push(s);

(
s = Server.local;
// b = Buffer.alloc(s, 44100 * 4.0, 1); // a four second 1 channel Buffer
b = Buffer.alloc(s, (44100/s.options.blockSize) * 4.0, 1); // a four second 1 channel Buffer
// b = Buffer.alloc(s, s.options.blockSize * 4.0, 1); // a four second 1 channel Buffer
)

(
f = {

	var buff = b;
	// var env = EnvGen.kr(Env([0,1,0], [0.25, 3.75], [5,-5]), doneAction:2);
	var env = EnvGen.kr(Env([0,1,0], [2.85, 1.15], [5,-5]), doneAction:2);
	var rec = RecordBuf.kr(env, buff, loop: 0, doneAction: 2);
	"numBuf %".format(buff.bufnum).postln;
	"numCh %".format(buff.numChannels).postln;
	"numFrames %".format(buff.numFrames).postln;
	"sampleRate %".format(buff.sampleRate).postln;
	// rec.postln;
	// b.get(0, {|msg| msg.postln});
	// buffer.postln;
	// Out.kr(out, rec);
	// 0.0;
}.play(s, 0, args:[\buffNum, b])
)
b.plot;
// f.play(s, 0, args:[\buffNum, b])

(
f = { |env|
	var bundles;
	var bufNum;
	bundles = s.bind {
		var duration = env.duration;
		var buffer = Buffer.alloc(s, (44100/s.options.blockSize) * duration, 1);
		SynthDef("recEnv", {
			var envgen = EnvGen.kr(env, doneAction:2);
			var rec = RecordBuf.kr(envgen, buffer, loop: 0, doneAction: 2);
		}).send(s);
		"\nBuffer[%] - dur % ".format(buffer.bufnum, duration).postln;
		s.sync; // wait until synthdef is loaded
		x = Synth.new("recEnv");
		nil;
	};

	bundles.do{|oneMsg| "\t%".format(oneMsg).postln};
	nil;
};
)
f.value(Env([0,1,0], [0.25, 3.75], [5,-5]))
f.value(Env([0,1,0], [2.85, 1.15], [5,-5]))


(
g = {|index|
	// arg out = 0;
	var buff = b;
	var playbuf = PlayBuf.kr(1,3, loop:0, doneAction:2);
	// var playbuf = PlayBuf.kr(1,1, loop:0, doneAction:2);
	index.postln;
	Out.ar(0, SinOsc.ar(120!2) * playbuf);
}.play(s, 0, [\index, 0, \freq, 150])

)
// Pbind(\type, \set, \args, [\bufTrig], \bufTrig, 1, \dur, Pseq([4,4,4,4], 1)).play;



~test = NodeProxy.audio(s, 2);
~test.play;
(
~test[0] = {
	var buffers = [
		PlayBuf.kr(numChannels:1, bufnum:0, loop:1, doneAction:0),
		PlayBuf.kr(numChannels:1, bufnum:1, loop:1, doneAction:0)
	];

	SelectX.kr(SinOsc.ar(120!2, mul:buffers),\selIndex.kr(0))

};
)
~test[1] = Pbind(\type, \set, \args, [\selIndex], \selIndex, Pseq([0,1], inf), \dur, 4).trace;