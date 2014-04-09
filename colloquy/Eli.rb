module Eli
	ungreeting = "Don't you have the decency not to come around\nat such an early hour?! What do you want?"
	inquiry = "Do you know anything about my missing invention?"
	insult = "No, of course not. I'm surprised someone bothered stealing it.\nYour invention couldn't possibly have value to anyone."
	incrimination = "No. Look, I didn't sleep particularly well last night\nand I'd like you to just go away now."
	departure1 = "Do you have an alabi for last night?"
	departure2 = "I wonder if you do have it. Goodbye."
	Says = Hash[
		"" => ungreeting,
		inquiry => insult,
		departure1 => incrimination,
		departure2 => 0
	]
	Hears = Hash[
		ungreeting => [inquiry],
		insult => [departure1, departure2],
		incrimination => [departure2]
	]
end
