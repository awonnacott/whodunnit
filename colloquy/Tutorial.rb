module Tutorial
	a = "Use the arrow keys to move. Use space or enter to interact. Use A to accuse."
	b = "You are a cubicle dweller by trade, an inventor by hobby.\nYou invention has been stolen. Explore to identify the culprit."
	Says = Hash[
		"" => "Use up and down to select an option, then enter to select",
		"Controls" => a,
		"Next" => b,
		"OK" => 0
	]
	Hears = Hash[
		"Use up and down to select an option, then enter to select" => ["Controls", "Next"],
		a => ["Next"],
		b => ["OK"]
	]
end