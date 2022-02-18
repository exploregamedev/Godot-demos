extends TextureRect


signal item_dropped_on_target(draggable)
var draggable: PackedScene = preload("res://control_drag_n_drop/game_piece.tscn")
var holds_game_piece: bool = false

func _ready() -> void:
    rect_min_size = Vector2(64,64)

func can_drop_data(position: Vector2, data) -> bool:
    if holds_game_piece:
        return false
    var can_drop: bool = data is Node and data.is_in_group("DRAGGABLE")
    print("[TargetContainer] can_drop_data has run, returning %s" % can_drop)
    return can_drop

func drop_data(position: Vector2, game_piece: TextureRect) -> void:
    texture = game_piece.texture
    holds_game_piece = true
    # @TODO may not need this since we just have an infinite pool of game pieces
    emit_signal("item_dropped_on_target", game_piece)
