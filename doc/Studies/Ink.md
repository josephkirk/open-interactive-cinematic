---
title: Ink Scripting
tags:
- study notes
status: WIP
---

[ink - inkle's narrative scripting language (inklestudios.com)](https://www.inklestudios.com/ink/)

# Ink

A narrative scripting language for game.

Ink is just pure written text with "markup" to make it interactive.
'


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

you can split content across multiple files , using an include statement

```
INCLUDE newspaper.ink
INCLUDE cities/vienna.ink
INCLUDE journeys/orient_express.ink
```

Include should go at the top of a file.

## Markup Types

### Knots

**Example:**
```
=== london ===

=== london_in_flame ===

=== london_is_saved
```

Interactive narrative written with ink comprised of these "knots" section that hold pieces of content scenario.

Knot's can not have spaces in it and should be unique in the story script.

Right triple equal signs is optional. Best leave out if the knot content no longer have divert part.

Within knots you can also have sub-sections called "stitches".

There's a harder-to-learn but easier-to-write system for writing intricate branches called "weave" that doesn't require you to name every section with its own header.

### Stiches

**Example:**
```
=== the_orient_express ===
= in_first_class
	...
= in_third_class
	...
= in_the_guards_van
	...
= missed_the_train
	...

// can be divert like this 

*	[Travel in first class]
	"First class, Monsieur. Where else?"
	-> the_orient_express // first option is default and can be omitted.

*	[Travel in third class]
	-> the_orient_express.in_third_class

*	[Travel in the guard's van]
	-> the_orient_express.in_the_guards_van

// divert local stich don't need full address

-> the_orient_express

=== the_orient_express ===
= in_first_class
	I settled my master.
	*	[Move to third class]
		-> in_third_class

= in_third_class
	I put myself in third.
```

Stiches and knots can share name. However stich name uniqueness is local to knot so several knots can have same stich name.


### Diverts
 
**Example:**
```
-> london

-> END // special syntax that tell ink that story is done. Fail to include this statement result in loose end warning error.

-> DONE // different way to mark story end.
```

In order to link "knots" together, ink use *divert* arrow markup. This tell the story to go to a different knot section.

Divert can be used to create story loop.

### Glue

**Example**
```
=== hurry_home ===
We hurried home <>
-> to_savile_row

=== to_savile_row ===
to Savile Row
-> as_fast_as_we_could

=== as_fast_as_we_could ===
<> as fast as we could.

// produce "We hurried home to Savile Row as fast as we could."
```

The default behavior inserts line-breaks before every new line of content. In some cases, however, content must insist on not having a line-break, and it can do so using <>, or "glue".

### Choices

**Example:**
```
"Are you a knight, sir?"
+ [Nod curtly.] -> a_knight // bracket [] mean silent choice or suppressed and will not be printed after.
+ I shake my head -> not_a_knight 

// Content can also be embed with choice by writing it under the choices

+ [Nod curtly.]
    Yes i am a proud knight of 7 kingdoms. // produce "Yes i am a proud knight of 7 kingdoms" in game
+ I shake my head.
    No, i am just a squire. // produce "I shake my head. No, i am just a squire." in game

// Square bracket can also be used to divide up the option content.

"What's that?" my master asked.
*	"I am somewhat tired[."]," I repeated.
	"Really," he responded. "How deleterious."

/*
produce

    "What's that?" my master asked.
    1: "I am somewhat tired."
    > 1
    "I am somewhat tired," I repeated.
    "Really," he responded. "How deleterious."

*/

// Choice with * instead of + will never again once chosen and is called "Sticky Choice". Recommended for repeated knot content

* This choice will not repeat -> next_content

// Choices options with only "Sticky Choice" will raise "out of option" error if loop and need to include fallback choice

Multiple choices
* Option 1 -> option_1_choosed
* Option 2 -> option_2_choosed
* ->
    Fallback Option
```

### Conditional Content

**Example:**
```ink
{ catacombs:
    It was darker here than the Paris catacombs.
}

// can also be expressed like this

+ {catacombs} [Tell her what you found] -> tell_her

// conditional actually test integer and not true/false flag so you can do something like this

* {catacombs > 3} [You must really love bones] -> love_bone

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

The above "multiple conditions" are really just conditions with an the usual programming AND operator. Ink supports `and` (also written as `&&`) and `or` (also written as `||`) in the usual way, as well as brackets.
### Tags
**Example:**
```ink

He pick up a blue pen # blue pen pick up

// tag for line can be written about it

# the first tag
# the second tag
This is the line of content. # the third tag

// tag can also applied to choice

* A choice! #a tag on both choice and content 
* [A choice #a choice tag not on content ]
* A choice[!] which continues. #a tag on output content only 

* A choice #shared_tag [ with detail #choice_tag ] and content # content_tag 

// tag can contain inline ink script, such as shuffles, cycles, function calls and variable replacements.

{character}: Hello there! #{character}_greeting.jpg 

I open the door. #suspense_music{RANDOM(1, 4)}.mp3 

```

Hashtag can be used to tag content with information which can then be extracted to customize that content or event trigger

## Variable Text

Content in Ink can also vary at the moment of being printed call **Alternatives**

### Sequences

**Example:**
```
The radio hissed into life. {"Three!"|"Two!"|"One!"|There was the white noise racket of an explosion.|But it was just static.}
```

Elements are written inside {...} curly brackets, with elements separated by | symbols (vertical divider lines).

If loop over , sequences will display next element after each loop. When it run out of new content element it continue to show the last element

### Cycle

**Example:**
```
It was {&Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday} today.
```

First element are marked with &.

Cycles are like sequences, but the content element is looped over every display loop. 

### Once-Only
Example:
```
He told me a joke. {!I laughed politely.|I smiled.|I grimaced.|I promised myself to not react again.}
```

First element are marked with !.

Once-only are like sequences, but when there is no new content to display, it display nothing.

### Shuffles
**Example:**
```
I tossed the coin. {~Heads|Tails}.
```


First element are marked with ~

Shuffles produce randomized output

### Other Features
Alternatives can contain blank elements.

```
I took a step forward. {!||||Then the lights went out. -> eek}
```

Alternatives can be nested.

```
The Ratbear {&{wastes no time and |}swipes|scratches} {&at you|into your {&amp;leg|arm|cheek}}.
```

Alternatives can include divert statements.

```
I {waited.|waited some more.|snoozed.|woke up and waited more.|gave up and left. -> leave_post_office}
```

They can also be used inside choice text:

```
+ 	"Hello, {&Master|Monsieur Fogg|you|brown-eyes}!"[] I declared.
```

(...with one caveat; you can't start an option's text with a `{`, as it'll look like a conditional.)

(...but the caveat has a caveat, if you escape a whitespace `\ ` before your `{` ink will recognise it as text.)

```
+\	{&They headed towards the Sandlands|They set off for the desert|The party followed the old road South}
```

Alternatives can be used inside loops to create the appearance of intelligent, state-tracking gameplay without particular effort.

Here's a one-knot version of whack-a-mole. Note we use once-only options, and a fallback, to ensure the mole doesn't move around, and the game will always end.

```
=== whack_a_mole ===
	{I heft the hammer.|{~Missed!|Nothing!|No good. Where is he?|Ah-ha! Got him! -> END}}
	The {&mole|{&nasty|blasted|foul} {&creature|rodent}} is {in here somewhere|hiding somewhere|still at large|laughing at me|still unwhacked|doomed}. <>
	{!I'll show him!|But this time he won't escape!}
	* 	[{&Hit|Smash|Try} top-left] 	-> whack_a_mole
	*  [{&Whallop|Splat|Whack} top-right] -> whack_a_mole
	*  [{&Blast|Hammer} middle] -> whack_a_mole
	*  [{&Clobber|Bosh} bottom-left] 	-> whack_a_mole
	*  [{&Nail|Thump} bottom-right] 	-> whack_a_mole
	*   ->
    	    Then you collapse from hunger. The mole has defeated you!
            -> END
```

produces the following 'game':

```
I heft the hammer.
The mole is in here somewhere. I'll show him!

1: Hit top-left
2: Whallop top-right
3: Blast middle
4: Clobber bottom-left
5: Nail bottom-right

> 1
Missed!
The nasty creature is hiding somewhere. But this time he won't escape!

1: Splat top-right
2: Hammer middle
3: Bosh bottom-left
4: Thump bottom-right

> 4
Nothing!
The mole is still at large.
1: Whack top-right
2: Blast middle
3: Clobber bottom-left

> 2
Where is he?
The blasted rodent is laughing at me.
1: Whallop top-right
2: Bosh bottom-left

> 1
Ah-ha! Got him!
```

## Functions

## Weave