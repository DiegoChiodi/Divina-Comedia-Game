extends BeastBase
class_name Panther

@onready var hand_l : PantherHand = $hand_left
@onready var hand_r : PantherHand = $hand_right

func _ready() -> void:
	super._ready()
	self.attack_delay_1 = 10000.0

func setup(_beast_manager : BeastsManager, _mar_ambush_r : Marker2D, _mar_ambush_l : Marker2D, _mar_relax_r : Marker2D, _mar_relax_l : Marker2D) -> void:
	super.setup(_beast_manager, _mar_ambush_r, _mar_ambush_l, _mar_relax_r, _mar_relax_l)
	var relax_l = self.mar_relax_l.global_position - self.global_position
	var relax_r = self.mar_relax_r.global_position - self.global_position
	self.hand_l.setup(self.mar_ambush_l.global_position, relax_l)
	self.hand_r.setup(self.mar_ambush_r.global_position, relax_r)
	

func _process(_delta: float) -> void:
	super._process(_delta)
	if self.attack_actual == 0:
		self.hand_l.end_attack(_delta)
		self.hand_r.end_attack(_delta)
	
func in_attack_1 (_delta : float) -> void:
	self.hand_r.in_attack_1(_delta)
	self.hand_l.in_attack_1(_delta)
	
	if self.hand_l.punchs == 0 and self.hand_r.punchs == 0:
		self.beast_manager.trading()
		self.hand_l.punchs = 3
		self.hand_r.punchs = 3
