require 'wx'
module SMI
	def smi(title, message, options)
		dialog = Wx::SingleChoiceDialog.new(nil, message, title, options, Wx::DEFAULT_DIALOG_STYLE|Wx::RESIZE_BORDER|Wx::OK)
		modal = dialog.show_modal
		return dialog.get_selection
	end
	def smi_string(title, message, options)
		dialog = Wx::SingleChoiceDialog.new(nil, message, title, options, Wx::DEFAULT_DIALOG_STYLE|Wx::RESIZE_BORDER|Wx::OK)
		modal = dialog.show_modal
		return dialog.get_string_selection
	end
	def conversation(prompt, npcsay, playersay)
		response = npcsay[""]
		until response == 0 do
			selection = smi_string(prompt + ": " + response, prompt + ": " + response, playersay[response])
			response = npcsay[selection]
		end
	end
end