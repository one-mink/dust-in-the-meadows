extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -250.0

@export var inv : Inv
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast_collectible_right: RayCast2D = $AnimatedSprite2D/raycast_collectible_right
@onready var raycast_collectible_left: RayCast2D = $AnimatedSprite2D/raycast_collectible_left

var raycast_list = []

func _ready():
	raycast_list = [raycast_collectible_right, raycast_collectible_left]

func _process(_delta: float) -> void:
	for r in raycast_list:
		if Input.is_action_just_pressed("interact") and  r.is_colliding():
			var object = r.get_collider()
			if object.is_in_group("collectible"):
				object.collected()
				print("items collected")
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
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
