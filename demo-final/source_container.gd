extends Panel

onready var drop_target = get_node("/root/DragAndDropDemo/VLayout/DragAndDropColumns")
onready var draggable_scene: PackedScene = preload("res://demo-final/draggable.tscn")
onready var draggable_container = $Padding/Rows

onready var target_container: PackedScene = preload("res://demo-final/target_container.tscn")

var dragables = [
	{"id": 1, "label": "one"},
	{"id": 2, "label": "two"},
	{"id": 3, "label": "three"}
]

var targets: Array

func _ready() -> void:
	_populate_dragables(dragables)
	_populate_targets(dragables) #@param: total_targets
	
func _populate_dragables(data):
	for dragable_data in data:
		var drag_item = draggable_scene.instance()
		drag_item.id = dragable_data["id"]
		drag_item.label = dragable_data["label"]
		draggable_container.add_child(drag_item)

func _populate_targets(data):
	for target_data in data:
		var target_instance = target_container.instance()
		# target custom data
		target_instance.get_node("ID").text = str(target_data['id'])
		target_instance.get_node("answer").text = target_data['label']
		
		target_instance.connect("item_dropped_on_target", self, "_on_item_dropped_on_target")
		drop_target.call_deferred("add_child", target_instance) # wait for dragables to be added
		targets.push_back(target_instance)

func _on_item_dropped_on_target(dropped_item: Draggable) -> void:
	for drag_item in draggable_container.get_children():
		drag_item = (drag_item as Draggable)
		if drag_item.id == dropped_item.id:
			draggable_container.remove_child(drag_item)
			drag_item.queue_free()
			break

func clear_items(container) -> void:
	if container.get_children().empty():
		return
		
	for drag_item in container.get_children():
		drag_item = (drag_item as Draggable)
		draggable_container.remove_child(drag_item)
		drag_item.queue_free()

func clear_target_items() -> void:
	# go through each target container
	# print(targets)
	for target_container in targets: 
		var drag_items = target_container.get_node("Padding/Rows")
		clear_items(drag_items)

func _on_Reset_pressed():
	# clear all items and re-populate
	clear_items(draggable_container)
	clear_target_items()
	_populate_dragables(dragables)
