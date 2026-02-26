extends Node2D
class_name PantherHand

var dir : Vector2 = Vector2.ZERO
var attack_speed : float = 200.0
var attack_speed_fix : float = 100.0
var attack_speed_target : float = 1800.0
var punchs : int = 2
var end_attack_1 : bool = false
var attack_cou : float = 0.0
var attack_cou_fix : float = 0.0
var pos_ambush : Vector2
var mar_relax : Vector2


func setup(_pos_ambush : Vector2, _mar_relax : Vector2):
	self.pos_ambush = _pos_ambush
	self.mar_relax = _mar_relax
	
func in_attack_1 (_delta : float) -> void:
	if self.punchs > 0:
		if self.attack_cou < 0.8:
			self.global_position = self.global_position.lerp(self.pos_ambush, 3 * _delta)
			self.scale = self.scale.lerp(Vector2.ONE * 2.5, 3 * _delta)
			self.attack_speed = self.attack_speed_fix
			if game_manager.player != null:
				self.dir = (game_manager.player.global_position - self.global_position).normalized()
		elif !self.end_attack_1:
			self.attack_speed = lerp(self.attack_speed, self.attack_speed_target, 10 * _delta)
			self.position += self.attack_speed * _delta * self.dir
		else:
			self.global_position = self.global_position.lerp(self.pos_ambush, 3 * _delta)
			if self.attack_cou_fix + 1.0 < self.attack_cou:
				self.attack_cou = 0.0
				self.punchs -= 1
				self.end_attack_1 = false
		
		if not Rect2(Vector2.ZERO, global.roomLimit).has_point(self.global_position):
			self.end_attack_1 = true
			self.attack_cou_fix = self.attack_cou
		
		self.attack_cou += _delta

func end_attack(_delta : float) -> void:
	self.position = self.position.lerp(self.mar_relax, 3 * _delta)
	self.scale = self.scale.lerp(Vector2.ONE, 3 * _delta)
	self.attack_speed = self.attack_speed_fix
