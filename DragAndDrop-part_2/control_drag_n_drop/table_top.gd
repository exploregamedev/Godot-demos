extends PanelContainer

export(int) var board_size: int = 3
export(Color) var background_color = Color.black

var game_tile_scene: PackedScene = preload("res://control_drag_n_drop/game_tile.tscn")
var game_piece_scene: PackedScene = preload("res://control_drag_n_drop/game_piece.tscn")
onready var _grid: GridContainer = $VLayout/HBoxContainer/GameBoardGrid/GridContainer
onready var _game_piece_holder = $VLayout/HBoxContainer/CenterContainer/VBoxContainer


func _ready() -> void:
    get("custom_styles/panel").bg_color = background_color
    _spawn_new_game_piece("X")
    _spawn_new_game_piece("O")
    _build_game_board()


func _build_game_board() -> void:
    _grid.columns = board_size
    # The grid container will manage the number of rows for us
    for tile in board_size * board_size:
        _grid.add_child(game_tile_scene.instance())

func _spawn_new_game_piece(x_or_o: String) -> void:
    var game_piece = game_piece_scene.instance()
    game_piece.set_type(x_or_o)
    _game_piece_holder.add_child(game_piece)
