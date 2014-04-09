module Hospital
	Says = Hash[
		"" => "Hello, how may I help you?",
		"Hello. I would like to ask weather /na Mr. Graham Green was working last night?" => "Yes sir, he was. He had the night shift"
		"All night? No breaks?" => "Yes sir, he was here the entire night."
		"Thank you very much. Goodbye." => 0]
	Hears = Hash[
		"Hello, how may I help you?" => ["Hello. I would like to ask weather /na Mr. Graham Green was working last night?","goodbye"]
		"Yes sir, he was. He had the night shift" => "All night? No breaks?"
		"Yes sir, he was here the entire night." => "Thank you very much. Goodbye."
	]
end
