extends Panel

func setup(title, description, cost):
	$ItemTitle.text = title
	$ItemDescription.text = description
	$BuyButton.text = str(cost) + " Lines"
