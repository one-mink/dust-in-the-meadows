extends StaticBody2D

@onready var door_collision: CollisionShape2D = %Doorstate
@onready var l_door: Sprite2D = $LDoor
@onready var interac_area: Area2D = $InteractArea

var is_unlocked = false
var is_player_in_range = false

func _ready():
	interac_area.body_entered.connect(_on_enter)
	interac_area.body_exited.connect(_on_exit)

func _on_enter(body):
	if body.is_in_group("player") and not is_unlocked:
		is_player_in_range = true
		if not body.has_key:
			print("🔒 Door is locked — find the key in the chest!")
		else:
			print("✅ Press INTERACT to unlock and enter!")

func _on_exit(body):
	if body.is_in_group("player"):
		is_player_in_range = false

func _process(_delta):
	if is_unlocked: return  # Already unlocked — no more checks
	
	if Input.is_action_just_pressed("interact") and is_player_in_range:
		var player = get_tree().get_first_node_in_group("player")
		if not player:
			print("❌ Player not found! Check group 'player'.")
			return
		
		if player.has_key:
			unlock_door_and_enter(player)
		else:
			print("🔑 Need the key from the chest first!")

func unlock_door_and_enter(player):
	is_unlocked = true
	player.has_key = false 
	l_door.visible = false
	door_collision.disabled = true
	get_tree().change_scene_to_file("res://level/lvl1/lvl_1_start.tscn")
