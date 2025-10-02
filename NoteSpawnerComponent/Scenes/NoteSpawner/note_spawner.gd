extends Node2D
class_name NoteSpawner

## The color of the circle that notes are placed on in the editor
@export var circleColor:Color = Color("f44c4f")

@export var inEditor:bool = false
	
@export var debugLine:bool = false

@export var minMouseDistance:float = 50.0

@export var radiusInPixels:float = 500.0

## The side that notes begin spawning from. [br][br] [code]-1[/code]: Notes spawn from the left. [br][br] [code]1[/code]: Notes spawn from the right. 
@export_range(-1.0,1.0,2.0) var spawnSide:float = -1.0
## The direction, clockwise or counter-clockwise, that notes spawn in. [br][br][code]-1[/code]: Notes spawn counter-clockwise. br][br][code]1[/code]: Notes spawn clockwise.
@export_range(-1.0,1.0,2.0) var spawnDirection:float = 1.0
## The direction that notes are placed in. Used for when spin direction is changed while mapping. [br][br][code]-1[/code]: Beats along the circumference ascend counter-clockwise. [br][br][code]1[/code]: Beats along the circumference ascent clockwise.
@export_range(-1.0,1.0,2.0) var notePlacementDirection:float = 1.0
## The side that editor beats begin on. [br][br][code]0[/code]: The notes start on the right. [br][br][code]PI[/code]: The notes start on the left.
@export_range(0,PI,PI) var notePlacementSide:float = PI

@export var lmbActionName:StringName 

@onready var editorFeatures:EditorFeatures = $EditorFeatures

var editorSnapDivisor:int = 2
# TEMPORARY VALUE: The bpm of my test song
var bpm:float = 163.0 
var secondsPerBeat:float
var mainSongPosition:float

var testHitTimes:Array = [
	{"start":1.48, "end":1.0, "side":-1.0},
	{"start":1.85, "end":1.0, "side":-1.0},
	{"start":2.22, "end":1.0, "side":-1.0},
	{"start":2.59, "end":1.0, "side":-1.0},
	{"start":2.96, "end":1.0, "side":-1.0}
	]

var currentlySpawnedNotes:Array = []
# The amount of time in seconds a note spawns before its hit time
var spawnWindowInSeconds:float = 1.0
var beatsPerRotation:int = 4

func _input(_event: InputEvent) -> void:
	if !inEditor:
		if Input.is_action_just_pressed("ui_accept"):
			$TestSong.play()

func _process(_delta: float) -> void:
	if secondsPerBeat != 60/bpm: secondsPerBeat = 60/bpm
	if $TestSong.playing:
		mainSongPosition = $TestSong.get_playback_position()
		spawn_notes()

# --- CUSTOM FUNCTIONS ---

func spawn_notes():
	for dict in testHitTimes:
		var start:float = parse_hit_times(dict).start
		var end:float = parse_hit_times(dict).end
		var side:int = parse_hit_times(dict).side
		if abs(mainSongPosition - start) < spawnWindowInSeconds and start not in currentlySpawnedNotes:
			var beatPosition = start/secondsPerBeat
			var angle = fmod(beatPosition, beatsPerRotation) * (TAU/beatsPerRotation)
			var spawnPosition = get_position_along_radius(Vector2(0,0), spawnSide * radiusInPixels * 2, spawnDirection * angle)
			var hitPosition = get_position_along_radius(Vector2(0,0), spawnSide * radiusInPixels, spawnDirection * angle)

			var hitObject:HitObject = HitObject.new()
			hitObject.hitNoteTexture = load("res://Default Images/Hit-Note.png")
			hitObject.position = spawnPosition
			hitObject.center = self.position
			hitObject.start = start
			hitObject.end = hitObject.end
			hitObject.side = side
			

			var tw = create_tween().set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_LINEAR).parallel()
			tw.tween_property(hitObject, "position", hitPosition, start-mainSongPosition)
			self.add_child(hitObject)
			currentlySpawnedNotes.append(start)

func parse_hit_times(dict:Dictionary):
	var ParsedHitObject = HitObjectParser.new()
	ParsedHitObject.start = dict["start"]
	ParsedHitObject.end = dict["end"]
	ParsedHitObject.side = dict["side"] 
	return ParsedHitObject

func get_position_along_radius(circleCenter:Vector2, circleRadius:float, angle:float):
	return circleCenter + Vector2(cos(angle), sin(angle)) * circleRadius
