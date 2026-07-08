# RT AutoSprint Extended 2 | Game ver. 1.3.2
## Originally made by JohnEdwa, updated/fixed/maintained by me.

### Latest changes

`2.2.3`

* Fixed HoldSprintToWalk
* Added `ToggleAutoSprint` option

# Description

Removes the need to manually sprint, instead always sprint when the base game would allow you to. Hold sprint to walk and cancel skills like flamethrower.
To supplement that, the sprinting crosshair and speedlines are removed, and the FOV and ~~FOV sprint expanding can be edited.~~

Kudos to Relocity and Thrawnarch for creating the original mod, and Rein, Harb, ThinkInvisible, Twiner son of Twine, and Aaron (among others) from the modding Discord for help.

## Features, Changes and Options.

* Automatically sprints whenever the game would allow you to - including while charging Artificer or Engineer main attacks.
* Show the correct crosshair while sprinting instead of the useless chevron.
* Modify the the FOV, ~~sprinting FOV change~~, and speedline effect in the config.

## Configuration

### Movement

* `HoldSprintToWalk: [true]/false` : True: Holding sprint makes you walk | False: tapping sprint toggles autosprinting on and off.

### Visual

* `FOVValue [60], 1-180`: Sets a custom (vertical) FOV. 60V is roughly 90H.
* `SprintFOVMultiplier: [1.3], 0.1-2.0`: Sets the sprinting FOV multiplier. Set to 1 to disable.
* `DisableSprintingCrosshair: [true]/false`: Disables the useless special sprinting chevron crosshair.
* `DisableSpeedlines: true/[false]`: Disables the speedlines effect shown when sprinting.

### Misc

* `DisabledAutoSprinting: true/[false]`: Disables the autosprinting part of the mod.
* `DisableVisualChanges: true/[false]`: Disables the FOV/visual modification side of the mod.

## To-Do

* Add compatibility for the new survivor entity states. 
* Maybe revive the mod compatibility addon, or add the functiionality to the main mod.

## Special Thanks

* JohnEdwa for making the best mod ever, and for giving permission for me to maintain it.
* IDeathHD helping out with a stupid compiler bug and a sick work around.
* Everyone involved in the development of the modding cores and APIs.
