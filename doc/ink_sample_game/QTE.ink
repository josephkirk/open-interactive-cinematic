// Core game variables
VAR player_health = 100
VAR enemy_health = 100
VAR combo_counter = 0
VAR score = 0

LIST QTEState = ready, success, fail, perfect
VAR current_qte = ready
-> fight_dragon
// Main game loop
=== fight_dragon ===
The dragon towers before you, its scales gleaming.
-> combat_loop

=== combat_loop ===
{ enemy_health <= 0:
    -> victory
}
{ player_health <= 0:
    -> game_over
}

// QTE Combat Options
+ [Quick Attack] 
    -> quick_attack
+ [Heavy Attack]
    -> heavy_attack
+ [Block]
    -> block_attack
    
=== quick_attack ===
+ [PRESS X NOW!] 
    {
        - RANDOM(1,100) > 50: 
            ~ current_qte = success
            ~ enemy_health -= 15
            ~ combo_counter += 1
            ~ score += 100 * combo_counter
            Perfect hit! The dragon reels back. ->combat_loop
        - else:
            ~ current_qte = fail
            ~ combo_counter = 0
            Miss! The dragon counters! ->combat_loop
            ~ player_health -= 10
    } 
-> combat_loop

=== heavy_attack ===
+ [↑ ↓ X (Quickly!)]
    {
        - RANDOM(1,100) > 70:
            ~ current_qte = perfect 
            ~ enemy_health -= 30
            ~ combo_counter += 2
            ~ score += 250 * combo_counter
            Devastating blow! The dragon howls in pain! ->combat_loop
        - else:
            ~ current_qte = fail
            ~ combo_counter = 0
            Too slow! The dragon's tail catches you! ->combat_loop
            ~ player_health -= 20
    }
-> combat_loop

=== block_attack ===
+ [HOLD B...]
    {
        - RANDOM(1,100) > 40:
            ~ current_qte = success
            ~ combo_counter += 1
            ~ score += 50 * combo_counter
            You deflect the dragon's attack! ->combat_loop
        - else:
            ~ current_qte = fail
            ~ combo_counter = 0
            ~ player_health -= 25
            Your guard breaks! The dragon's flames burn you! ->combat_loop
    } 
-> combat_loop

=== victory ===
Victory! You've defeated the dragon!
Final Score: {score}
Max Combo: {combo_counter}
-> END

=== game_over ===
The dragon has defeated you...
Final Score: {score}
-> END