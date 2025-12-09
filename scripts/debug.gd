extends Node

## Print info messages to the console for debugging purposes. Only appears if verbose logging is enabled.
func print_info(message: String) -> void:
	if Settings.info_logs_enabled:
		print_verbose("[INFO]: %s" % message)

	var stack = get_stack()
	stack.pop_front() # Remove this function from the stack trace
	if Settings.info_logs_stack_enabled:
		for frame in stack:
			print_verbose("    at %s:%d in %s()" % [frame["source"], frame["line"], frame["function"]])
	else:
		print_verbose("    at %s:%d in %s()" % [stack[0]["source"], stack[0]["line"], stack[0]["function"]])
