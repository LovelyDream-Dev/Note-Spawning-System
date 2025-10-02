extends Node
class_name HitObjectParser


## The time that the hit object is meant to be hit. If it is less than [member hitEnd], the hit object will become a slider. The hit object is a hit note if it is the same as or greater than [member hitEnd].
var start:float
## The time that the hit object is meant to be released. If it is greater than [member start], the hit object is a slider. The hit object is a hit note if it is less than or equal to [member start].
var end:float
## The side that this note is meant to be hit by. [br][br][code]-1[/code]: Left side. br][br][code]1[/code]: Right side.
var side:int
