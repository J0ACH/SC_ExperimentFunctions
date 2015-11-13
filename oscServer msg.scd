// post all incoming traffic except the server status messages
// basically the same as OSCFunc.trace

t.stop;
s.dumpOSC(0)
(
l = List.newClear();
t = SystemClock.beats;

f = { |msg, time, replyAddr, recvPort|
	    if(msg[0] != '/status.reply')
	{
		        "At time %s received message % from % on port%\n".postf( (time-t), msg, replyAddr, recvPort );
		l.add([time - t, msg]);
		Synth.help

	    }
};
);
thisProcess.addOSCRecvFunc(f);
thisProcess.removeOSCRecvFunc(f);

// stop posting.
SystemClock.beats

t.beats

x = Synth("default");
x.release(2);


a = s.bind({Pbind(\instrument, \default, \dur, 0.5, \degree, Pseq([3,4,5,6], 2))})
a.postln
Pbind(\instrument, \default, \dur, 0.5, \degree, Pseq([3,4,5,6], 2)).play
l.do({|oneMsg| oneMsg.postln})

Score.play(l)

(
var recScore = Score.new(l);
var finalTime = recScore.score.last[0];
finalTime.postln;

recScore.saveToFile("c:/fncScore2.txt"); // zapise string OSCmsg z pbindu
recScore.write("c:/fncScore2.osc"); // zapise binary text pro NRT

Score.recordNRT(
	list:recScore.score,
	oscFilePath: "c:/fncScore2.osc",
	outputFilePath:"c:/fncScore2.flac",
	sampleRate:44100,
	headerFormat:"flac",
	sampleFormat:"ini16",
	options: ServerOptions.new.numOutputBusChannels_(2),
	duration: finalTime + 1.0,
	action: { "\nFLAC renderDone .....".postln; }
); // synthesize
)

NodeWatcher.all
a = AbstractNodeWatcher(s)
a.start
a.server
a.cmds

this.cmdLine