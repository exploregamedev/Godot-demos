extends Node2D
class_name GameTile

var row_index
var column_index
export(Color) var default_color
export(Color) var highlight_color
var tile_size: int = 100
var held_piece_type: String = ""


func _ready() -> void:
    $Background.mouse_filter = Control.MOUSE_FILTER_PASS
    $Background.color = default_color
    $Background.rect_size = Vector2(tile_size, tile_size)


func attach_piece(piece: GamePiece):
    $XorO.texture = piece.get_texture()
    held_piece_type = piece.type
    piece.queue_free()


func holding_piece() -> bool:
    return held_piece_type != ""


func highlight_on():
    $Background.color = highlight_color


func highlight_off():
    $Background.color = default_color
