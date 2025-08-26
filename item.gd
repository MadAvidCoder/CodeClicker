extends Panel

@onready var main = $"../../../.."
@onready var auto_timer = $"../../../../AutoCoderTimer"

var cost = INF
var effect
var multiplier
var max_owned
var owned = 0
var sold_out = false

func setup(title, description, item_cost, item_effect, price_multiplier, max_available):
	max_owned = max_available
	effect = item_effect
	multiplier = price_multiplier
	cost = item_cost
	$ItemTitle.text = title
	$ItemDescription.text = description
	$BuyButton.text = str(item_cost) + " Lines"
	$BuyButton.disabled = true
	if title != "Mechanical Keyboard":
		hide()

func _process(_delta: float) -> void:
	if main.score >= cost:
		if effect.has("auto_code_multiplier"):
			if main.auto_per_sec > 0:
				$BuyButton.disabled = false
			else:
				$BuyButton.disabled = true
		else:
			$BuyButton.disabled = false
	else:
		$BuyButton.disabled = true
	
	if not self.visible and not sold_out:
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
					if main.auto_speed > 0.05:
						main.auto_speed /= effect[e]
						auto_timer.wait_time = main.auto_speed
					else:
						main.auto_per_sec *= effect[e]
		if owned >= max_owned:
			hide()
			sold_out = true
