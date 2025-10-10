extends Node2D
class_name HitObject

@onready var sliderSpawnTimer:Timer = Timer.new()

var noteContainerParent:Node2D

var hitNoteTexture:Texture = null
var hitNoteOutlineTexture:Texture = null

var hitAngle:float
var releaseAngle:float
var side:int

## TODO Unused slider variables, fix slider implementation
## If the note is a slider, [member sliderProgress] is far along the slider is from 0.0 to 1.0.
var sliderProgress:float
var sliderDuration:float
var sliderSpawnDuration:float
var sliderSpawnProgress:float

var center:Vector2

func _enter_tree() -> void:
	noteContainerParent = get_parent()
	var hitNote = Sprite2D.new()
	var hitNoteOutline = Sprite2D.new()
	hitNote.texture = hitNoteTexture
	hitNoteOutline.texture = hitNoteOutlineTexture
	
	if side == -1: hitNote.modulate = Color("924CF4")
	elif side == 1: hitNote.modulate = Color("F44C4F")
	
	self.add_child(hitNoteOutline)
	self.add_child(hitNote)
	self.look_at(center)

func _ready() -> void:
	#self.add_child(sliderSpawnTimer)
	#sliderSpawnTimer.one_shot = true
	#sliderSpawnTimer.start(sliderSpawnDuration)
	pass

func _process(_delta: float) -> void:
	#sliderSpawnProgress = min(sliderSpawnTimer.time_left / sliderSpawnDuration, 1.0)
	#queue_redraw()
	pass

func _draw() -> void:
	pass
	#if sliderDuration > 0:
		#draw_slider()

func draw_slider():
	draw_circle(noteContainerParent.position, noteContainerParent.radiusInPixels, Color.GREEN, false)
	draw_arc(noteContainerParent.position, noteContainerParent.radiusInPixels, hitAngle, releaseAngle * sliderSpawnProgress, 100, Color.WHITE, 10, true)
