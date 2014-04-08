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

#Says, Hears
# Setting
# updownleftright
# enter to interact
# Pick up a hat

#HatSays, HatHears
# hat pickup
# i for inventory

#ISays, IHEars
# inventory
# p for phone

#MSays, MHears
# phone call to mother - she tells you she's coming over
#PSays, PHears

#ASays, AHears
# accuse mother
# end tutorial, warning about accusations
#  setting the scene - tell about theft
#  tp to room 2