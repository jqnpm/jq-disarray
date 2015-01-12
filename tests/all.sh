#!/usr/bin/env bash


fileUnderTest="${BASH_SOURCE%/*}/../jq/main.jq"


read -d '' fourLineTests <<-'EOF' || true
haveSameLength: False for left null array.
null
haveSameLength([])
false

haveSameLength: False for right null array.
[]
haveSameLength(null)
false

haveSameLength: True for empty arrays.
[]
haveSameLength([])
true

haveSameLength: True for single element arrays.
[ "a" ]
haveSameLength([ "b" ])
true

haveSameLength: False for different length arrays.
[]
haveSameLength([ "b" ])
false

haveSameLength: False for different length arrays.
[ "a" ]
haveSameLength([])
false

ifSameLength: Will apply for same length array.
[ "a" ]
ifSameLength([ "b" ]; map(. + "!"))
[ "a!" ]

ifSameLength: Won't apply for different length array. (Throws error.)
[]
ifSameLength([ "b" ]; map(. + "!"))


ifSameLength: Will apply with reference to $right for same length array.
[ "a" ]
[ "b" ] as $right | ifSameLength($right; addition($right))
[ "ab" ]

defaults: Can create an empty array of strings.
null
defaults(0; "a")
[]

defaults: Can create an array of strings.
null
defaults(1; "a")
[ "a" ]

defaults: Can create an array of objects.
null
defaults(2; { "a": true })
[ { "a": true }, { "a": true } ]

zeros: Can create an array of zeros.
null
zeros(3)
[ 0, 0, 0 ]

addition: Can add two empty arrays.
[]
addition([])
[]

addition: Can add two arrays with the same length.
[ "a" ]
addition([ "b" ])
[ "ab" ]

addition: Can add two arrays with the same length.
[ 2, 3, 4 ]
addition([ 3, 4, 5 ])
[ 5, 7, 9 ]

addition: Can add two arrays with different length.
[ "a" ]
addition([ "b", "c" ])
[ "ab", "c" ]
EOF

function testAllFourLineTests () {
	echo "$fourLineTests" | runAllFourLineTests
}


# Run tests above automatically.
# Custom tests can be added by adding new function with a name that starts with "test": function testSomething () { some test code; }
source "${BASH_SOURCE%/*}/test-runner.sh"
