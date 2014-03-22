module Caleb
	greeting1 = "Greetings, Mr. Caleb Bossman. I was just wondering where you were"
	greeting2 = "last night? There was a theft at my house, and"
	greeting3 = "unfortunately you're a suspect."
	indignant = "Gosh durnit, Matthewson!\nYou have the nerve to leave here early to work on your stupid little invention,\nand you try to blame ME when it gets stolen?\nThe audacity!\nI was right here in the office until midnight,\nnot that I should have to dignify you with a response."
	accusation1 = "How did you know it was my invention that was stolen?"
	accusation2 = "I never mentioned that to you."
	coverup = "I. Um. Your Mother informed me.\nShe and I went out for brunch together.\nQuite the charmer, that one.\nI didn't take your precious pile of junk."
	proofq = "Can you prove to me you were here last night?"
	camera = "Of course I can, you imbecile!\nJust check the video footage on the security tapes.\nThey're a bit high up, but I'm sure an...\ninventor like yourself can handle it."
	Says = Hash[
		"" => "Hello, Matthewson.",
		greeting1 => indignant,
		greeting2 => indignant,
		greeting3 => indignant,
		accusation1 => coverup,
		accusation2 => coverup,
		proofq => camera,
		"Of course. Goodbye." => 0]
	Hears = Hash[
		"Hello, Matthewson." => [greeting1, greeting2, greeting3],
		indignant => [accusation1, accusation2],
		coverup => [proofq],
		camera => ["Of course. Goodbye."]]
end