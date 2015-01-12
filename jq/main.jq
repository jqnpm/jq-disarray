import "joelpurra/jq-dry" as DRY;


def haveSameLength($right):
	length == ($right | length)
	and (
		(
			type == "null"
			or ($right | type == "null")
		)
		| not
	);

def ifSameLength($right; f):
	if haveSameLength($right) then
		f
	else
		error("Arrays were not of same length.")
	end;

def defaults($length; $value):
	if $length < 0 then
		error("Can't have fewer than 0 elements.")
	elif $length == 0 then
		[]
	else
		[]
		| .[$length - 1] = $value
		| map($value)
	end;

def zeros($length):
	defaults($length; 0);

# The name 'addition' isn't great, but 'add' is a jq built-in.
def addition($right):
	. as $left
	| ([length, $right | length] | max) as $length
	# TODO: Use DRY::iterate which has { index: 0, value: [] }?
	| DRY::iterate(
		$length;
		.[0] as $iteration
		| .[1]
		| .[$iteration] = (
				$left[$iteration]
				+ $right[$iteration]
			)
	)
	| .[1];
