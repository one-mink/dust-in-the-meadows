extends CanvasLayer
@onready var CoinLabel: Label = %CoinLabel
@onready var ShopPanel: PanelContainer = %ShopPanel
@onready var ShopList: GridContainer = %ShopList

var coins: int = 0

var shop_items: Array = [
	{"name": "Speed Boost", "price": 5, "icon": "res://assets/sprites/seed_asset_prototype.png"},
	{"name": "Extra Key", "price": 10, "icon": "res://assets/sprites/seed_asset_prototype.png"}
]

func _ready():
	_update_coins_label()
	_populate_shop_list()

func add_coin() -> void:
	coins += 1
	_update_coins_label()

func _update_coins_label() -> void:
	if CoinLabel:
		CoinLabel.text = "Coins: " + str(coins)

func _populate_shop_list() -> void:
	# Clear existing items
	for child in ShopList.get_children():
		child.queue_free()
	
	for shop_item in shop_items:
		var item_box = VBoxContainer.new()
		item_box.alignment = VBoxContainer.ALIGNMENT_CENTER
		
		# Image slot
		var icon = TextureRect.new()
		icon.custom_minimum_size = Vector2(64, 64)
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		if shop_item.has("icon") and shop_item["icon"] != "":
			icon.texture = load(shop_item["icon"])
			item_box.add_child(icon)
		
		var label = Label.new()
		label.text = shop_item["name"] + "\n" + str(shop_item["price"]) + " coins"
		item_box.add_child(label)
		
		# Buy button
		var buy_button = Button.new()
		buy_button.text = "Buy"
		buy_button.pressed.connect(_on_buy_pressed.bind(shop_item))
		item_box.add_child(buy_button)
		
		ShopList.add_child(item_box)

func _on_buy_pressed(shop_item: Dictionary) -> void:
	var notif = get_tree().current_scene.get_node_or_null("NotificationUI")
	if not notif:
		print("⚠️ NotificationUI not found")
		return
	
	if coins >= shop_item["price"]:
		coins -= shop_item["price"]
		_update_coins_label()
		notif.show_notification("Bought " + shop_item["name"] + "!")
		
		var ach = get_tree().current_scene.get_node_or_null("AchievementManager")
		if ach:
			ach.unlock("first_purchase", "First Purchase!")
	else:
		notif.show_notification("Not enough coins!")

func _on_shop_button_pressed() -> void:
	if ShopPanel:
		ShopPanel.visible = !ShopPanel.visible
