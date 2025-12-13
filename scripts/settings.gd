extends Node
## Gets project settings as the initial settings for each plan and then allows modification.

var info_logs_enabled: bool
var info_logs_stack_enabled: bool

var max_player_health: int
var total_player_moves: int

var message_win: String
var message_lose: String


func _ready() -> void:
	info_logs_enabled = ProjectSettings.get_setting("custom/debug/info_logs_enabled")
	info_logs_stack_enabled = ProjectSettings.get_setting("custom/debug/info_logs_stack_enabled")

	max_player_health = ProjectSettings.get_setting("custom/game/max_player_health")
	total_player_moves = ProjectSettings.get_setting("custom/game/total_player_moves")

	message_win = ProjectSettings.get_setting("custom/game/message_win")
	message_lose = ProjectSettings.get_setting("custom/game/message_lose")
