module Mother
	askdidsee1 = "Mom, do you know anything about my invention having been stolen?"
	askdidsee2 = "Did you see anything, anything at all?"
	didsee = "Well, When I was unpacking this morning\nyour neighbor did come by.\nHe said that he'd like to say he's forgiven you for...\nwhat was it...\nrunning over his dog?\nAh, yes, that was it."
	werehehere = "Well...if he was here on the day of the crime, I better go question him."
	Says = Hash[
		"" => "Hello son",
		"Did you do it?" => "You should be ashamed of yourself!",
		"Make yourself at home" => "Of course sweetie, I always do!",
		askdidsee1 => didsee,
		askdidsee2 => didsee,
		werehehere => "OK sweetie, have fun!",
		"goodbye" => 0]
	Hears = Hash[
		"Hello son" => ["Did you do it?", "Make yourself at home", askdidsee1, askdidsee2, "goodbye"],
		"Of course sweetie, I always do!" => ["Did you do it?", askdidsee1, askdidsee2, "goodbye"],
		"You should be ashamed of yourself!" => ["Make yourself at home", askdidsee1, askdidsee2, "goodbye"],
		"OK sweetie, have fun!" => ["Make yourself at home", "goodbye"],
		didsee => [werehehere, "goodbye"]]
end
