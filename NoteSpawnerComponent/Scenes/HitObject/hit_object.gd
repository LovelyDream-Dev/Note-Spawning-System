extends Node2D
class_name HitObject

var hitNoteTexture:Texture = null
var hitNoteOutlineTexture:Texture = null

var start:float
var end:bool
var side:int

var center:Vector2

func _enter_tree() -> void:
	var hitNote = Sprite2D.new()
	var hitNoteOutline = Sprite2D.new()
	hitNote.texture = hitNoteTexture
	hitNoteOutline.texture = hitNoteOutlineTexture
	self.add_child(hitNoteOutline)
	self.add_child(hitNote)
	if side == -1: hitNote.modulate = Color("924CF4")
	elif side == 1: hitNote.modulate = Color("F44C4F")
	self.look_at(center)
