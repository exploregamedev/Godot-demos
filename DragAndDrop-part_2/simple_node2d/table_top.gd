extends Node2D

export(int) var board_size: int = 3
export(Color) var background_color = Color.black

var game_tile_scene: PackedScene = preload("res://simple_node2d/game_tile.tscn")
var game_piece_scene: PackedScene = preload("res://simple_node2d/game_piece.tscn")
var _game_piece_over_tile: GameTile


func _ready() -> void:
    VisualServer.set_default_clear_color(background_color)
    _spawn_new_game_piece("X")
    _spawn_new_game_piece("O")
    _build_game_board()


func _on_game_piece_dropped(piece: GamePiece):
    if _game_piece_over_tile:
        ConsoleLogger.log(
            self.to_string(), "Recieved signal[game_piece_dropped] %s dropped on %s" %
            [piece, _game_piece_over_tile])
        _game_piece_over_tile.attach_piece(piece)
        _game_piece_over_tile = null
        _spawn_new_game_piece(piece.type)
    else:
        ConsoleLogger.log(
            self.to_string(), "%s dropped, but NOT over tile.\nReturning to piece holder" % piece)
#        _return_piece_to_holder(piece)


func _on_game_tile_area_entered(game_piece_area, tile: GameTile):
    ConsoleLogger.log(
        self.to_string(), "Recieved signal[area_entered]. %s entered %s" %
        [game_piece_area, tile])
    if tile.holding_piece():
        return
    _game_piece_over_tile = tile


func _on_game_tile_area_exited(game_piece_area, tile: GameTile):
    _game_piece_over_tile = null


func _return_piece_to_holder(piece: GamePiece):
    piece.position = get_node("%s_PiecePosition" % piece.type.to_upper()).position


func _build_game_board():
    var tile_size: int
    for row_number in board_size:
        for column_number in board_size:
            var tile: GameTile = _spawn_tile()
            tile_size = tile.tile_size
            var x_offset = (10 + tile_size) * column_number
            var y_offset = (10 + tile_size) * row_number
            var tile_position = Vector2(
                $BoardPosition.position.x + x_offset,
                $BoardPosition.position.y + y_offset
                )
            tile.position = tile_position
            tile.row_index = row_number
            tile.column_index = column_number
            ConsoleLogger.log(self.to_string(), "Spawned new %s" % tile)
            add_child(tile)


func _spawn_tile() -> GameTile:
    var game_tile: GameTile = game_tile_scene.instance()
    game_tile.connect("area_entered", self, "_on_game_tile_area_entered", [game_tile])
    game_tile.connect("area_exited", self, "_on_game_tile_area_exited", [game_tile])
    return game_tile


func _spawn_new_game_piece(x_or_o: String) -> void:
    var game_piece: GamePiece = game_piece_scene.instance()
    game_piece.connect("game_piece_dropped", self, "_on_game_piece_dropped")
    game_piece.position = get_node("%s_PiecePosition" % x_or_o.to_upper()).position
    game_piece.type = x_or_o
    add_child(game_piece)
    ConsoleLogger.log(self.to_string(), "Spawned new %s in pieces holder" % game_piece)

func _to_string() -> String:
    return "TableTop"
