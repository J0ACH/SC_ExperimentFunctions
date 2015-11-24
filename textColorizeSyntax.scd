(
var string, symbol;
var cntSymols = List.newClear();

w = Window.new(bounds:Rect(100,100,600,300));
w.front;

f = {
	var ksc = SinOsc.ar(( \freq.kr(60) + \fplus.kr(0) ), mul: 1, add: 0);
	var noise = BrownNoise.ar(\noise.kr(0), (1 - \noise.kr(0)));
	var sig = ksc * noise;
	Pan2.ar( sig * \amp.kr(1), \pan.kr(0) );
};

string = f.asCompileString;

string.split($\\).do({|one, i|
	(i != 0).if({
		var from, to;
		from = string.find(one);
		to = one.find(".kr");
		cntSymols.add([from, to])
	})
});
// cntSymols.asArray.postln;

g = {|txt, symbol|
	var posVar, varLenght;
	var arr = List.newClear();
	posVar = string.findAllRegexp(symbol.asString);
	posVar.do({|index|
		// index.postln;
		varLenght = string.findRegexpAt(symbol.asString,index);
		arr.add([index, varLenght[1]])
	});
	arr;
};
// symbol = g.value(string, "var");
// symbol = g.value(string, "\\\\");

v = TextView(w, Rect(5,5,590,290))
.string_(string)
.tabWidth_(25);

cntSymols.asArray.do({|array|
	var from = array[0]-1;
	var to = array[1]+1;
	v.setStringColor(Color.blue, from, to)
});

g.value(string, 'var').do({|array|
	var from = array[0];
	var to = array[1];
	v.setStringColor(Color.red, from, to)
});
)
