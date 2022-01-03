extends ColorRect
class_name Draggable

var id: int
var label: String
# set this to true once we've been dropped on our target
var dropped_on_target: bool = false

func _ready() -> void:
	add_to_group("DRAGGABLE")
	$Label.text = label

func get_drag_data(_position: Vector2):
	print("[Draggable] get_drag_data has run")
	if not dropped_on_target:
		return self

func _on_item_dropped_on_target(draggable):
	print("[Draggable] Signal item_dropped_on_target received")
	if draggable.get("id") != id:
		return
	print("[Draggable] Iven been dropped, removing myself from source container")
	queue_free()


