extends BeastBase
class_name Panther

@onready var path_left_hand : Path2D = $path_left_hand
@onready var path_right_hand : Path2D = $path_right_hand

func _process(_delta: float) -> void:
	super._process(_delta)
	self.attack_wait_1 = 0.0
	self.attack_wait_2 = 0.0

func in_attack_1 (_delta : float) -> void:
	self.path_left_hand.curve.set_point_in(3,game_manager.player.global_position)
	self.path_right_hand.curve.set_point_in(3,game_manager.player.global_position)
