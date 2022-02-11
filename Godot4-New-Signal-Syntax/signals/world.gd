extends Node2D

const enemy_scene: PackedScene = preload("res://enemy.tscn")

func _ready():
	
	for i in range(3):
		var enemy = enemy_scene.instantiate()
	
	# gd3: Events.connect("enemy_was_hit", self, "_add_hit")
	Events.enemy_was_hit.connect(_anounce_hit)
		

func _anounce_hit(enemy: Enemy) -> void:
	$Anounce.text = "Enemy %s was hit!!!" % enemy.label
	$HLayout/HitCounter.text = str($HLayout/HitCounter.text.to_int() + 1)
