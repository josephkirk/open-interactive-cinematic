---
title: Ink Scripting
tags:
- study notes
status: WIP
---

[ink - inkle's narrative scripting language (inklestudios.com)](https://www.inklestudios.com/ink/)

# Ink

A narrative scripting language for game

Ink is just pure written text with "markup" to make it interactive.

You can split up your ink file into smaller ones that are linked together.

As with any programming language, you can create custom variables, and perform mathematical calculations.

```ink
"What do you make of this?" she asked.

// Ink script can have comment like this

"I couldn't possibly comment," I replied.

/*
	or a block comment like this
*/

TODO: You can write to do note like this, compiler will printout these note during compilation
```

## Markup Types

### Knots

Example: 
```
=== london ===

=== london_in_flame ===

=== london_is_saved
```

Interactive narrative written with ink comprised of these "knots" section that hold pieces of content scenario.

Knot's can not have spaces in it.

Right triple equal signs is optional. Best leave out if the knot content no longer have divert part.

Within knots you can also have sub-sections called "stitches".

There's a harder-to-learn but easier-to-write system for writing intricate branches called "weave" that doesn't require you to name every section with its own header.


### Diverts
 
Example: 
```
-> london

-> END // special syntax that tell ink that story is done. Fail to include this statement result in loose end warning error.

-> DONE // different way to mark story end.
```

In order to link "knots" together, ink use *divert* arrow markup. This tell the story to go to a different knot section.


### Choices

Example:
```
"Are you a knight, sir?"
+ [Nod curtly.] -> a_knight // bracket [] mean silent choice and not print.
+ I shake my head -> not_a_knight 

// Content can also be embed with choice by writing it under the choices

+ [Nod curtly.]
    Yes i am a proud knight of 7 kingdoms.
+ I shake my head
    No, i am just a squire.

// Choice with * instead of + will never again once chosen. Recommended for repeated knot content

* This choice will not repeat -> next_content
```

### Conditional Content

Example:
```ink
{ catacombs:
    It was darker here than the Paris catacombs.
}

// can also be expressed like this

+ {catacombs} [Tell her what you found] -> tell_her

// complex conditionals

+ {not catacombs} [Visit the catacombs] -> catacomb

{ catacombs and not pick_up_ring:
    "So you didn't find it then?" she enquired.
    + [Apologise.] -> apologise
}

{ (catacombs or cross_river or sing_in_rain) and not buy_new_shoes:
    My shoes were sodden from earlier in the day.
}
```

Conditional is expressed in curly braces bracket.

Conditional content can be written in a whole block within curly braces or express by itself next to a choice.