(
var size = 128;
var icon, shadow, light;
var state_off, state_offOver, state_on, state_onOver;

w = Window(bounds:Rect(100,100,800,300));
w.front;
// w.background = Color.new255(30,30,30);
w.background = Color.new255(30,30,30);
w.onClose_{ icon.free; shadow.free; light.free;};
// state_off = UserView(w, Rect(0,0,w.bounds.width, w.bounds.height));

// i = Image.new("C:/Users/Pesek/Desktop/world.png");

state_off = UserView(w, Rect.offsetCornerLT(w,10,10,size,size));
state_off.background = Color.new255(30,30,30);

state_offOver = UserView(w, Rect.offsetCornerLT(w,150,10,size,size));
state_offOver.background = Color.new255(30,30,30);

state_on = UserView(w, Rect.offsetCornerLT(w,300,10,size,size));
state_on.background = Color.new255(30,30,30);

state_onOver = UserView(w, Rect.offsetCornerLT(w,450,10,size,size/2));
state_onOver.background = Color.new255(30,30,30);

// b = QGui_Button(w, Rect.offsetCornerLT(w, 10,10,200,200));
// b.string_("ahoj");
// b.iconPath("C:/Users/Pesek/Desktop/world.png")

// b.font_(Font( 'Helvetica', 12 ));
// b.colorBackground_(Color.black);
// b.colorFrame_(Color.gray);

// b.colorFrameActive_(Color.new255(255,0,0));

// b.state_("ahoj")
icon = Image.new("C:/Users/Pesek/Desktop/Icons/IconMap.png");
shadow = Image.new("C:/Users/Pesek/Desktop/Icons/IconShadow.png");
light = Image.new("C:/Users/Pesek/Desktop/Icons/IconLight.png");

state_off.drawFunc_{
	icon.drawInRect(Rect(0,0,state_off.bounds.width,state_off.bounds.height),Rect(0,0,icon.width, icon.height), 'sourceOver', 0.3);
	// shadow.drawInRect(Rect(0,0,state_off.bounds.width,state_off.bounds.height),Rect(0,0,icon.width, icon.height), 'sourceOver', 0.25);
	// light.drawInRect(Rect(0,0,state_off.bounds.width,state_off.bounds.height),Rect(0,0,i.width, i.height), 'screen', 1);
};

state_offOver.drawFunc_{
	icon.drawInRect(Rect(0,0,state_offOver.bounds.width,state_offOver.bounds.height),Rect(0,0,icon.width, icon.height), 'sourceOver', 1);
	// shadow.drawInRect(Rect(0,0,state_offOver.bounds.width,state_offOver.bounds.height),Rect(0,0,icon.width, icon.height), 'sourceOver', 0.4);
	// light.drawInRect(Rect(0,0,state_off.bounds.width,state_off.bounds.height),Rect(0,0,i.width, i.height), 'screen', 1);
};

state_on.drawFunc_{
	icon.drawInRect(Rect(0,0,state_on.bounds.width,state_on.bounds.height), Rect(0,0,icon.width, icon.height), 'sourceOver', 0.3);
	shadow.drawInRect(Rect(0,0,state_on.bounds.width,state_on.bounds.height),Rect(0,0,icon.width, icon.height), 'sourceOver', 0.7);
	light.drawInRect(Rect(0,0,state_on.bounds.width,state_on.bounds.height),Rect(0,0,icon.width, icon.height), 'screen', 0.5);
	// Pen.line(0@0, 300@300);
	// Pen.stroke;
};

state_onOver.drawFunc_{
	icon.drawInRect(Rect(0,0,state_onOver.bounds.width,state_onOver.bounds.height), Rect(0,0,icon.width, icon.height), 'sourceOver', 0.7);
	shadow.drawInRect(Rect(0,0,state_onOver.bounds.width,state_onOver.bounds.height),Rect(0,0,icon.width, icon.height), 'sourceOver', 0.9);
	light.drawInRect(Rect(0,0,state_onOver.bounds.width,state_onOver.bounds.height),Rect(0,0,icon.width, icon.height), 'screen', 1);
	// Pen.line(0@0, 300@300);
	// Pen.stroke;
};
// i.setSize(300,300);
// i.plot;
// state_off.backgroundImage_(i);


)

Image.formats;
Image.compositingOperations;
Image.interpolations;