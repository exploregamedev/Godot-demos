extends TextureRect


func _ready() -> void:
    add_to_group("DRAGGABLE")

func get_drag_data(_position: Vector2):
    print("[Draggable] get_drag_data has run")
    set_drag_preview(_get_preview_control())
    return self

func _get_preview_control() -> Control:
    var drag_preview = TextureRect.new()
    drag_preview.rect_size = Vector2(texture.get_width(),texture.get_height())
    drag_preview.texture = texture

    # Center on mouse trick learned from "Game Development Center"
    #   https://youtu.be/dZYlwmBCziM?t=199
    var center_on_mouse_control = Control.new()
    center_on_mouse_control.add_child(drag_preview)
    drag_preview.rect_position = -0.5 * drag_preview.rect_size

    return center_on_mouse_control

func set_type(x_or_o: String):
    texture = load("res://assets/game_piece_%s.png" % x_or_o.to_lower())
