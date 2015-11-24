(
var location;
var string;

w = Window.new(bounds:Rect(100,100,600,300));
w.background = Color.new255(30,30,30);
w.front;

f = {
	var osc = SinOsc.ar(( \freq.kr(60) + \fplus.kr(0) ), mul: 1, add: 0);
	var noise = BrownNoise.ar(\noise.kr(0), (1 - \noise.kr(0)));
	var sig = osc * noise;
	Pan2.ar( sig * \amp.kr(1), \pan.kr(0) );
};

string = f.asCompileString;

location = {|type, color|
	var arr = [];
	var keys = case
	{type == \var} { \var }
	{type == \varName} { f.def.varNames }
	{type == \class} { f.def.selectors }
	{type == \nameCnt} { f.def.constants };

	keys.do({|oneKey|
		var positions = string.findAll(oneKey.asString);
		positions.do({|onePosition|
			case
			{type == \var}
			{ v.setStringColor(color, onePosition, oneKey.asString.size) }

			{type == \varName}
			{
				(string[onePosition-1] == $\ ).if({
					v.setStringColor(color, onePosition, oneKey.asString.size)
				})
			}

			{type == \class}
			{ v.setStringColor(color, onePosition, oneKey.asString.size) }

			{type == \nameCnt}
			{
				(string[onePosition-1] != $\ ).if({
					v.setStringColor(color, onePosition-1, oneKey.asString.size+1)
				})
			};
		});
	});
	nil;
};

v = TextView(w, Rect(5,5,590,290))
.background_(Color.new255(30,30,30))
.string_(string)
.stringColor_(Color.new255(100,100,100))
.font_(Font("Courier",8,usePointSize:true))
.tabWidth_(25);

location.value(\var, Color.new255(255,255,255));
// location.value(\varName, Color.new255(130,230,230));
location.value(\varName, Color.new255(250,220,100));
location.value(\class, Color.new255(180,180,180));
location.value(\nameCnt, Color.new255(20,180,240));
)
