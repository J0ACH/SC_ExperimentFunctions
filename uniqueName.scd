(
f = {|library, rootName|
	var newIndex = -1;
	library.do({|libName|
		(
			(PathName(libName.asString).noEndNumbers == rootName.asString) or:
			(PathName(libName.asString).noEndNumbers.asString == (rootName ++ "_").asString)
		).if({
			(PathName(libName.asString).endNumber.asInteger >= newIndex).if({
				newIndex = PathName(libName.asString).endNumber + 1;
			});
		});
	});
	(newIndex == -1).if(
		{ library.add(rootName)	},
		{ library.add("%_%".format(rootName, newIndex)) }
	);
	library.postln;
	library;
}
)
l = List.newClear();
l = MultiLevelIdentityDictionary.new; // problem with array and assoc in 4 loop?????
f.value(l, \test)
f.value(\pokus)
f.value(\novy)
l = [\test, \test1, \test2, \test3, \pokus];

