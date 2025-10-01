extends Node2D
class_name EditorFeatures

var notePlacementDirection:float
var minMouseDistance:float 
var editorSnapDivisor:int

var circleColor:Color:
	set(value):
		circleColor = value
		queue_redraw()
var radiusInPixels:float:
	set(value):
		radiusInPixels = value
		queue_redraw()

## Array of all beats included in the editor snap divisor. Used for snapping.
var beatPositions:Array = [1.0, 1.5, 2.0]

var parent:NoteSpawner

var mousePos:Vector2
var closestCirclePositionToMouse:Vector2
var currentMouseBeatOnCircle:float

func _ready() -> void:
	parent = get_parent()

func _process(_delta: float) -> void:
	editorSnapDivisor = parent.editorSnapDivisor
	notePlacementDirection = parent.notePlacementDirection
	mousePos = get_global_mouse_position()
	circleColor = parent.circleColor
	radiusInPixels = parent.radiusInPixels
	minMouseDistance = parent.minMouseDistance
	get_closest_circle_position_to_mouse(parent.position)
	get_beat_from_circle_position(parent.position)

func _draw() -> void:
	draw_circle(parent.position, radiusInPixels, circleColor, false, 4.0, true)
	if parent.debugLine:
		if mousePos and closestCirclePositionToMouse:
			draw_line(mousePos, closestCirclePositionToMouse, Color.WHEAT)

func get_closest_circle_position_to_mouse(center:Vector2):
	var vector = mousePos - center
	closestCirclePositionToMouse = center + vector.normalized() * radiusInPixels

func get_beat_from_circle_position(center:Vector2):
	var angle = atan2(closestCirclePositionToMouse.y - center.y, closestCirclePositionToMouse.x - center.x)
	var normalizedAngle = fposmod(notePlacementDirection * angle, TAU)
	var value = normalizedAngle / TAU * 4
	value = snappedf(value,1.0/float(editorSnapDivisor))
	# Wrap the value around to zero if it hits 4
	if value >= 4:
		value = 0.0
	currentMouseBeatOnCircle = value
