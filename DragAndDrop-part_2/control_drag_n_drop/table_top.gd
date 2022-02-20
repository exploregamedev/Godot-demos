extends PanelContainer

export(int) var board_size: int = 3
export(Color) var background_color = Color.black

var game_tile_scene: PackedScene = preload("res://control_drag_n_drop/game_tile.tscn")
var game_piece_scene: PackedScene = preload("res://control_drag_n_drop/game_piece.tscn")
onready var _grid: GridContainer = $HLayout/VLayout/HBoxContainer/GridContainer
onready var _game_piece_holder = $HLayout/VLayout/HBoxContainer/PanelContainer/GamePiecesHolder


func _ready() -> void:
    get("custom_styles/panel").bg_color = background_color
    _spawn_new_game_piece("X")
    _spawn_new_game_piece("O")
    _build_game_board()


func _build_game_board() -> void:
    _grid.columns = board_size
    # The grid container will manage the number of rows for us, We do
    #   this nested for loop so each tile knows its col/row indexes
    for row_index in board_size:
        for col_index in board_size:
            _grid.add_child(_spawn_new_game_tile(col_index, row_index))


func _spawn_new_game_tile(column_number: int, row_number: int) -> Node:
    var tile = game_tile_scene.instance()
    tile.column_index = column_number
    tile.row_index = row_number
    ConsoleLogger.log("TableTop", "Spawned new %s" % tile)
    return tile


func _spawn_new_game_piece(x_or_o: String) -> void:
    var game_piece = game_piece_scene.instance()
    game_piece.type = x_or_o
    _game_piece_holder.add_child(game_piece)
