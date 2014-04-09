module Tutorial
	Says = Hash[
		"" => "Use up and down to select an option, then enter to select.\nYou can also use the mouse.\nTo skip this tutorial, press escape, cancel, or Skip Tutorial.",
		"Story" => "You are a cubicle dweller by trade, an inventor by hobby."
		"Controls" => "Use the arrow keys to move.\nWalk up to a hat and press return to take the hat."
		"OK" => 0,
		"Skip Tutorial" => 0
	]
	Hears = Hash[
		"Use up and down to select an option, then enter to select.\nYou can also use the mouse.\nTo skip this tutorial, press escape, cancel, or Skip Tutorial." => ["Story", "Controls", "Skip Tutorial"],
		"You are a cubicle dweller by trade, an inventor by hobby.\n\nYour invention has been stolen.\nExplore to identify the culprit" => ["Controls", "Skip Tutorial"],
		"Use the arrow keys to move.\nWalk up to a hat and press return to take the hat." => ["Story", "OK"]
	]

	HatSays = Hash[
		"" => "Good job taking the hat!",
		"Next" => "Now, press 'i' to look in your inventory and see the hat.",
		"OK" => 0
	]
	HatHears = Hash[
		"Good job taking the hat!" => ["Next"],
		"Now, press 'i' to look in your inventory and see the hat." => ["OK"]
	]

	ISays = Hash[
		"" => "Excellent! Now press 'p' to call your mother on the phone.",
		"OK" => 0
	]
	IHears = Hash[
		"Excellent! Now press 'p' to call your mother on the phone." => ["OK"]
	]

	MSays = Hash[
		"" => "Hello, honey! I was about to call you!\nI'm passing through and need a place to stay,\n so I'm going to stay at your house tonight if that's okay.",
		"Sure" => "Wonderful! I'll see you later.",
		"Wait, what?" => "Wonderful! I'll see you later.",
		"Okay, mom." => "Love you, goodbye!",
		"I love you too." => 0,
		"Goodbye." => 0,
	]
	MHears = Hash[
		"Hello, honey! I'm passing through and need a place to stay,\n so I'm going to stay at your house tonight if that's okay." => ["Sure", "Wait, what?"],
		"Wonderful! I'll see you later." => ["Okay, mom."],
		"Love you, goodbye!" => ["I love you too.", "Goodbye."]
	]

	PSays = Hash[
		"" => "At any point during the game,\nuse the telephone to communicate with anyone you have talked to.\n\nThere is one last control,\nused to accuse someone of stealing your invention.\nIt is on the 'a' key.\n\nTry accusing your mother now.",
		"OK" => 0
	]
	PHears = Hash[
		"At any point during the game,\nuse the telephone to communicate with anyone you have talked to.\n\nThere is one last control,\nused to accuse someone of stealing your invention.\nIt is on the 'a' key.\n\nTry accusing your mother now." => ["OK"],
	]


	ASays = Hash[
		"" => "Of course, you did not acutally lose.\nThis was simulated.\nIf you accuse anyone outside the tutorial,the game ends.\nYou get one guess. Use it wisely.\n\nTo review instructions at any time, press 'h'.",
		"Next" => "It is now the next morning, and time to search for clues.\nStart by going downstairs and try to identify the culprit.",
		"OK" => 0
	]
	AHears = Hash[
		"Of course, you did not acutally lose.\nThis was simulated.\nIf you accuse anyone outside the tutorial,the game ends.\nYou get one guess. Use it wisely.\n\nTo review instructions at any time, press 'h'." => ["Next"],
		"It is now the next morning, and time to search for clues.\nStart by going downstairs and try to identify the culprit." => ["OK"],
	]
end










