(
var fncMakeTempo;
var clock;
var quant = 4;
var waitTime;
var routine;
var canvan, slider, slider2;

fncMakeTempo = {
	ProxySpace.push(Server.local).makeTempoClock;
	\tempo.envirGet.clock;
};

\tempo.envirGet.isNil.if(
	{
		"jsem".warn;
		clock = fncMakeTempo.value()
	},
	{
		clock = TempoBusClock.new(\tempo.envirGet,1);
		"jsem2".warn;
	}
);

canvan = Jui_Canvan(Rect(300,100,500,200)).background_(Color.black).front;
canvan.onClose_{ clock.stop; "stop".postln };

slider = Jui_Slider(canvan, Rect(20,100,460,25));
slider.domain_(0, quant, quant*16);
slider.density = 0.95;

slider2 = Jui_Slider(canvan, Rect(20,150,460,25));
slider2.domain_(0, quant*2, quant*16);
slider2.density = 0.95;

clock.postln;


waitTime = clock.timeToNextBeat(quant);
waitTime.postln;
clock.sched(waitTime,{
	"TICK".postln;
	slider.value.postln;
	(octave:6, dur:0.1).play;
	{
		slider.value = 0;
		slider.valueFade_(quant, quant);
	}.defer;
	quant;
});

waitTime = clock.timeToNextBeat(quant*2);
clock.sched(waitTime,{
	"TICK".postln;
	slider2.value.postln;
	(octave:4, dur:1.5, amp:0.5).play;
	{
		slider2.value = 0;
		slider2.valueFade_(quant*2, quant*2);
	}.defer;
	quant*2;
});
routine.postln;

)
currentEnvironment
currentEnvironment[\tempo].isPlaying
c = \tempo.envirGet.clock;
c = TempoBusClock.default.play
c.timeToNextBeat(2)