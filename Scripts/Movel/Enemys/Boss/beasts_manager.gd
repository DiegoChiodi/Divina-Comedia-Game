extends Node2D
class_name BeastsManager

var target_rotation := self.rotation_degrees
var trade_delay : float = 1.0
var trade_wait : float = 2.0

var attack_delay : float = 0.8;
var attack_wait : float = 0.0

@onready var panther : Panther = $panther
var lion : LionMain = LionMain.new()
@onready var mar_lion : Marker2D = $mar_lion
@onready var wolf : Wolf = $wolf
@onready var mar_ambush_r : Marker2D = $mar_ambush_r
@onready var mar_ambush_l : Marker2D = $mar_ambush_l
@onready var mar_relax_r : Marker2D = $mar_relax_r
@onready var mar_relax_l : Marker2D = $mar_relax_l

@onready var beasts : Array[BeastBase] = [self.panther, self.lion, self.wolf]

func _ready() -> void:
	self.add_child(self.lion)
	for beast in self.beasts:
		beast.setup(self, self.mar_ambush_r, self.mar_ambush_l, self.mar_relax_r, self.mar_relax_l)
	self.beasts[0].start_attack()
	self.lion.global_position = self.mar_lion.global_position

func _process(_delta : float):
	self.trading_beast(_delta)
	if self.attack_wait < self.attack_delay:
		self.attack_wait += _delta
	else:
		self.beasts[0].attacking(_delta)
	self.mar_ambush_l.global_rotation = 0
	self.mar_ambush_r.global_rotation = 0
	self.mar_relax_l.global_rotation = 0
	self.mar_relax_r.global_rotation = 0

func trading_beast(_delta : float) -> void:
	self.rotation = lerp_angle(self.rotation, deg_to_rad(self.target_rotation), _delta * 2.5)

func trading() -> void:
	var next_beast_dir : bool = randi() % 2 == 0
	self.beasts[0].attack_actual = 0
	if next_beast_dir:
		self.target_rotation += 120.0
		var first = beasts.pop_front()
		beasts.append(first)
	else:
		self.target_rotation -= 120.0
		var last = beasts.pop_back()
		beasts.insert(0, last)
	self.attack_wait = 0.0
	beasts[0].start_attack()
	
	
