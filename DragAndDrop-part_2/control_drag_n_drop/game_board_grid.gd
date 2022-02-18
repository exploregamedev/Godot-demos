extends CenterContainer

onready var _grid: GridContainer = $GridContainer
export(int) var number_of_columns = 3
export(int) var number_of_rows = 3

var game_tile: PackedScene = preload("res://control_drag_n_drop/game_tile.tscn")


func _ready() -> void:
    generate_game_board()


func generate_game_board() -> void:
    _grid.columns = number_of_columns
    # The grid container will manage the number of rows for us
    for tile in number_of_columns * number_of_rows:
        _grid.add_child(game_tile.instance())

