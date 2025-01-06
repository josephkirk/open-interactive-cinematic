# Key Learning Points:

## Start with basic variables (VAR)
Use -> for navigation between sections
Mark sections with === name ===
Choices use *, +
Conditions use { }
Code lines start with ~
Functions help organize repeated code
Start simple, then add complexity
Basic Story Structure:

## Variables (track story state)
Starting point
Main choices
Conditional branches
Endings
To expand this:

## Add more variables to track
Create more detailed scenes
Add more complex conditions
Create multiple endings
Add more player choices


// 1. BASIC VARIABLES - Track important story states
// ================================================
VAR heart_rate = 50          // Number variable (50-100)
VAR has_phone = false        // Boolean variable (true/false)
VAR knows_escape_route = false   // Boolean for knowledge

// 2. BASIC STORY START
// ===================
-> beginning   // Arrow means "go to section named beginning"

=== beginning ===
You wake up in a dark bedroom. Your heart pounds with fear.
~ heart_rate += 10    // ~ means "run this code" (increases heart_rate by 10)

* [Look around]       // * marks a choice
    -> look_around    // -> means "go to this section"
* [Rush to window]
    -> window_scene

// 3. BASIC ROOM EXPLORATION
// ========================
=== look_around ===
The bedroom is dimly lit. You see:

+ [Check the drawer]      // + means "choice remains available after picking"
    You find a phone!
    ~ has_phone = true    // Set variable to true when finding phone
    -> look_around        // Return to same section
    
+ [Look out window]
    You notice a safe path through the garden.
    ~ knows_escape_route = true
    -> look_around
    
+ [Done looking]          // Option to move on
    -> make_choice

// 4. BASIC CHOICES WITH CONDITIONS
// ==============================
=== make_choice ===
What will you do?

* {has_phone} [Use phone]     // {condition} Only show choice if condition is true
    -> phone_ending

* {knows_escape_route} [Escape through garden]
    -> garden_escape

* [Try your luck]
    -> risky_escape

// 5. BASIC ALTERNATE ENDINGS
// ========================
=== phone_ending ===
You call for help. Police arrive!
-> END                // END means story is over

=== garden_escape ===
You escape through the garden path!
-> END

=== risky_escape ===
Without knowing the safe path...
-> bad_ending

=== bad_ending ===
You get caught.
-> END

--------------------------------------------

// 1. VARIABLES
// ===========
VAR heart_rate = 50
VAR has_phone = false
VAR knows_garden = false

// 2. HELPER FUNCTION - Check stress level
// =====================================
=== function check_stress ===
{ heart_rate >= 80:
    Your hands shake with fear.
- else:
    You try to stay calm.
}

// 3. STORY START
// =============
-> start

=== start ===
You wake up in a dark bedroom. A nightmare made real.
~ heart_rate += 10

* [Stay calm and look around]
    ~ heart_rate -= 5
    -> explore_room
* [Panic and rush]
    ~ heart_rate += 15
    -> quick_choice

// 4. EXPLORATION SCENE
// ==================
=== explore_room ===
{check_stress()}        // Show stress level

+ [Search drawer]
    You find a phone!
    ~ has_phone = true
    -> explore_room
    
+ [Look outside]
    You spot a garden path.
    ~ knows_garden = true
    -> explore_room
    
+ [Make a decision]
    -> decide_action

// 5. CHOICES BASED ON HEART RATE AND KNOWLEDGE
// =========================================
=== decide_action ===
{check_stress()}

* {has_phone} [Call for help]
    { heart_rate >= 80:
        Your shaking hands drop the phone!
        -> bad_ending
    - else:
        You quietly call police.
        -> good_ending
    }

* {knows_garden} [Use garden path]
    { heart_rate >= 80:
        You run too fast and trip...
        -> bad_ending
    - else:
        You carefully sneak out.
        -> good_ending
    }

* [Just run]
    -> bad_ending

// 6. QUICK CHOICE (HIGH STRESS PATH)
// ================================
=== quick_choice ===
{check_stress()}

* [Jump from window]
    -> bad_ending
* [Stop and think]
    ~ heart_rate -= 10
    -> explore_room

// 7. ENDINGS
// =========
=== good_ending ===
You escape to safety!
-> END

=== bad_ending ===
You get caught...
-> END