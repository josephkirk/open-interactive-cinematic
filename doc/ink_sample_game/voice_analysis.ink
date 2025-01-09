// State tracking using proper ink LIST syntax
LIST EmotionalState = neutral, (nervous), angry, scared, relieved 
LIST SpeechPattern = (normal), stutter, rapid, slow, hesitant
LIST Confidence = high, (medium), low
LIST TruthIndicator = truth, partial_truth, (lie)

// Global story variables
VAR current_emotion = neutral
VAR current_pattern = normal
VAR current_confidence = medium
VAR current_truth = lie

// Evidence tracking
LIST Evidence = butler_alibi, maid_testimony, garden_evidence
VAR discovered_evidence = ()

// Score tracking
VAR correct_deductions = 0
-> start
=== function analyze_speech() ===
    { current_emotion:
        - neutral: They speak with a measured, even tone.
        - nervous: A slight tremor underlies their words.
        - angry: Their voice carries barely-contained rage.
        - scared: Fear makes their voice brittle.
        - relieved: The tension drains from their voice.
    }
    { current_pattern:
        - normal: The words flow naturally.
        - stutter: They t-trip over certain words.
        - rapid: The sentences rush together.
        - slow: Each... word... comes... deliberately.
        - hesitant: They pause frequently.
    }

=== start ===
A murder at Blackwood Manor. Three suspects. Your expertise in voice analysis may crack the case.
-> interview_hub

=== interview_hub ===
Who would you like to question?
+ {not (discovered_evidence ? butler_alibi)} [Question the butler] 
    -> interview_butler -> interview_hub
+ {not (discovered_evidence ? maid_testimony)} [Interview the maid]
    -> interview_maid -> interview_hub
+ {not (discovered_evidence ? garden_evidence)} [Speak with the gardener]
    -> interview_gardener -> interview_hub
+ {LIST_COUNT(discovered_evidence) >= 3} [Make your accusation]
    -> make_accusation
- -> DONE

=== interview_butler === 
~ current_emotion = neutral
~ current_pattern = normal
~ current_confidence = high
~ discovered_evidence += butler_alibi

"I served Lord Blackwood his evening tea at precisely 8 PM." <>

* [Study their tone] 
    {analyze_speech()}
    -> butler_questions
* [Ask about routine]
    -> butler_questions

= butler_questions
* [About the tea service]
    ~ current_emotion = nervous
    ~ current_pattern = stutter
    "The cup... when I collected it later... was unusually full."
    -> butler_continue
* [Their whereabouts]
    ~ current_emotion = nervous
    ~ current_confidence = low
    "In my quarters. All evening. Alone, unfortunately."
    -> butler_continue
* [Back to suspects]
    -> butler_continue

= butler_continue
->->

=== interview_maid ===
~ current_emotion = nervous
~ current_pattern = hesitant
~ current_confidence = medium
~ discovered_evidence += maid_testimony

"I was upstairs, cleaning... I heard voices from the study around 9."

* [Analyze their voice]
    {analyze_speech()}
    -> maid_questions
* [Continue questioning]
    -> maid_questions

= maid_questions
* [The voices?]
    ~ current_emotion = scared
    ~ current_pattern = rapid
    "An argument! But I know better than to listen in..."
    -> maid_continue
* [Cleaning details?]
    ~ current_pattern = hesitant
    "Just routine... though there was a broken teacup in his study bin."
    -> maid_continue
* [Return to suspects]
    -> maid_continue

= maid_continue
->->

=== interview_gardener ===
~ current_emotion = angry
~ current_pattern = rapid
~ current_confidence = low
~ discovered_evidence += garden_evidence

"Working on the night jasmine. Saw nothing unusual."

* [Study their manner]
    {analyze_speech()}
    -> gardener_questions
* [Further questions]
    -> gardener_questions

= gardener_questions
* [Garden path]
    ~ current_emotion = nervous
    "Could've been anyone walking by. I was focused on my work."
    -> gardener_continue
* [Study window]
    ~ current_emotion = scared
    ~ current_pattern = stutter
    "It... it was definitely closed. All evening."
    -> gardener_continue
* [Back to suspects]
    -> gardener_continue

= gardener_continue
->->

=== make_accusation ===
Based on voice analysis and evidence, who killed Lord Blackwood?

* [The Butler]
    Poison in the tea? The butler's nervousness about the cup is suspicious...
    But the evidence suggests a more violent confrontation.
    -> wrong_accusation
* [The Maid]
    The maid heard the argument but her fear seems genuine.
    Her hesitation speaks of witnessing, not participating.
    -> wrong_accusation
* [The Gardener]
    Their story about the window changed completely.
    Combined with the broken teacup and overheard argument...
    The evidence and vocal patterns point to a heated confrontation turned violent.
    -> correct_accusation

= wrong_accusation
Your analysis misses crucial voice patterns. The killer remains free.
-> END

= correct_accusation
The gardener breaks down, voice cracking.
"He was going to fire me. I confronted him and things... got out of hand."
-> END