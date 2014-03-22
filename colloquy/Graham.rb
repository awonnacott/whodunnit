module Graham
	my_man = "HAM, my main man! what's happening?"
	stolen1 = "My most recent invention has been stolen."
	stolen2 = "Know anything 'bout it?"
	sorrybro = "...I don't think so, sorry bro"
	get_alibi1= "Graham, hate to ask you this, but"
	get_alibi2 ="where were you last night between 9 pm and 7am?"
	alibi = "Well, I was helping out with an Emergency Room surgery at my hospital.\nBig milestone, actually.\nIt was my first surgery after being promoted to head anesthesiologist.\nToo bad it pays jack squat..."
	anesthesiaq1 = "Uh, G-man?"
	anesthesiaq2 = "Why do you have a personal supply of anesthesia?"
	anesthesiaq3 = "And why is it half empty?"
	anesthesia = "I'll be honest with you, HAM.\nStaying in the money isn't easy when you're a washed up vet,\nespecially with this arm.\nI'll regret the mysterious anesthesia accident that took it 'till the day I die.\nIt's a bit hard to say, but...\nI figured there wouldn't be much harm in taking a personal supply\nfrom the hospital and selling it on the black market, or,\nbetter yet, some spare kidneys I...ahem...scavenge"
	alt_alibi = "Performing surgery, like I said..."
	check = "Okay, I'll call the hospital to check."
	object = "No, dude! Don't do that!"
	asheck = "NO! I'm your best bud! I'm shady as heck, but I would never do that."
	truth = "Okay. This is gonna sound crazy...\nI was operating on a girl right here, in my room,\nbecause she asked me to.\nAnd, of course, the feds were none the wiser.\nShe gets the procedure she needs from a professional,\nI get some of the money I need, everyone's happy.\nI didn't steal your machine.\nYou can call the gal to check."
	Says = Hash[
		"" => my_man,
		stolen1 => sorrybro,
"1: " + stolen1 => sorrybro,
		stolen2 => sorrybro,
		get_alibi1 => alibi,
"2: " + get_alibi1 => alibi,
		get_alibi2 => alibi,
		"Goodbye" => 0
	]
	Hears = Hash[
		my_man => ["1: " + stolen1, stolen2, "2: " + get_alibi1, get_alibi2],
		sorrybro => [get_alibi1, get_alibi2, "Goodbye"],
		alibi => [stolen1, stolen2, "Goodbye"]
	]
	Says1 = Hash[
		"" => my_man,
		stolen1 => sorrybro,
"1: " + stolen1 => sorrybro,
		stolen2 => sorrybro,
		get_alibi1 => alibi,
"1: " + get_alibi1 => alibi,
"2: " + get_alibi1 => alibi,
		get_alibi2 => alibi,
		anesthesiaq1 => anesthesia,
"2: " + anesthesiaq1 => anesthesia,
"3: " + anesthesiaq1 => anesthesia,
		anesthesiaq2 => anesthesia,
		anesthesiaq3 => anesthesia,
"So " + get_alibi2 => alt_alibi,
		check => object,
		"... This is shady. Thief." => asheck,
		"So, what were you doing?" => truth,
		"Oh. Okay. Wow. Not a thief! Goodbye" => 0,
		"Oh. Okay. Well then. Goodbye" => 0,
		"Goodbye" => 0
	]
	Hears1 = Hash[
		my_man => ["1: " + stolen1, stolen2, "2: " + get_alibi1, get_alibi2, "3: " + anesthesiaq1, anesthesiaq2, anesthesiaq3],
		sorrybro => ["1: " + get_alibi1, get_alibi2, "2: " + anesthesiaq1, anesthesiaq2, anesthesiaq3, "Goodbye"],
		alibi => ["1: " + stolen1, stolen2, "2: " + anesthesiaq1, anesthesiaq2, anesthesiaq3, "Goodbye"],
		anesthesia => ["So " + get_alibi2, "Oh. Okay. Well then. Goodbye"],
		alt_alibi => [check, "Goodbye"],
		object => ["... This is shady. Thief."],
		asheck => ["So, what were you doing?"],
		truth => ["Oh. Okay. Wow. Not a thief! Goodbye"]
	]
end