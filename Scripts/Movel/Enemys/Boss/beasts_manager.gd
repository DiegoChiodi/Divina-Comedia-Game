extends Node2D
class_name BeastsManager

var target_rotation := self.rotation_degrees + 120.0
var duration := 1.0

@onready var panther : Panther = $panther
@onready var lion : Lion = $lion
@onready var wolf : Wolf = $wolf

@onready var beasts : Array[BeastBase] = [self.panther, self.lion, self.wolf]

func _ready() -> void:
	for beast in beasts:
		beast.setup(self)
	beasts[0].start_attack()

func _process(_delta : float):
	self.beasts[0].attacking(_delta)
	trading_beast(_delta)

func trading_beast(_delta : float) -> void:
	var weight = _delta / self.duration
	self.rotation = lerp_angle(self.rotation, deg_to_rad(self.target_rotation), weight)

func trading() -> void:
	var next_beast_dir : bool = randi() % 2 == 0
	if next_beast_dir:
		self.target_rotation += 120.0
		var first = beasts.pop_front()
		beasts.append(first)
	else:
		self.target_rotation -= 120.0
		var last = beasts.pop_back()
		beasts.insert(0, last)
	
	beasts[0].start_attack()
	
