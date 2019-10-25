<p align="center">
  <a href="https://github.com/joelpurra/jqnpm"><img src="https://raw.githubusercontent.com/joelpurra/jqnpm/master/resources/logotype/penrose-triangle.svg?sanitize=true" alt="jqnpm logotype, a Penrose triangle" width="100" border="0" /></a>
</p>

# [jq-disarray](https://github.com/joelpurra/jq-disarray)

Manipulate arrays while avoiding general disarray.

This is a package for the command-line JSON processor [`jq`](https://stedolan.github.io/jq/). Install the package in your jq project/package directory with [`jqnpm`](https://github.com/joelpurra/jqnpm):

```bash
jqnpm install joelpurra/jq-disarray
```



## Usage


```jq
import "joelpurra/jq-disarray" as Disarray;

# Disarray::haveSameLength(other)
null | Disarray::haveSameLength([]) # false
[] | Disarray::haveSameLength([]) # true
[ "a" ] | Disarray::haveSameLength([ "b" ]) # true
[ "a" ] | Disarray::haveSameLength([]) # false

# Disarray::ifSameLength(other)
[ "a" ] | Disarray::ifSameLength([ "b" ]; map(. + "!")) # [ "a!" ]
[ "a" ] | [ "b" ] as $right | Disarray::ifSameLength($right; Disarray::addition($right)) # [ "ab" ]

# Disarray::defaults(obj)
null | Disarray::defaults(1; "a") # [ "a" ]
null | Disarray::defaults(2; { "a": true }) # [ { "a": true }, { "a": true } ]

# Disarray::zeros
null | Disarray::zeros(3) # [ 0, 0, 0 ]

# Disarray::addition(other)
[ "a" ] | Disarray::addition([ "b" ]) # [ "ab" ]
[ 2, 3, 4 ] | Disarray::addition([ 3, 4, 5 ]) # [ 5, 7, 9 ]
[ "a" ] | Disarray::addition([ "b", "c" ]) # [ "ab", "c" ]
```



---

## License
Copyright (c) 2015 Joel Purra <http://joelpurra.com/>
All rights reserved.

When using **jq-disarray**, comply to the MIT license. Please see the LICENSE file for details.
