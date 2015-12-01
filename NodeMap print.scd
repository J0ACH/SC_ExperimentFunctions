(
var testMap, textMap;
m = MultiLevelIdentityDictionary.new();

m.put(\stage, \default, \nodes, \nodeA, \nodeCurr, \nil);
m.put(\stage, \default, \nodes, \nodeA, \nodePrew, \nil);
m.put(\stage, \default, \nodes, \nodeB, \nodeCurr, \quantnode, \env, \nil);
m.put(\stage, \default, \nodes, \nodeB, \nodeCurr, \quantnode, \quant, \quant);
m.put(\stage, \default, \nodes, \nodeB, \nodeCurr, \gui, \qgui_node);
m.put(\stage, \default, \nodes, \nodeB, \nodePrew, \nil);
m.put(\stage, \default, \gui, \qgui_stage);
m.put(\stage, \default, \group, 1001);
m.put(\stage, \test, \nodes, \nodeA, \nodeCurr, \nil);
m.put(\stage, \test, \nodes, \nodeA, \nodePrew, \nil);
m.put(\stage, \test, \group, 1002);
m.put(\stage, \test, \gui, \qgui_stage);
m.put(\current, \stage, \default);
m.put(\current, \proxy, "test");
m.put(\currentStage, \default);

textMap = {|map|
	var txt = "";
	var tabs = "";

	map.sortedTreeDo(
		{|root, stageName, aaa|
			root.notEmpty.if(
				{
					var numTabs = root.size - 1;
					var slot = root.last;
					numTabs.do({tabs = tabs ++ "\t";});
					txt = txt ++ "\n" ++  tabs  ++ "| " ++ slot ++ " | ";
					tabs = "";
				},
				{}
			);
		},
		{|stage, qNode|
			var numTabs = stage.size - 1;
			var slot = stage.last;

			numTabs.do({tabs = tabs ++ "\t";});
			txt = txt ++ "\n" ++ tabs ++ "- " ++ slot ++ ": " ++ qNode;
			tabs = "";
		},
		{},
		{|root, aaa|
			var numTabs = root.size - 1;
			numTabs.do({tabs = tabs ++ "\t";});
			root.notEmpty.if({ txt = txt ++ "\n" ++ tabs ++ "****"; });
			tabs = "";
		},
		{}
	);
	txt;
};

textMap.value(m);
)

(
f = {|stage|
	var stages = List.newClear();
	m.at(\stage, stage.asSymbol, \nodes).notNil.postln;

	// map.at(\stage, stage.asSymbol, \nodes).notNil.if({
	m.at(\stage, stage.asSymbol, \nodes).asAssociations.do({|associations|
		associations.do{|oneAssoc| stages.add(oneAssoc.key) }
	});
	// });
	stages.postln;
	// ^stages.asArray;
}.value(\test)
)


(
var stage = m.at(\stage);
// stage.postln

stage.do({|a, b|
	// b.postln;
	a.put(\group, nil);
	a.at(\group).postln;
	a.postln;
});
m.put(\stage, \default, \group, 1001);
m.put(\stage, \test, \group, 1002);

m.postln
)

// m.removeAt(\a, \b, \c);
// note, \a and \b dictionaries remain

// m.put(\a, \b, \c, 2);
// m.removeEmptyAt(\a, \b, \c);
