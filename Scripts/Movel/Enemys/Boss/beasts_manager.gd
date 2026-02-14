extends Node2D
class_name BeastsManager

var target_rotation := self.rotation_degrees
var trade_delay : float = 1.0
var trade_wait : float = 2.0

@onready var panther : Panther = $panther
@onready var lion : Lion = $lion
@onready var wolf : Wolf = $wolf
@onready var mar_ambush_r : Marker2D = $mar_ambush_r
@onready var mar_ambush_l : Marker2D = $mar_ambush_l

@onready var beasts : Array[BeastBase] = [self.panther, self.lion, self.wolf]

func _ready() -> void:
	for beast in self.beasts:
		beast.setup(self, mar_ambush_r, mar_ambush_l)
	self.beasts[0].start_attack()

func _process(_delta : float):
	self.trading_beast(_delta)
	self.beasts[0].attacking(_delta)
	self.mar_ambush_l.global_rotation = 0
	self.mar_ambush_r.global_rotation = 0

func trading_beast(_delta : float) -> void:
	self.rotation = lerp_angle(self.rotation, deg_to_rad(self.target_rotation), _delta * 2)

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
	
