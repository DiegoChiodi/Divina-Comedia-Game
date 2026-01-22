extends Area2D
class_name WarningTower
var seeingPlayer : bool = false

func detectPlayer() -> void:
	if self.seeingPlayer:
		return

	self.seeingPlayer = true
	
	var areas := self.get_overlapping_areas()

	for area in areas:
		var parent := area.get_parent()
		if parent != null and parent != self and parent is Enemy:
			parent.detectPlayer()
		elif area is WarningTower:
			area.detectPlayer()
