extends Node2D
class_name HitObject

## The time that this note is meant to be hit. If it is greater than [member hitEnd], the note will become a slider. [br] Nothing happens if it is the same as or less than [member hitEnd].
var start:float
var end:float
## The side that this note is meant to be hit by. [br][br][code]-1[/code]: Left side. br][br][code]1[/code]: Right side.
var side:int
## The direction in which this note will spawn in. [br][br][code]-1[/code]: Spawns counter-clockwise. br][br][code]1[/code]: Spawns clockwise.
var direction
