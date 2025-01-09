// Testing conditionals with proper syntax
LIST Knowledge = fact_one, fact_two
VAR current_knowledge = (none)

=== function check_knowledge(knowledge_item) ===
    { 
        - (current_knowledge ? knowledge_item):
            ~ return true
        - else:
            ~ return false
    }

=== function add_knowledge(knowledge_item) ===
    {
        - not (current_knowledge ? knowledge_item):
            ~ current_knowledge += knowledge_item
            ~ return true
        - else:
            ~ return false
    }

=== test_knowledge ===
    * {not (current_knowledge ? fact_one)} [Learn fact one]
        ~ add_knowledge(fact_one)
        -> test_knowledge
    * {not (current_knowledge ? fact_two) && (current_knowledge ? fact_one)} [Learn fact two]
        ~ add_knowledge(fact_two)
        -> test_knowledge
    + [Review knowledge]
        -> knowledge_review
    -> DONE

=== knowledge_review ===
    Current knowledge:
    {(current_knowledge ? fact_one): - Learned fact one}
    {(current_knowledge ? fact_two): - Learned fact two}
    
    * [Back] -> test_knowledge
    -> DONE