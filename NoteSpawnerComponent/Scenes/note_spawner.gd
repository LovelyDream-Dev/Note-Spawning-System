extends Node2D
class_name NoteSpawner

@export var radiusInPixels:float = 500.0
## The side that notes begin spawning from. [br][br] [code]-1[/code]: Notes spawn from the left. [br][br] [code]1[/code]: Notes spawn from the right. 
@export_range(-1.0,1.0,2.0) var spawnSide:float = -1
## The direction, clockwise or counter-clockwise, that notes spawn in. [br][br][code]-1[/code]: Notes spawn counter-clockwise. br][br][code]1[/code]: Notes spawn clockwise.
@export_range(-1.0,1.0,2.0) var spawnDirection:float = -1

# TEMPORARY VALUE: The bpm of my test song
var bpm:float = 163.0 
var secondsPerBeat:float
var mainSongPosition:float
var testHitTimes:Array = [0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7]
var currentlySpawnedNotes:Array = []
# The amount of time in seconds a note spawns before its hit time
var spawnWindowInSeconds:float = 1.0
var beatsPerRotation:int = 4

func _ready() -> void:
	secondsPerBeat = 60/bpm

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$TestSong.play()

func _process(_delta: float) -> void:
	if $TestSong.playing:
		mainSongPosition = $TestSong.get_playback_position()
		spawn_notes()

func spawn_notes():
	for ht in testHitTimes:
		if abs(mainSongPosition - ht) < spawnWindowInSeconds and ht not in currentlySpawnedNotes:
			var testNoteSprite:Sprite2D = Sprite2D.new()
			testNoteSprite.texture = load("res://icon.svg") 
			var beatPosition = ht/secondsPerBeat
			var angle = fmod(beatPosition, beatsPerRotation) * (TAU/beatsPerRotation)
			var spawnPosition = get_position_along_radius(Vector2(0,0), spawnSide * radiusInPixels * 2, spawnDirection * angle)
			var hitPosition = get_position_along_radius(Vector2(0,0), spawnSide * radiusInPixels, spawnDirection * angle)
			testNoteSprite.position = spawnPosition
			var tw = create_tween().set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_LINEAR).parallel()
			tw.tween_property(testNoteSprite, "position", hitPosition, ht-mainSongPosition)
			self.add_child(testNoteSprite)
			currentlySpawnedNotes.append(ht)
			

func get_position_along_radius(circleCenter:Vector2, circleRadius:float, angle:float):
	return circleCenter + Vector2(cos(angle), sin(angle)) * circleRadius
