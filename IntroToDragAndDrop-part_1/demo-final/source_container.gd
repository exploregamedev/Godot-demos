extends Panel

onready var drop_target = get_node("/root/DragAndDropDemo/VLayout/DragAndDropColumns/TargetContainer")
onready var draggable_scene: PackedScene = preload("res://demo-final/draggable.tscn")
onready var draggable_container = $Padding/Rows

var dragables = [
    {"id": 1, "label": "one"},
    {"id": 2, "label": "two"},
    {"id": 3, "label": "three"}
]


func _ready() -> void:
    drop_target.connect("item_dropped_on_target", self, "_on_item_dropped_on_target")
    _populate_dragables()

func _populate_dragables():
    for dragable in dragables:
        var drag_item = draggable_scene.instance()
        drag_item.id = dragable["id"]
        drag_item.label = dragable["label"]
        draggable_container.add_child(drag_item)

func _on_item_dropped_on_target(dropped_item: Draggable) -> void:
    for drag_item in draggable_container.get_children():
        drag_item = (drag_item as Draggable)
        if drag_item.id == dropped_item.id:
            draggable_container.remove_child(drag_item)
            drag_item.queue_free()
            break
