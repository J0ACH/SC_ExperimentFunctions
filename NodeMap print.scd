(
var testMap, textMap;
testMap = MultiLevelIdentityDictionary.new();

testMap.put(\stage, \default, \node, "nil");
testMap.put(\stage, \default, \group, 1001);
testMap.put(\stage, \test, \node, "nil");
testMap.put(\stage, \test, \group, 1002);
testMap.put(\current, \stage, \default);
testMap.put(\current, \proxy, "test");
testMap.put(\currentStage, \default);

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

textMap.value(testMap);
)


// m.removeAt(\a, \b, \c);
// note, \a and \b dictionaries remain

// m.put(\a, \b, \c, 2);
// m.removeEmptyAt(\a, \b, \c);
