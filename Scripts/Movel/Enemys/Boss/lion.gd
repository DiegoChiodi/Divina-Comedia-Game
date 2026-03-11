extends Node2D
class_name Lion

var dir_dash : Vector2 = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.dir_dash != Vector2.ZERO:
		self.rotation = Vector2.ZERO.angle_to_point(self.dir_dash) + deg_to_rad(90)

func set_pos(pos : Vector2) -> void:
	self.global_position = pos

func init_dir_dash() -> void:
	self.dir_dash = self.global_position.direction_to(game_manager.player.global_position)
	print(self.dir_dash)


func _on_are_hb_take_damage_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
