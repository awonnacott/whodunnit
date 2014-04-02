module Mother
	askdidsee = "Mom, do you know anything about my invention having been stolen? Did you see anything, anything at all?"
	didsee = "Well, When I was unpacking this morning your neighbor did come by. He said that he'd like to say he's forgiven you for...what was it...running over his dog? Ah, yes, that was it."
	werehehere = "Well...if he was here on the day of the crime, I better go question him."
	Says = Hash[
		"" => "Hello son",
		"Did you do it?" => "You should be ashamed of yourself!",
		"Make yourself at home" => "Of course sweetie, I always do!",
		askdidsee => didsee,
		werehehere => "OK sweetie, have fun!",
		"goodbye" => 0]
	Hears = Hash[
		"Hello son" => ["Did you do it?", "Make yourself at home", askdidsee, "goodbye"],
		"Of course sweetie, I always do!" => ["Did you do it?", askdidsee, "goodbye"],
		"You should be ashamed of yourself!" => ["Make yourself at home", askdidsee, "goodbye"],
		"OK sweetie, have fun!" => ["Make yourself at home", "goodbye"],
		didsee => [werehehere, "goodbye"]]
end
