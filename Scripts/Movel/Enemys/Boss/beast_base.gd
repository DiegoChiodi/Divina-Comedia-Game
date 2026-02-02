extends Node2D
class_name BeastBase

var beast_manager : BeastsManager
var attack_delay_1 : float = 3.0
var attack_wait_1 : float = 0.0

var attack_delay_2 : float = 2.0
var attack_wait_2 : float = 0.0

var attack_actual : int = 1
var attacks_pos : int = 2

func setup(_beast_manager : BeastsManager) -> void:
	self.beast_manager = _beast_manager

func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.global_rotation = 0

func start_attack () -> void:
	self.attack_actual = randi() % self.attacks_pos + 1

func attacking(_delta : float) -> void:
	match self.attack_actual:
		1:
			if self.attack_wait_1 < self.attack_delay_1:
				self.attack_wait_1 += _delta 
				in_attack_1(_delta)
			else:
				self.beast_manager.trading()
				self.attack_wait_1 = 0.0
		
		2:
			if self.attack_wait_2 < self.attack_delay_2:
				self.attack_wait_2 += _delta 
				in_attack_2(_delta)
			else:
				self.beast_manager.trading()
				self.attack_wait_2 = 0.0
		

func in_attack_1 (_delta : float) -> void:
	pass

func in_attack_2 (_delta : float) -> void:
	pass
