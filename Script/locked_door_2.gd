extends StaticBody2D

@onready var l_door: Sprite2D = $LDoor
@onready var door_collision: CollisionShape2D = $Doorstate
@onready var interact_area: Area2D = $InteractArea

var player = null
var player_near = false
var is_unlocked = false


func _ready():
	interact_area.body_entered.connect(_on_enter)
	interact_area.body_exited.connect(_on_exit)


func _on_enter(body):
	if body.is_in_group("player"):
		player = body
		player_near = true


func _on_exit(body):
	if body == player:
		player_near = false


func _process(_delta):
	if player_near and not is_unlocked and Input.is_action_just_pressed("interact"):
		_try_unlock()


func _try_unlock():
	if player and player.has_key:
		is_unlocked = true
		player.has_key = false  # Key used up
		l_door.visible = false
		door_collision.disabled = true
		
		var notif = get_tree().current_scene.get_node_or_null("NotificationUI")
		if notif:
			notif.show_notification("Door unlocked! Entering Level 2...")
		
		# 🚀 LOAD LEVEL 2 — change path if yours is different
		get_tree().change_scene_to_file("res://level/level_2_2.tscn")
	else:
		var notif = get_tree().current_scene.get_node_or_null("NotificationUI")
		if notif:
			notif.show_notification("Need a key")
