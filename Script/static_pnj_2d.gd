extends StaticBody2D

var launchDialogue = false
@export var text: Array
var isTyping = false
var actualPhrase = 0

@onready var label_pnj: Label = $pnj_static_text_ui/NinePatchRect/Label
@onready var nine_patch_rect: NinePatchRect = $pnj_static_text_ui/NinePatchRect



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !launchDialogue:
		nine_patch_rect.visible = false
	if launchDialogue and Input.is_action_just_pressed("interact") and not isTyping:
		talk()
		nine_patch_rect.visible = true
		

func talk():
	isTyping = true
	label_pnj.text = ""
	for lettre in text[actualPhrase]:
		label_pnj.text += lettre
		await get_tree().create_timer(0.08).timeout
	isTyping = false
	actualPhrase = (actualPhrase + 1) % len(text)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		launchDialogue = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		launchDialogue = false
