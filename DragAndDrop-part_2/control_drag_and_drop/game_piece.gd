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
    The drag_preview control must not be in the scene tree. You should not free the control, and
    you should not keep a reference to the control beyond the duration of the drag.
    It will be deleted automatically after the drag has ended.
    """
    var drag_preview = TextureRect.new()
    drag_preview.expand = true
    drag_preview.rect_size = Vector2(64,64)
    drag_preview.texture = texture
    drag_preview.set_rotation(.1) # in readians

    # Center on mouse trick learned from "Game Development Center"
    #   https://youtu.be/dZYlwmBCziM?t=199
    var center_on_mouse_control = Control.new()
    center_on_mouse_control.add_child(drag_preview)
    drag_preview.rect_position = -0.5 * drag_preview.rect_size

    return center_on_mouse_control
