(
var win, view;
var controls = Dictionary.new();
var fncCloseWin, fncMouseEnter, fncMouseExit, fncDraw;

var frameAlpha = 0;


win = Window.new("test", Rect(100,100,700,600), border:false)
.alwaysOnTop_(true)
.front;

view = UserView(win, win.view.bounds)
.background_(Color.new255(30,30,30))
.drawFunc_{
	Pen.strokeColor = Color.new255(150,150,150);
	Pen.addRect(Rect(0,0, view.bounds.width, view.bounds.height));
	Pen.stroke;
};

controls.put(\closeImageButton,
	UserView(view, Rect((view.bounds.right - 35),(view.bounds.top + 10),25,25))
	.mouseDownAction_{ |view, x, y, modifiers, buttonNumber, clickCount| fncCloseWin.value; }
	.mouseEnterAction_{ |view, x, y| fncMouseEnter.value(view); }
	.mouseLeaveAction_{ |view, x, y| fncMouseExit.value(view); }
	.action_{|button| fncCloseWin.value; }
	.drawFunc_({|view| fncDraw.value(view); });
);

fncCloseWin = {
	"fncMouseEnter".postln;
	win.close;
};

fncMouseEnter = { |button|
	var time = 0.25;
	var frames = 30;
	"fncMouseEnter".postln;
	Routine.run({
		frames.do({|i|
			frameAlpha = (i+1)/frames * 255;
			{button.refresh;}.defer;
			(time/frames).wait;
		});
	}).play
};

fncMouseExit = { |button|
	var time = 0.25;
	var frames = 30;
	"fncMouseExit".postln;
	Routine.run({
		frames.do({|i|
			frameAlpha = (frames -(i+1))/frames * 255;
			{button.refresh;}.defer;
			(time/frames).wait;
		});

	}).play
};

fncDraw = { |view|
	// "fncDraw".postln;
	var img = Image.new("C:/GitHub/SC_ExperimentFunctions/IconExit.png");
	view.backgroundImage_(img);
	Pen.width = 1;
	Pen.strokeColor = Color.new255(20,180,240, frameAlpha);
	Pen.addRect(Rect(0,0, view.bounds.width, view.bounds.height));
	Pen.stroke;
};

)

Window.screenBounds


