module Eli
	ungreeting = "I am your neighbor. You're not a pleasant person."
	inquiry = "Have you an idea of the location of my invention?"
	insult = "No, of course not. Your invention couldn't possibly have value to anyone."
	departure1 = "Well then. It was made of expensive circuitry."
	departure2 = "I wonder if you do have it. Goodbye."
	Says = Hash[
		"" => ungreeting,
		inquiry => insult,
		departure1 => 0,
		departure2 => 0
	]
	Hears = Hash[
		ungreeting => [inquiry],
		insult => [departure1, departure2]
	]
end