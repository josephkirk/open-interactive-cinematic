// Game state tracking
VAR has_weapon = false
VAR has_keys = false
VAR has_hammer = false

LIST ItemState = unseen, seen, taken
VAR letter_opener_state = unseen  
VAR keys_state = unseen
VAR hammer_state = unseen

-> start

=== start ===
Your heart pounds against your ribcage as you wake up in the dimly lit bedroom. Three days trapped in this nightmare. The kidnapper's heavy footsteps echo from downstairs - he's watching TV again. This might be your only chance.
-> main_room

=== main_room ===
{describe_room()}

+ [Search the room]
    You carefully scan your surroundings...
    ~ letter_opener_state = seen
    ~ keys_state = seen
    ~ hammer_state = seen
    -> item_choices
    
+ [Check the window]
    The window is small, but you might be able to squeeze through. Below, you can barely make out something in the darkness - maybe bushes?
    -> window_options
    
+ [Try the door]
    You press your ear against the wood. The TV sounds distant.
    -> door_options

=== function describe_room ===
{letter_opener_state == unseen: On the desk, you spot a letter opener.}
{keys_state == unseen: A set of keys rests on the dresser.}
{hammer_state == unseen: There's a hammer near the window.}
~ return

=== item_choices ===
+ {letter_opener_state == seen && not has_weapon} [Take the letter opener]
    You grab the letter opener, gripping it tightly. A makeshift weapon is better than nothing.
    ~ letter_opener_state = taken
    ~ has_weapon = true
    -> main_room

+ {keys_state == seen && not has_keys} [Take the keys]
    You quietly pocket the keys. They might be useful.
    ~ keys_state = taken  
    ~ has_keys = true
    -> main_room

+ {hammer_state == seen && not has_hammer} [Take the hammer]
    You take the hammer. It's heavy and could be effective.
    ~ hammer_state = taken
    ~ has_hammer = true
    -> main_room

+ [Return to looking around]
    -> main_room

=== window_options ===
* [Look for something to climb down]
    You spot a drain pipe running down the wall. In the dim moonlight, you can see it's old and rusted.
    ** [Try climbing down]
        Your pulse races as you ease yourself onto the pipe.
        -> climbing_death
    ** [Too risky]
        -> main_room
        
* [Try jumping]
    It's dark, but it doesn't look too far down...
    ** [Take the risk]
        -> fence_death
    ** [Think better of it]
        -> main_room
        
* [Close the window]
    -> main_room

=== climbing_death ===
You grab the drain pipe, testing your weight. It seems to hold.
Halfway down, you hear a terrible screech of metal.
The pipe tears away from the wall.

You fall.

The last thing you hear is the kidnapper's laughter from the window above.
-> END

=== fence_death ===
You take a deep breath and jump.
Time seems to slow.
Then you see it - the decorative iron fence, its spikes gleaming in the moonlight.
Too late.

The spikes rise to meet you, and darkness follows.
-> END

=== door_options === 
* {has_keys} [Use the keys]
    With trembling hands, you try the keys in the lock...
    {~The first key doesn't fit.|The second key sticks.|The third key turns!}
    -> hallway
    
* {has_weapon} [Pick the lock with letter opener]
    You work the letter opener into the lock mechanism...
    ** [Keep trying]
        After what feels like hours, there's a soft click!
        -> hallway
    ** [Too noisy]
        -> main_room
        
* {has_hammer} [Break the lock]
    You raise the hammer, knowing this will make noise...
    -> break_door
    
+ [Step back]
    -> main_room

=== break_door ===
The sound of splintering wood seems deafening!
Heavy footsteps below suddenly stop.
* [Hide!]
    -> captured
* [Run!]
    -> hallway

=== hallway ===
The hallway stretches before you. Stairs to the left lead down. A bathroom to the right.
The TV sounds louder here.
* [Sneak towards stairs]
    Each step feels like walking on glass.
    ** [Continue downstairs]
        -> downstairs
    ** [Go back]
        -> main_room
* [Hide in bathroom]
    Maybe you can find another way out...
    ** [Check bathroom window]
        It's smaller than the bedroom window, but maybe...
        -> bathroom_window_caught
    ** [Return to hallway]
        -> hallway

=== bathroom_window_caught ===
As you struggle to squeeze through the tiny window, you hear heavy footsteps.
"Going somewhere?"
His rough hands grab your ankles and pull you back inside.
-> captured

=== downstairs ===
You can see him now - slouched in his armchair, back to you. The front door is past him.
+ {has_weapon} [Ready your weapon]
    Your grip tightens on the {has_hammer:hammer|letter opener}.
    -> final_choice
+ [Try to sneak past]
    -> final_choice 

=== final_choice ===
Your freedom is just steps away. But one creak of the floorboards...
* {has_weapon} [Attack!]
    You spring forward, weapon raised...
    -> escape
* [Make a dash for the door]
    Your feet fly across the floor - he shouts - you grab the handle -
    -> escape

=== captured ===
His heavy footsteps come up the stairs. The door bursts open.
"Trying to leave so soon? Now I'll have to make sure that never happens again..."
-> END 

=== escape ===
The cool night air hits your face as you run, run, RUN!
Streets blur past until you find a lit gas station. Safety at last.
-> END
