extends BeastBase
class_name Panther

@onready var hand_l : PantherHand = $hand_left
@onready var hand_r : PantherHand = $hand_right

func _ready() -> void:
	super._ready()
	self.attack_delay = 1000.0

func setup(_beast_manager : BeastsManager, _mar_ambush_r : Marker2D, _mar_ambush_l : Marker2D, _mar_relax_r : Marker2D, _mar_relax_l : Marker2D) -> void:
	super.setup(_beast_manager, _mar_ambush_r, _mar_ambush_l, _mar_relax_r, _mar_relax_l)
	var relax_l = self.mar_relax_l.global_position - self.global_position
	var relax_r = self.mar_relax_r.global_position - self.global_position
	self.hand_l.setup(self.mar_ambush_l.global_position, relax_l)
	self.hand_r.setup(self.mar_ambush_r.global_position, relax_r)
	

func _process(_delta: float) -> void:
	super._process(_delta)
	if !self.in_attack:
		self.hand_l.ending_attack(_delta)
		self.hand_r.ending_attack(_delta)
	
func attack_process(_delta : float) -> void:
	self.hand_r.in_attack(_delta)
	self.hand_l.in_attack(_delta)
	
	if self.hand_l.punchs == 0 and self.hand_r.punchs == 0:
		self.beast_manager.trading()
		self.hand_l.punchs = 3
		self.hand_r.punchs = 3
