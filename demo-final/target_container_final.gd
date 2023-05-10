extends Panel


signal item_dropped_on_target(draggable)

onready var target_container = $Padding/Rows
var draggable: PackedScene = preload("res://demo-final/draggable.tscn")

func can_drop_data(position: Vector2, data) -> bool:
	var can_drop: bool = data is Node and data.is_in_group("DRAGGABLE")
	print("[TargetContainer] can_drop_data has run, returning %s" % can_drop)
	return can_drop

func drop_data(position: Vector2, data) -> void:
	print("[TargetContainer] drop_data has run")
	print("[TargetContainer] Emiting signal: item_dropped_on_target")
	
	create_drag_copy(data)
	emit_signal("item_dropped_on_target", data)

func create_drag_copy(data) -> void:
	var draggable_copy: ColorRect = draggable.instance()
	draggable_copy.id = data.id
	draggable_copy.label = data.label
	
	print("target_ID: ", $ID.text, "\t", $answer.text)
	print("source_ID: ", data.id, "\t", data.label)
	
	if $ID.text == str(data.id):
		$feedback.set("custom_colors/font_color", Color(0,1,0))
		$feedback.text = "Correct!"
	else: 
		$feedback.set("custom_colors/font_color", Color(1,0,0))
		$feedback.text = "Incorrect!"
	
	draggable_copy.dropped_on_target = true # disable further dragging
	target_container.add_child(draggable_copy)
