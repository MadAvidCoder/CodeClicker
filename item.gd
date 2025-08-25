extends Panel

@onready var main = $"../../../.."
@onready var auto_timer = $"../../../../AutoCoderTimer"

var cost = INF
var effect
var multiplier
var max_owned
var owned = 0

func setup(title, description, item_cost, item_effect, price_multiplier, max):
	max_owned = max
	effect = item_effect
	multiplier = price_multiplier
	cost = item_cost
	$ItemTitle.text = title
	$ItemDescription.text = description
	$BuyButton.text = str(item_cost) + " Lines"
	$BuyButton.disabled = true
	if title != "Mechanical Keyboard":
		hide()

func _process(delta: float) -> void:
	$BuyButton.disabled = not ((main.score >= cost) and (main.auto_per_sec > 0 or not effect.has("auto_code_multiplier")))
	if not self.visible:
		if main.score >= cost * 0.75:
			if main.auto_per_sec > 0:
				show()
			elif not effect.has("auto_code_multiplier"):
				show()

func _on_buy_button_pressed() -> void:
	if main.score >= cost:
		owned += 1
		main.score -= cost
		cost *= multiplier
		cost = int(floor(cost))
		$BuyButton.text = str(cost) + " Lines"
		for e in effect.keys():
			main.upgrades_bought += 1
			match e:
				"click_power": main.power += effect[e]
				"click_power_multiplier": main.power *= effect[e]
				"auto_code_per_sec":
					main.auto_per_sec += effect[e]
					main.auto_coders_bought += effect[e]
				"auto_code_multiplier":
					main.auto_speed /= effect[e]
					auto_timer.wait_time = main.auto_speed
		if owned >= max_owned:
			hide()
