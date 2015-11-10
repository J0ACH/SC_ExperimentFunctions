(
s = Server.local;
// b = Buffer.alloc(s, 44100 * 4.0, 1); // a four second 1 channel Buffer
b = Buffer.alloc(s, (44100/s.options.blockSize) * 4.0, 1); // a four second 1 channel Buffer
// b = Buffer.alloc(s, s.options.blockSize * 4.0, 1); // a four second 1 channel Buffer
)

(
f = {|buffer|
	// arg out = 0;
	var buff = b;

	var env = EnvGen.kr(Env([0,1,0], [0.15,3.85], [5,-5]), doneAction:2);
	var rec = RecordBuf.kr(env, buff, loop: 0, doneAction: 2);
	"numBuf %".format(buff.bufnum).postln;
	"numCh %".format(buff.numChannels).postln;
	"numFrames %".format(buff.numFrames).postln;
	b.plot;
	buffer.postln;
	// Out.kr(out, rec);
	// 0.0;
}
)
f.play(s, 0, args:[\buffNum, b])

(
g = {
	arg out = 0;
	var buff = b;
	var playbuf;
	buff.postln;
	// playbuf = PlayBuf.kr(1,buff,trigger:\bufTrig.tr, doneAction:2);
	playbuf = PlayBuf.kr(1,buff, loop:0, doneAction:2);
	Out.ar(out, SinOsc.ar(120!2) * playbuf);
}.play

)
// Pbind(\type, \set, \args, [\bufTrig], \bufTrig, 1, \dur, Pseq([4,4,4,4], 1)).play;

s.bufferAllocator
