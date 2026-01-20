extends Enemy
class_name NavEnemy

func _ready() -> void:
	super._ready()
	self.get_nav_agent()

func get_nav_agent() -> void:
	self.nav_agent = $nav_agent
	
func makepath() -> void:
	var player = game_manager.player
	if player != null and self.nav_agent != null:
		self.nav_agent.target_position = player.global_position

func _on_tim_act_path_timeout() -> void:
	self.makepath()
