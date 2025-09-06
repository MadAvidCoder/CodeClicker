extends Panel

var main: Control
var auto_timer: Timer

var cost = INF
var effect
var multiplier
var max_owned
var owned = 0
var sold_out = false
var cosmetic_type
var flair_label

enum {
	UPGRADE,
	COSMETIC
}

var type
var what

func setup_upgrade(title, description, item_cost, item_effect, price_multiplier, max_available):
	max_owned = max_available
	effect = item_effect
	multiplier = price_multiplier
	cost = item_cost
	$ItemTitle.text = title
	$ItemDescription.text = description
	$BuyButton.text = str(item_cost) + " Lines"
	$BuyButton.disabled = true
	main = $"../../../../.."
	auto_timer = $"../../../../../AutoCoderTimer"
	flair_label = $"../../../../../FlairLabel"
	if title != "Mechanical Keyboard":
		hide()
	type = UPGRADE

func setup_cosmetic(title, description, item_cost, item_effect, item_type):
	what = title
	effect = item_effect
	cosmetic_type = item_type
	cost = item_cost
	$ItemTitle.text = title
	$ItemDescription.text = description
	$BuyButton.text = str(item_cost) + " Flair Credits"
	$BuyButton.disabled = true
	main = $"../../../../../.."
	auto_timer = $"../../../../../../AutoCoderTimer"
	flair_label = $"../../../../../../FlairLabel"
	type = COSMETIC
	match cosmetic_type:
		"background": add_to_group("background")
		"cursor": add_to_group("cursor")
		"click_effect": add_to_group("click_effect")
		"sound_pack": add_to_group("sound_pack")

func _process(_delta: float) -> void:
	if main:
		if type == UPGRADE:
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
				if main.score >= cost * 0.6:
					if main.auto_per_sec > 0:
						show()
					elif not effect.has("auto_code_multiplier"):
						show()
		elif type == COSMETIC:
			if owned == 0:
				if main.flair_credits >= cost:
					$BuyButton.disabled = false
				else:
					$BuyButton.disabled = true

func _on_buy_button_pressed() -> void:
	if type == UPGRADE:
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
	elif type == COSMETIC:
		if owned == 0:
			if main.flair_credits >= cost:
				owned += 1
				main.flair_credits -= cost
				flair_label.text = str(int(floor(main.flair_credits))) + " Flair Credits"
				get_tree().call_group(cosmetic_type, "deactivate", self)
				main.set_cosmetic(cosmetic_type, what)
				$BuyButton.text = "Equipped!"
				$BuyButton.disabled = true
		else:
			if $BuyButton.text != "Equipped!":
				get_tree().call_group(cosmetic_type, "deactivate", self)
				main.set_cosmetic(cosmetic_type, what)
				$BuyButton.text = "Equipped!"
				$BuyButton.disabled = true

func deactivate(caller):
	if caller == self:
		return
	if owned != 0:
		$BuyButton.text = "Equip"
		$BuyButton.disabled = false
