extends Area2D
class_name GamePiece

var _dragging: bool = false
var type: String setget set_type

signal game_piece_dropped(piece)

func _ready() -> void:
    # Need to be above game board (at z=0)
    z_index = 1


func _process(_delta: float) -> void:
    if _dragging:
        _attach_to_mouse()


func get_texture():
    return $Sprite.texture


func set_type(x_or_o: String):
    type = x_or_o.to_lower()
    $Sprite.texture = load("res://assets/game_piece_%s.png" % type.to_lower())


func _attach_to_mouse():
    global_position = get_global_mouse_position()


func _on_GamePiece_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    # Mouse is over the game piece and left click was made
    if Input.is_action_pressed("click"):
        _dragging = true
    elif Input.is_action_just_released("click"):
        _dragging = false
        emit_signal("game_piece_dropped", self)


