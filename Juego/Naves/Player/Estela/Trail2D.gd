#Trail2D.gd
tool
class_name Estela
extends Line2D

export var is_emitting := false setget set_emitting
export var resolution := 5.0
export var lifetime := 0.5
export var max_points := 100
export var target_path: NodePath

var _points_creation_time := []
var _last_point := Vector2.ZERO
var _clock := 0.0
var _offset := 0.0

onready var target: Node2D = get_node_or_null(target_path)

# Setters y Getters
func set_max_points(valor: int) -> void:
	max_points = valor

func _ready() -> void:
	if not target:
		target = get_parent() as Node2D
	
	if Engine.editor_hint:
		set_process(false)
		return

	_offset = position.length()
	set_as_toplevel(true)
	clear_points()
	position = Vector2.ZERO
	_last_point = to_local(target.global_position) + calculate_offset()


func _get_configuration_warning() -> String:
	var warning := "Missing Target node: assign a Node that extends Node2D in the Target Path or make the Trail a child of a parent that extends Node2D"
	if target:
		warning = ""
	return warning


func _process(delta: float) -> void:
	_clock += delta
	remove_older()

	if not is_emitting:
		return

	var desired_point := to_local(target.global_position)
	var distance: float = _last_point.distance_to(desired_point)
	if distance > resolution:
		add_timed_point(desired_point, _clock)


func add_timed_point(point: Vector2, time: float) -> void:
	add_point(point + calculate_offset())
	_points_creation_time.append(time)
	_last_point = point
	if get_point_count() > max_points:
		remove_first_point()


func calculate_offset() -> Vector2:
	return - 1.0 * polar2cartesian(1.0, target.rotation).rotated(- PI / 2) * _offset


func remove_first_point() -> void:
	if get_point_count() > 1:
		remove_point(0)
	_points_creation_time.pop_front()



func remove_older() -> void:
	for creation_time in _points_creation_time:
		var delta = _clock - creation_time
		if delta > lifetime:
			remove_first_point()
		else:
			break


func set_emitting(emitting: bool) -> void:
	is_emitting = emitting
	if Engine.editor_hint:
		return
	
	if not is_inside_tree():
		yield(self, "ready")
	
	if is_emitting:
		clear_points()
		_points_creation_time.clear()
		_last_point = to_local(target.global_position) + calculate_offset()
