extends Node2D
class_name HitObject

var hitNoteTexture:Texture = null
var sliderBodyTexture:Texture = null

var start:float
var end:bool
var side:int

var center:Vector2

func _enter_tree() -> void:
	var hitNote = Sprite2D.new()
	hitNote.texture = hitNoteTexture
	self.add_child(hitNote)
	if side == -1: self.modulate = Color("924CF4")
	elif side == 1: self.modulate = Color("F44C4F")
	self.look_at(center)
