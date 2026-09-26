extends CharacterBody2D

class_name Player

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

signal item_collected(item) 

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_collectible: Area2D = $AnimatedSprite2D/Area2D


const DYNAMITE_SCENE = preload("res://Scene/dynamite.tscn")
var throw_x = 200
var nearby_collectible = null
var doors = []

func _ready() -> void:
	doors =  get_tree().get_nodes_in_group("doors")
	for d in doors:
		if d.door_id == Global.target_door_id and Global.target_door_id != " ":
			global_position = d.global_position 


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("throw_dynamite"):
		throw_dynamite()
		
	if Input.is_action_just_pressed("interact") and nearby_collectible:
		print("nearby_collectible = ", nearby_collectible, " classe: ", nearby_collectible.get_class())
		InventoryManager.get_node("Inventory").add_item(nearby_collectible, 1)
		item_collected.emit(nearby_collectible)
		nearby_collectible = null


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
	if area.is_in_group("items"):
		nearby_collectible = area
	else:
		print("pas dans le groupe items")


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("items"):
		nearby_collectible = null

func throw_dynamite():
	var dynamite = DYNAMITE_SCENE.instantiate()
	dynamite.global_position = animated_sprite.global_position
	get_parent().add_child(dynamite)
	add_collision_exception_with(dynamite)
	if animated_sprite.flip_h == true:
		throw_x = -200
	else:
		throw_x = 200
	dynamite.linear_velocity = Vector2(throw_x,-200)
