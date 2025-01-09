// Object Inspection Game
LIST Tools = magnifier, gloves, evidence_bag, camera, uv_light
LIST ToolState = (none), usable, damaged, depleted

LIST Evidence = fingerprint, bloodstain, fibers, document
LIST Items = key, notebook, paper, pen

LIST ObjectState = unseen, seen, basic_inspection, detailed_inspection, analyzed
LIST LockState = locked, unlocked
LIST LocationState = pristine, disturbed, searched

LIST DeskKnowledge = saw_desk, noticed_drawer, found_lock, discovered_secret
LIST BookKnowledge = saw_books, checked_titles, found_oddity, decoded_message
LIST PaintingKnowledge = saw_painting, noticed_frame, found_safe, opened_safe

VAR studyState = (pristine)
VAR deskState = (unseen)
VAR bookshelfState = (unseen)
VAR paintingState = (unseen)
VAR current_tools = (none)
VAR current_evidence = (none)
VAR current_items = (none)

=== function has_tool(tool) ===
    {
        - (current_tools ? tool):
            ~ return true
        - else:
            ~ return false
    }

=== function get_tool(tool) ===
    {
        - not (current_tools ? tool):
            ~ current_tools += tool
            ~ return true
        - else:
            ~ return false
    }

=== function add_evidence(evidence_item) ===
    {
        - not (current_evidence ? evidence_item):
            ~ current_evidence += evidence_item
            ~ return true
        - else:
            ~ return false
    }

=== function add_knowledge(list_name, knowledge_item) ===
    {
        - not (list_name ? knowledge_item):
            ~ list_name += knowledge_item
            ~ return true
        - else:
            ~ return false
    }

-> begin_game

=== begin_game ===
    Before entering the study, you need to gather your investigation tools.
    -> equipment_preparation

=== equipment_preparation ===
- (tool_selection)
    * {not (current_tools ? Tools.magnifier)} [Take magnifier]
        {get_tool(Tools.magnifier):
            You pick up the magnifying glass.
        }
        -> tool_selection
    
    * {not (current_tools ? Tools.gloves)} [Take gloves]
        {get_tool(Tools.gloves):
            You take the latex gloves.
        }
        -> tool_selection
    
    * {LIST_COUNT(current_tools) >= 2} [Ready to enter]
        {
            - (current_tools ? Tools.magnifier) && (current_tools ? Tools.gloves):
                You have the essential tools.
                -> study_entrance
            - else:
                You need both magnifier and gloves.
                -> tool_selection
        }
    
    -> DONE

=== study_entrance ===
    * [Enter study] -> study_main
    * [Check equipment] -> equipment_review
    -> DONE

=== equipment_review ===
    Current tools:
    {(current_tools ? Tools.magnifier): - Magnifying glass}
    {(current_tools ? Tools.gloves): - Latex gloves}
    
    * [Return] -> study_entrance
    * [Get more tools] -> equipment_preparation
    -> DONE

=== study_main ===
- (main)
    {(studyState ? pristine): 
        The study appears untouched.
    - else:
        The room shows signs of investigation.
    }

    <- examine_room_options
    <- collect_evidence
    
    + [Leave room] -> end_investigation
    -> DONE

=== examine_room_options ===
* {deskState == unseen} [Examine desk]
    -> examine_desk
* {bookshelfState == unseen} [Study bookshelf]
    -> examine_bookshelf
* {paintingState == unseen} [Look at painting]
    -> examine_painting
-> DONE

=== examine_desk ===
- (desk_loop)
    * {has_tool(Tools.magnifier) && not (DeskKnowledge ? noticed_drawer)} 
        [Use magnifier]
        You notice scratches near the drawer.
        ~ add_knowledge(DeskKnowledge, noticed_drawer)
        -> desk_loop
    
    * {has_tool(Tools.gloves) && (DeskKnowledge ? noticed_drawer) && not (DeskKnowledge ? found_lock)}
        [Check drawer]
        You find an unusual lock.
        ~ add_knowledge(DeskKnowledge, found_lock)
        -> desk_loop
    
    + [Step back] -> study_main
    -> DONE

=== examine_bookshelf ===
- (shelf_loop)
    * {has_tool(Tools.magnifier) && not (BookKnowledge ? checked_titles)}
        [Examine books]
        You catalog the titles.
        ~ add_knowledge(BookKnowledge, checked_titles)
        -> shelf_loop
        
    + [Step back] -> study_main
    -> DONE

=== examine_painting ===
- (painting_loop)
    * {has_tool(Tools.magnifier) && not (PaintingKnowledge ? noticed_frame)}
        [Study frame]
        The frame seems unusual.
        ~ add_knowledge(PaintingKnowledge, noticed_frame)
        -> painting_loop
        
    + [Step back] -> study_main
    -> DONE

=== collect_evidence ===
* {has_tool(Tools.evidence_bag) && not (current_evidence ? Evidence.fingerprint)}
    [Collect fingerprints]
    You find clear prints.
    ~ add_evidence(Evidence.fingerprint)
    -> study_main
-> DONE

=== end_investigation ===
    * [Complete investigation] -> END
    * [Continue] -> study_main
    -> DONE