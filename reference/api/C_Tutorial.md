# C_Tutorial

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`3` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AbandonTutorialArea

```lua
C_Tutorial.AbandonTutorialArea()
```

### GetCombatEventInfo

```lua
C_Tutorial.GetCombatEventInfo()
```

### ReturnToTutorialArea

```lua
C_Tutorial.ReturnToTutorialArea()
```

## Events

### LeavingTutorialArea

Fires as `LEAVING_TUTORIAL_AREA`.

No payload.

### NpeTutorialUpdate

Fires as `NPE_TUTORIAL_UPDATE`.

No payload.

### TutorialCombatEvent

Fires as `TUTORIAL_COMBAT_EVENT`.

No payload.

### TutorialHighlightSpell

Fires as `TUTORIAL_HIGHLIGHT_SPELL`.

```lua
payload: spellID: number, tutorialGlobalStringTag: cstring
```

### TutorialTrigger

Fires as `TUTORIAL_TRIGGER`.

```lua
payload: tutorialIndex: number, forceShow: bool
```

### TutorialUnhighlightSpell

Fires as `TUTORIAL_UNHIGHLIGHT_SPELL`.

No payload.
