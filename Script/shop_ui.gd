extends CanvasLayer

var coins: int = 0

var shop_items:  Array =[
	{"name": "Blue Decoration", "price": 3},
	{"name": "Lantern", "price": 5},
	{"name": "Rug", "price": 8}
]

func _ready() -> void:
	_update_coins_label()
	_populate_shop_list()

func add_coins(amount: int) -> void:
	coins += amount
	_update_coins_label()
	
func _update_coins_label() -> void:
	%CoinLabel.text ="Coins: " + str(coins)
	
func _populate_shop_list() -> void:
	for child in %ShopList.get_children():
		child.queue_free()
		
	for shop_item in shop_items:
		var row = HBoxContainer.new()
		
		var label = Label.new()
		label.text = shop_item["name"] + "-" + str(shop_item["price"]) + " coins"
		row.add_child(label)
		
		var buy_button = Button.new()
		buy_button.text = "Buy"
		buy_button.pressed.connect(_on_buy_pressed.bind(shop_item))
		row.add_child(buy_button)
		
		%ShopList.add_child(row)
		
func _on_buy_pressed(shop_item:Dictionary) -> void:
	var notif = get_tree().current_scene.get_node("NotificationUI")
	if coins >= shop_item["price"]:
		coins -= shop_item["price"]
		_update_coins_label()
		notif.show_notification("Bought " + shop_item["name"] + "!")
		get_tree().current_scene.get_node("AchievementManager").unlock("first_purchase", "First Purchase!")
	else:
		notif.show_notification("Not enough coins!")
		
func _on_shop_button_pressed() -> void:
	%ShopPanel.visible = !%ShopPanel.visible
