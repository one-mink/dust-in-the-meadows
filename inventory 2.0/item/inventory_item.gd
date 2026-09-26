extends Node

class_name Item

@export var item_name: String = ""
@export var icon: Texture2D
@export var is_stackable: bool = false
@export var description: String = ""

func _ready() -> void:
	add_to_group("items")
