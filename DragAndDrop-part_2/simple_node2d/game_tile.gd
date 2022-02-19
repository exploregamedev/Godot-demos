extends Node2D
class_name GameTile

export(int) var tile_size: int = 100
export(Color) var background_color = Color.white

var held_piece_type: String = ""
var row_index
var column_index


func _ready() -> void:
    $Background.color = background_color
    $Background.mouse_filter = Control.MOUSE_FILTER_PASS
    $Background.rect_size = Vector2(tile_size, tile_size)


func attach_piece(piece: GamePiece):
    $XorO.texture = piece.get_texture()
    held_piece_type = piece.type
    piece.queue_free()


func holding_piece() -> bool:
    return held_piece_type != ""

