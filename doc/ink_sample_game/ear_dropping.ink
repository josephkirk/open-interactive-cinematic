// Track discovered information
LIST Discoveries = invitation_seen, heard_about_jewels, knows_about_deal, found_letter, knows_true_identity

// Track available locations
LIST Locations = main_hall, dining_room, study, garden, servants_quarters

// Track time periods
LIST TimeOfDay = morning, afternoon, evening, night

// Track characters and their locations
LIST Characters = master, guest, butler, maid, gardener

// Main variables
VAR timeUnits = 3
VAR currentLocation = main_hall
VAR suspicionLevel = 0

// Game starts here
-> start_game 

=== function reduce_time() ===
~ timeUnits = timeUnits - 1
~ return timeUnits <= 0

=== function increase_suspicion() ===
~ suspicionLevel = suspicionLevel + 1
~ return suspicionLevel >= 3

=== function get_location_name(loc) ===
    {loc:
    - main_hall: ~ return "main hall"
    - dining_room: ~ return "dining room"
    - servants_quarters: ~ return "servants' quarters"
    - study: ~ return "study"
    - garden: ~ return "garden"
    - else: ~ return "unknown location"
    }

=== start_game ===
A strange guest arrived at the manor this morning. Something about him seems... off.
As head housemaid, you have access to most rooms - and most conversations.
But be careful - if you're caught eavesdropping, there will be consequences.

* [Begin your duties] 
    Time to get to work.
    { reduce_time():
        Time has run out before you even started!
        -> game_over
    }
    -> gameplay_loop
* [Review your goals] 
    You need to discover the true identity of the guest, and his purpose here.
    -> start_game
* -> 
    -> gameplay_loop

=== gameplay_loop ===
{ timeUnits == 3: It's morning.}
{ timeUnits == 2: It's afternoon.}
{ timeUnits == 1: Evening approaches.}

You are in the {get_location_name(currentLocation)}.

* {currentLocation == main_hall} [Listen at the study door]
    -> eavesdrop_study
* {currentLocation == main_hall} [Watch the dining room]
    -> explore_dining_room
* {currentLocation == servants_quarters} [Listen to servant gossip]
    -> listen_servants
* [Move to another location]
    -> location_choice
* -> game_over

=== location_choice ===
Where would you like to go?

* {currentLocation != main_hall} [To the Main Hall]
    ~ currentLocation = main_hall
    -> gameplay_loop
* {currentLocation != dining_room} [To the Dining Room]
    ~ currentLocation = dining_room
    -> gameplay_loop
* {currentLocation != servants_quarters} [To the Servants' Quarters]
    ~ currentLocation = servants_quarters
    -> gameplay_loop
* [Stay here]
    -> gameplay_loop
* -> 
    Time passes as you hesitate.
    { reduce_time():
        -> game_over
    }
    -> gameplay_loop

=== eavesdrop_study ===
~ temp caught = RANDOM(1, 6)
{ caught == 1:
    The butler spots you lingering by the door!
    { increase_suspicion():
        You've been caught snooping too many times. The master dismisses you from service.
        -> game_over
    }
    -> gameplay_loop
}

* [Press your ear to the door]
    You hear the master and the guest talking in low voices...
    {
        - not heard_about_jewels:
            "...the jewels must be moved tonight..."
            ~ Discoveries += heard_about_jewels
        - else:
            {not knows_about_deal:
                "...the deal must be completed before dawn..."
                ~ Discoveries += knows_about_deal
            - else:
                You can't make out anything new.
            }
    }
    -> continue_game
    
* [Step away]
    -> gameplay_loop

* -> 
    { reduce_time():
        Time has run out. 
        -> game_over
    }
    The voices fade away and you can hear nothing more.
    -> gameplay_loop

=== explore_dining_room ===
* [Hide behind the serving screen]
    { not invitation_seen:
        You notice a crumpled invitation on the floor. It bears a strange seal...
        ~ Discoveries += invitation_seen
        -> continue_game
    - else:
        The room is empty for now.
        -> continue_game
    }
    
* [Leave]
    -> gameplay_loop
    
* ->
    { reduce_time():
        Time has run out. 
        -> game_over
    }
    There's nothing more to discover here for now.
    -> gameplay_loop

=== listen_servants ===
* [Join the conversation]
    { not found_letter:
        "Did you see? The guest dropped this letter. It's in some kind of code..."
        ~ Discoveries += found_letter
        -> continue_game
    - else:
        Nothing interesting is being discussed.
        -> continue_game
    }
    
* [Return to work]
    -> gameplay_loop
    
* ->
    { reduce_time():
        Time has run out. 
        -> game_over
    }
    The servants disperse, going back to their duties.
    -> gameplay_loop

=== continue_game ===
{ reduce_time():
    Time has run out. 
    -> game_over
}
-> gameplay_loop

=== game_over ===
Time to report what you've learned.

{ LIST_COUNT(Discoveries) >= 4:
    You've uncovered the truth - the guest is a notorious jewel thief!
    Thanks to your diligence, the master's collection is saved.
    -> END
}

{ LIST_COUNT(Discoveries) >= 2:
    You've discovered something is afoot, but couldn't piece it all together.
    That night, several precious items go missing from the manor...
    -> END
}

You weren't able to discover anything concrete.
Life at the manor continues as normal... though the guest's visit remains a mystery.
-> END