(
var routine;
w = Window("", Window.availableBounds, false, false);
w.front;
w.background = Color.clear;

u = UserView(w);

routine = Routine.new({
	1000.do({
		u.bounds_(Rect(QtGUI.cursorPosition.x,200,600,600));
		(1/24).wait;
	});
}).play(AppClock);

u.background_(Color.new255(120,60,30));

w.onClose = { routine.stop };
)