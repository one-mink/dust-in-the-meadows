extends StaticBody2D


@export var scene_direction: String  


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_on_zone = false
var door_state = "closed"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_on_zone:
		if door_state == "closed":
			door_state = "open"
			animated_sprite_2d.play("open")
			await get_tree().create_timer(0.5).timeout
			get_tree().change_scene_to_file(scene_direction)
		else:
			door_state = "closed"
			animated_sprite_2d.play("closed")
			
			
			
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		is_on_zone = true



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		is_on_zone = false
