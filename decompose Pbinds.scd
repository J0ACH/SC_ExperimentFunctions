s.boot

(
f = {|pbind|
	var recScore;
	var stream = pbind.asStream;

	var time = 0;
	var finalTime;
	// routine.p.postln;
	var events = Order.new();

	var done = false;
	pbind.isKindOf(Event).if (
		{
			"je EVENT".postln;
			recScore = Score.new(pbind.asOSC);
			finalTime = recScore.score.last[0];
			recScore.add([ (finalTime + 0.1), [ 'c_set', 0, 0 ]]);
			finalTime = recScore.score.last[0];
		},
		{
			"je PBIND".postln;

			while( {done == false},
				{
					var event;
					// event = routine.next(Event.default);
					event = stream.next(Event.new);
					event.notNil.if(
						{
							time = time + event.at(\dur);
							// event.at(\instrument).postln;
							events.put(time, event);
						},
						{
							finalTime = time;
							done = true;
						}
					);

				}
			);

			recScore = pbind.asScore(finalTime);
			// recScore.score.addFirst([ 0, ["/d_load", "synthdefs/test.scsyndef" ] ]);
		}
	);

	"finalTime %".format(finalTime).postln;

	recScore.score.do({ |oneMsg| oneMsg.postcs;	});

	recScore.saveToFile("c:/fncScore.txt"); // zapise string OSCmsg z pbindu
	recScore.write("c:/fncScore.osc"); // zapise binary text pro NRT

	// s.sendNotifyRequest(true);

	Score.recordNRT(
		list:recScore.score,
		oscFilePath: "c:/fncScore.osc",
		outputFilePath:"c:/fncScore.flac",
		sampleRate:44100,
		headerFormat:"flac",
		sampleFormat:"ini16",
		options: ServerOptions.new.numOutputBusChannels_(2),
		duration: finalTime + 1.0,
		action: { "\nFLAC renderDone .....".postln; }
	); // synthesize



	/*
	events.indicesDo({|e, t|
	"[%] -> %".format(t, e).postln;

	// e.compile;
	});
	*/
	nil;

}

)
f.value( Pbind(\instrument, \NRTsine, \octave, Pstutter(Pseq([10,5]), Pseq([5,4])),  \sustain, 0.75, \degree, Pn(Pseries(1,1,5), 3), \dur, 0.25) );
f.value( Pbind(\instrument, \NRTsine, \dur, Pseq([0.35,0.15, Rest(0.5)], inf), \freq, Pseq([105,115,103,180], 4)) );
f.value( Pbind(\type, \set, \args, [\amp], \dur, 0.25, \amp, Pseq([0.2,0.5,0.9,0], 1)) );
f.value( (\amp: 0.5) )
f.value( Synth(\default) )

(
p = { |path, startTime|
	var score = Score.new(thisProcess.interpreter.executeFile(path));
	var preload;
	preload = [ 0, ["/d_load", "synthdefs/default.scsyndef" ] ];

	score = score.section(startTime, configevents: preload );
	// score = score.section(startTime);
	score.play;
	nil;
}
)
p.value("c:/fncScore.txt", 0.0)
p.value("c:/fncScore.txt", 2.0)

Score.options
Score.playFromFile("c:/fncScore.txt", s)

(\amp: 0.5).asOSC




SynthDescLib.global.read("synthdefs/default.scsyndef");
SynthDescLib.global.synthDescs.at(\test)
SynthDescLib.global.at(\NRTsine) // shortcut, same as line above



(
SynthDef("NRTsine",
	{ arg out=0, freq=440, amp=0.1, pan=0, gate=1;
		var z =	SinOsc.ar(freq, 0, 0.2) * Linen.kr(gate, 0.01, 0.7, 0.3, 2);
		OffsetOut.ar(out, Pan2.ar(z, pan, amp));
}).add;
)

SynthDescLib.global.at(\NRTsine).def.func.def.sourceCode
