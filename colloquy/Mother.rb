module Mother
	Says = Hash[
		"" => "Hello son",
		"Did you do it?" => "You should be ashamed of yourself!",
		"Make yourself at home" => "Of course sweetie, I always do!"
		"Mom, do you know anything about my invention having been stolen? Did you see anything, anything at all?" => "Well, When I was unpacking this morning your neighbor did come by. He said that he’d like to say he’s forgiven you for...what was it...running over his dog? Ah, yes, that was it."
		"Well...if he was here on the day of the crime, I better go question him." => "OK sweetie, have fun!"
		"goodbye" => 0]
	Hears = Hash[
		"Hello son" => ["Did you do it?", "Make yourself at home", "Mom, do you know anything about my invention having been stolen? Did you see anything, anything at all?", "goodbye"],
		"OK sweetie, have fun!" => ["Did you do it?", "Make yourself at home", "Mom, do you know anything about my invention having been stolen? Did you see anything, anything at all?", "goodbye"],
		"You should be ashamed of yourself!" => ["Did you do it?", "goodbye"]]
		"Well, When I was unpacking this morning your neighbor did come by. He said that he’d like to say he’s forgiven you for...what was it...running over his dog? Ah, yes, that was it." => {"Well...if he was here on the day of the crime, I better go question him." "goodbye"
end
