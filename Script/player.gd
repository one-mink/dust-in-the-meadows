extends CharacterBody2D

class_name Player

const SPEED = 150.0
const JUMP_VELOCITY = -550.0
var has_key: bool = false

signal item_collected(item)




@onready var inv : Inv = preload("res://inventory/playerInventory.tres")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_collectible: Area2D = $AnimatedSprite2D/Area2D


var nearby_collectible = null

func collected(item):
	print("player inv instance: ", inv.get_instance_id())
	inv.insert(item)
	print("items collected")
	item_collected.emit(item)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("interact") and nearby_collectible:
		nearby_collectible.collected()
				

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.is_in_group("collectible"):
		nearby_collectible = area.get_parent()
	else:
		print("pas dans le groupe collectible")


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("collectible"):
		nearby_collectible = null
