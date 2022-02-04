extends TextureRect

# set this to true once we've been dropped on our target.
#   used to disallow dragging off target once dropped
var dropped_on_target: bool = false

func _ready() -> void:
    add_to_group("DRAGGABLE")

func get_drag_data(_position: Vector2):
    print("[Draggable] get_drag_data has run")
    if not dropped_on_target:
        set_drag_preview(_get_preview_control())
        return self

func _get_preview_control() -> Control:
    """
    The preview control must not be in the scene tree. You should not free the control, and
    you should not keep a reference to the control beyond the duration of the drag.
    It will be deleted automatically after the drag has ended.
    """
    var preview = TextureRect.new()
    preview.texture = texture
    preview.set_rotation(.1) # in readians
    return preview
