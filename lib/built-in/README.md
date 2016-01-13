Crimson Built-In
=====

Crimson's built-in library is a collection of utility functions considered
important enough to be included at the language level. These include functions
such as `map` as well as the macros `and` and `or`.

Some of the code included implements specific features of R6RS compliance,
however most of it is included to bring Scheme more in line with the
expectations programmers have of modern programming languages. Some of this
code may be non-standard, all of it should be portable.

## Overview

These are the primitive functions provided by the built-in library.

### list.scm

A collection of list operations functions.

#### map: f l

Map function +f+ to each value in list +l+ return the result of each.

#### exists-in?: e l

Seach list +l+ for element +e+

### macros.scm

A collection of userful Scheme macros.

#### and: x x
