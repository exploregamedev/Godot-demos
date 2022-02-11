extends TextureRect
class_name Enemy

# gd3: export(int) var id 
@onready @export var id: int
# gd3: export(String) var label 
@onready @export var label: String

func _ready():
	$Name.text = label

func _on_texture_rect_mouse_entered():
	flip_v = !flip_v
	# gd3: Events.emit_signal("enemy_was_hit", self)
	Events.enemy_was_hit.emit(self)


@export_range(1, 100) var ddd: int
