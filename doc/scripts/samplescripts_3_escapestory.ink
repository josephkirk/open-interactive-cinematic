// title: The Escape
//author: AI Assistant
// tags: thriller, escape

-> bedroom 

=== bedroom ===
Your heart pounds against your ribcage as you wake up in the dimly lit bedroom. Three days trapped in this nightmare. The kidnapper's heavy footsteps echo from downstairs - he's watching TV again. This might be your only chance.

* [Look around the room carefully]
    You scan the room, trying to control your trembling. A small window with rusty hinges. A desk with some items. A creaky wooden door.
    -> room_options

=== room_options ===
What do you focus on?

* [Check the window]
    The window is small, but you might be able to squeeze through. The rusty hinges could make noise though.
    ** [Try to open it slowly]
        You hold your breath, carefully testing the window. {~It squeaks softly.|The hinges protest quietly.|Your hands shake as you push.}
        -> window_choice
    ** [Look for another option]
        -> room_options

* [Examine the desk]
    On the desk you find: a pen, some old papers, and... a letter opener!
    ** [Take the letter opener]
        -> armed_choices
    ** [Leave it]
        -> room_options

* [Try the door]
    You press your ear against the wood. The TV sounds distant.
    ** [Test the handle]
        It's locked, of course. But the lock looks old...
        -> door_options
    ** [Step back]
        -> room_options

=== armed_choices ===
VAR has_weapon = true
The letter opener feels cold and reassuring in your palm. It's not much, but it's better than nothing.
-> room_options

=== window_choice ===
The window creaks open just enough. The ground is two stories below.

* [Look for something to climb down]
    You spot a sturdy drain pipe running down the wall.
    ** [Try climbing down] 
        Your pulse races as you ease yourself onto the pipe.
        -> climb_sequence
    ** [Too risky]
        -> room_options

* [Close the window]
    -> room_options

=== door_options ===
* {has_weapon} [Try to pick the lock with letter opener]
    With trembling fingers, you work the letter opener into the lock...
    ** [Keep trying...]
        After what feels like hours, there's a soft click!
        -> hallway
    ** [Stop - too noisy]
        -> room_options

* [Give up]
    -> room_options

=== climb_sequence ===
Each movement feels like an eternity. Don't look down. Don't. Look. Down.

* [Keep climbing carefully]
    Halfway there. The pipe groans.
    ** [Hurry!]
        Your feet scramble against the wall. Almost...
        -> freedom
    ** [Maintain slow pace]
        Slow and steady. Every inch is one inch closer...
        -> freedom

* [Freeze in panic]
    You can't move. You can't breathe.
    ** [Force yourself to continue]
        -> climb_sequence
    ** [Climb back up]
        -> room_options

=== hallway ===
The hallway stretches before you. Stairs to the left lead down. A bathroom to the right.
The TV sounds louder here.

* [Creep towards the stairs]
    Each step feels like walking on glass. One wrong move...
    ** [Continue downstairs]
        -> downstairs
    ** [Go back]
        -> bedroom

* [Hide in bathroom]
    Maybe you can find another way out...
    ** [Check bathroom window]
        It's smaller than the bedroom window, but...
        -> bathroom_choice
    ** [Return to hallway]
        -> hallway

=== downstairs ===
You can see him now - slouched in his armchair, back to you. The front door is past him.

* {has_weapon} [Ready the letter opener]
    Your grip tightens on your makeshift weapon.
    -> final_choice

* [Try to sneak past]
    -> final_choice

=== final_choice ===
Your freedom is just steps away. But one creak of the floorboards...

* [Make a dash for the door]
    Your feet fly across the floor - he shouts - you grab the handle -
    -> freedom

* {has_weapon} [Prepare to fight if needed]
    Heart thundering, you edge forward, letter opener raised...
    -> freedom

=== freedom ===
The cool night air hits your face as you run, run, RUN! 
Streets blur past until you find a lit gas station. Help at last.

* [Call the police]
    -> END

=== bathroom_choice ===
The bathroom window is a tight squeeze, but desperation makes anything possible.

* [Force yourself through]
    It hurts, but you manage to wiggle free. A shorter drop here...
    -> freedom

* [Go back]
    -> hallway
