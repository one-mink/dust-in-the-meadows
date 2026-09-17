extends GridContainer

var furniture_list = ["future_flower", "coin"]

func _ready():
	visible = false
	
	for furniture in furniture_list:
		var button = Button.new()
		button.text = furniture
		button.icon = load("res://brackeys_platformer_assets/brackeys_platformer_assets/sprites/"+ furniture+ ".png") #gotta change that with new images!!
		button.expand_icon = true
		button.custom_minimum_size = Vector2(128, 128)
		add_child(button)

func _on_button_pressed() -> void:
	if visible == false:
		visible = true
	else:
		visible = false
	
	
