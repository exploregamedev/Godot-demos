extends PanelContainer

export(int) var tile_size = 100
export(Color) var background_color = Color.white

onready var _texture = $TextureRect
var draggable: PackedScene = preload("res://control_drag_n_drop/game_piece.tscn")
var holds_game_piece: bool = false


func _ready() -> void:
    get("custom_styles/panel").bg_color = background_color
    _texture.rect_min_size = Vector2(tile_size, tile_size)


func can_drop_data(_position: Vector2, game_piece) -> bool:
    if holds_game_piece:
        return false
    var can_drop: bool = game_piece is Node and game_piece.is_in_group("DRAGGABLE")
    if can_drop:
        game_piece
    print("[TargetContainer] can_drop_data has run, returning %s" % can_drop)
    return can_drop


func drop_data(_position: Vector2, game_piece: TextureRect) -> void:
    _texture.texture = game_piece.texture
    holds_game_piece = true
    _center_piece()


func _center_piece() -> void:
    var padding = (tile_size - _texture.texture.get_width())/2
    _texture.margin_left = padding
    _texture.margin_top = padding
