// State tracking
VAR heart_rate = 50 // 50-100 range
VAR knows_garden_layout = false
VAR knows_about_neighbor = false
VAR knows_pipe_condition = false
VAR found_phone = false
VAR knows_tv_schedule = false

// Knowledge counters
VAR observations = 0

-> start

=== function status ===
{ heart_rate >= 90:
    Your heart is racing dangerously fast. You can barely think straight.
- else:
    { heart_rate >= 80:
        Your pulse pounds in your ears, making it hard to focus.
    - else:
        { heart_rate >= 70:
            Your heart beats rapidly with fear.
        - else:
            You try to keep your breathing steady.
        }
    }
}

=== function learn(x) ===
~ observations += x

=== start ===
Your heart pounds against your ribcage as you wake up in the dimly lit bedroom. Three days trapped in this nightmare. The kidnapper's heavy footsteps echo from downstairs - he's watching TV again. This might be your only chance.
~ heart_rate += 10
{status()}

* [Observe surroundings carefully] 
    -> observe_room
* [Rush to act immediately]
    ~ heart_rate += 15
    -> quick_choices

=== observe_room ===
What do you want to focus on?
+ [Study the window area]
    Through the window, you notice Mrs. Johnson's house next door. Her lights are on - she always watches her late-night shows.
    ~ knows_about_neighbor = true
    ~ learn(1)
    -> observe_room

+ [Examine the garden layout]
    You can make out the garden layout below. There's a decorative iron fence, but also a gap near the hedge.
    ~ knows_garden_layout = true
    ~ learn(1)
    -> observe_room

+ [Check the drainpipe]
    The old drainpipe looks rusty near the top brackets. It might not hold much weight.
    ~ knows_pipe_condition = true
    ~ learn(1)
    -> observe_room

+ [Notice the TV sounds]
    You realize it's his favorite show time - he never misses this program and turns the volume way up.
    ~ knows_tv_schedule = true
    ~ learn(1)
    -> observe_room

+ [Search the dresser]
    Hidden in a drawer, you find your phone! Battery dead, but maybe...
    ~ found_phone = true
    ~ learn(1)
    -> observe_room

+ [Finish observing]
    -> main_room

=== quick_choices ===
* [Window]
    -> window_options
* [Door]
    -> door_options
* [Hide and observe]
    -> observe_room

=== main_room ===
{status()}

* {found_phone} [Try to use phone]
    The phone's dead, but...
    ** [Signal neighbors with screen]
        { knows_about_neighbor:
            You angle the phone screen toward Mrs. Johnson's window, desperately flashing it.
            -> neighbor_rescue
        - else:
            You wave the phone uselessly, unsure if anyone can see.
            -> main_room
        }

* [Try the window]
    -> window_options

* [Check the door]
    -> door_options

* [Look around more]
    -> observe_room

=== window_options ===
{status()}

* {heart_rate >= 80} [Panic and jump]
    { knows_garden_layout:
        Despite your panic, you remember the gap near the hedge...
        -> escape_through_garden
    - else:
        You leap blindly into darkness...
        -> death_by_fence
    }

* [Climb down pipe]
    { knows_pipe_condition:
        The rusty brackets worry you...
        ** [Risk it anyway]
            ~ heart_rate += 15
            -> death_by_fall
        ** [Find another way]
            -> main_room
    - else:
        ~ heart_rate += 15
        The pipe breaks free without warning!
        -> death_by_fall
    }

* [Return to room]
    -> main_room

=== door_options ===
{status()}

* [Listen carefully]
    { knows_tv_schedule:
        You know he'll be distracted for the next 30 minutes...
        ~ heart_rate -= 5
        -> careful_escape
    - else:
        You're unsure when he might move around...
        ~ heart_rate += 5
        -> door_options
    }

* [Try to pick lock]
    ~ heart_rate += 10
    { heart_rate >= 85:
        Your trembling hands make too much noise...
        -> captured
    - else:
        -> careful_escape
    }

* [Go back]
    -> main_room

=== careful_escape ===
{ observations >= 3:
    Your careful observations help you avoid the creaky floorboards...
    -> quiet_escape
- else:
    You don't know enough about the house layout...
    -> chase_sequence
}

=== chase_sequence ===
Heavy footsteps thunder up the stairs!
~ heart_rate += 20
{status()}

* {heart_rate >= 90} [Freeze in panic]
    -> captured

* {knows_garden_layout} [Run for the garden gap]
    -> escape_through_garden

* [Run blindly]
    { observations >= 2:
        Your knowledge of the house helps you evade him...
        -> escape
    - else:
        You take a wrong turn...
        -> captured
    }

=== neighbor_rescue ===
Mrs. Johnson notices your signal! Minutes later, police sirens approach...
-> good_ending

=== escape_through_garden ===
Knowing about the gap in the fence saves your life - you squeeze through and run!
-> good_ending

=== quiet_escape ===
Your gathered knowledge helps you slip away without making a sound.
-> good_ending

=== death_by_fence ===
The decorative iron fence claims another victim...
-> END

=== death_by_fall ===
The rusty brackets give way exactly as you feared...
-> END

=== captured ===
"Trying to leave so soon?"
-> END

=== escape ===
You make it to freedom, but barely...
-> END

=== good_ending ===
Thanks to your careful observation{observations >= 4: and planning}, you make it to safety.
The police arrive {knows_about_neighbor: thanks to Mrs. Johnson's call}.
-> END
