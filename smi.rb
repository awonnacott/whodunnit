require 'wx'
module SMI # Simple Menu Interface
	def smi(title, message, options)
		dialog = Wx::SingleChoiceDialog.new(nil, message, title, options, Wx::DEFAULT_DIALOG_STYLE|Wx::RESIZE_BORDER|Wx::OK|Wx::CANCEL)
		case dialog.show_modal
		when Wx::ID_OK
			return dialog.get_selection
		when Wx::ID_CANCEL
			return -1
		end
	end
	def sni(title, message) # Simple Notification Interface
		dialog = Wx::MessageDialog.new(nil, message, title, Wx::DEFAULT_DIALOG_STYLE|Wx::RESIZE_BORDER|Wx::OK|Wx::CANCEL)
		return dialog.show_modal
	end
	def smi_string(title, message, options)
		dialog = Wx::SingleChoiceDialog.new(nil, message, title, options, Wx::DEFAULT_DIALOG_STYLE|Wx::RESIZE_BORDER|Wx::OK|Wx::CANCEL)
		case dialog.show_modal
		when Wx::ID_OK
			return dialog.get_string_selection
		when Wx::ID_CANCEL
			return nil
		end
	end
	def conversation(title, npcsay, playersay)
		response = npcsay[""]
		voiced = []
		until response == 0 || response.nil? do
			selection = smi_string(title, response, playersay[response])
			voiced << selection # the selection the player just made
			response = npcsay[selection]
		end
		return voiced
		# voiced.include? nil means that the player closed by cancelling
	end
end