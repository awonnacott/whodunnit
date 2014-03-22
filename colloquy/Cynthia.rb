module Cynthia
	overhear = "Overheard: Watch this, honey, it'll definitely work on this guy."
	isbadspy = "Bonjour, monsier, My name eez Agent Chapeau.\nDo you happen to work for any important government facilities?\nHave you any secret information?"
	arebadspy = "I do not, ma'am. Are you some sort of lousy french spy?"
	amnotbadspy = "Why I never?! I am insulted! Le hmmph!"
	greeting1 = "Hello, Agent Chapeau."
	greeting2 = "I couldn't help but overhear your exchange over there."
	greeting3 = "I also happen to know your date, Professor Reactor."
	greeting4 = "I'm H.A.M."
	regreeting = "Oh, we are very pleezed to meet you, monsier! Sit down, talk with us!"
	ask_alibi1 = "Madame, can you tell me anything about where"
	ask_alibi2 = "you or your beau were last night?"
	ask_alibi3 = "He's a longstanding rival of mine"
	ask_alibi4 = "and something precious to me has been stolen."
	alibi = "Ricky would never do zuch a ting!\nWe were...um...Honey, tell him what were were doing.\nProfessor Andrew Reactor:\nWe just stayed in..uh...planning.\nWe're going to visit a museum soon\nand we just wanted the visit to be perfect.\nWe don't have anyone to vouch for us, but come on,\nI wouldn't be so petty as to steal your thingamabob out of spite!"
	art_inquiry = "The art museum? I love that place!"
	gtg = "Our apologise. A matter arose. We must depart rapidment!"

	Says = Hash[
		"" => overhear,
		"..." => isbadspy,
		arebadspy => amnotbadspy,
		greeting1 => regreeting,
		greeting2 => regreeting,
		greeting3 => regreeting,
		greeting4 => regreeting,
		ask_alibi1 => alibi,
		ask_alibi2 => alibi,
		ask_alibi3 => alibi,
		ask_alibi4 => alibi,
		art_inquiry => gtg,
		"Oh. Goodbye?" => 0
	]
	Hears = Hash[
		overhear => ["..."],
		isbadspy => [arebadspy, greeting1],
		amnotbadspy => [greeting1, greeting2, greeting3, greeting4],
		regreeting => [ask_alibi1, ask_alibi2, ask_alibi3, ask_alibi4],
		alibi => [art_inquiry],
		gtg => ["Oh. Goodbye?"]
	]
end