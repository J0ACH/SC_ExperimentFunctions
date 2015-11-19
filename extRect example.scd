(
w = Window.new("", Rect(100,200,800,400)).front;
// w.asView.onResize_{w.view.children.do{_.refresh}};
w.background = Color.new255(30,30,30);

u = UserView(w, Rect.offsetRect(w, 5,5,5,5)).background_(Color.black);

a = UserView(u, Rect.offsetEdgeLeft(u, 5,5,5,350)).background_(Color.gray);
b = UserView(u, Rect.offsetEdgeRight(u, 5,5,5,350)).background_(Color.white);

c = ScrollView(b, Rect.offsetEdgeTop( b, 10,10,10,150)).background_(Color.red);

z = UserView(a, Rect.offsetEdgeTop(a, 5,5,5,200)).background_(Color.green);
v = UserView(a, Rect.offsetEdgeBottom(a, 5,5,5,100)).background_(Color.blue);

d = Button(z, Rect.offsetCornerLT(z, 10,10,50,30)).string_("aaa");
e = Button(z, Rect.offsetCornerLB(z, 10,70,50,30)).string_("bbb");
f = Button(z, Rect.offsetCornerRT(z, 10,10,50,30)).string_("ccc");
g = Button(z, Rect.offsetCornerRB(z, 10,10,50,30)).string_("ddd");

h = StaticText(c, Rect.offsetCornerLT(c, 10,10,50,30)).background_(Color.new255(150,20,50)).stringColor_(Color.white).string_("Ahoj1").align_(\left);
h = StaticText(c, Rect.offsetCornerLT(c, 10,200,50,30)).background_(Color.new255(150,200,50)).stringColor_(Color.white).string_("Ahoj2").align_(\left);
// h = StaticText(c, Rect.offsetCornerLB(c, 10,10,50,30)).background_(Color.new255(150,20,50)).stringColor_(Color.white).string_("Ahoj1").align_(\left);
// t = StaticText(a, Rect.offsetLT(
)

c.innerBounds