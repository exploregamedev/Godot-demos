extends Container

@onready @export_node_path(LineEdit, TextEdit) var input_element

func _ready():
	add_child(input_element)
