(
var testMap, textMap;
m = MultiLevelIdentityDictionary.new();

m.put(\stage, \default, \nodeCurr, \nil);
m.put(\stage, \default, \nodePrew, \nil);
m.put(\stage, \default, \group, 1001);
m.put(\stage, \test, \nodeCurr, \nil);
m.put(\stage, \test, \nodePrew, \nil);
m.put(\stage, \test, \group, 1002);
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
