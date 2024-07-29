---
title: Project Structure
category: Planning
tags:
  - architecture
  - unreal 5
pinned: false
dir: ltr
status: wip
---

# Project structure


## Plugins

- OIC_Core: Core functionality include gamemode and component
- OIC_Sample: Example of using OIC 
- OIC_Pickup
- OIC_ChoiceNarrative

## Modules
```
classDiagram
  accTitle: Animal class diagram
  accDescr: Animal parent class with Duck, Fish and Zebra subclasses
  OIC_GameMode <|-- OIC_GameComponent
  OIC_GameMode <|-- OIC_GameSequenceTrack
  class OIC_GameMode{
  }
  class OIC_GameComponent{
    }
  class OIC_GameSequenceTrack{
    +bool is_wild
    +run()
  }
```