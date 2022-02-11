extends PanelContainer


export(int) var number_of_columns = 3
export(int) var number_of_rows = 3

var game_tile: PackedScene = preload("res://control_drag_and_drop/game_tile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    generate_game_board()


func generate_game_board() -> void:
    for column in number_of_columns:
        var game_board_column = make_column()
        for row in number_of_rows:
            game_board_column.add_child(game_tile.instance())
        $HBoxContainer.add_child(game_board_column)


func make_column() -> VBoxContainer:
    var vbox_column:= VBoxContainer.new()
    vbox_column.size_flags_vertical = SIZE_EXPAND_FILL
    vbox_column.alignment = VALIGN_CENTER
    return vbox_column
