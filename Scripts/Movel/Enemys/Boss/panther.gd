extends BeastBase
class_name Panther

@onready var hand_l : PantherHand = $hand_left
@onready var hand_r : PantherHand = $hand_right

func _ready() -> void:
	super._ready()
	self.attack_delay_1 = 10000.0

func setup(_beast_manager : BeastsManager, _mar_ambush_r : Marker2D, _mar_ambush_l : Marker2D) -> void:
	super.setup(_beast_manager, _mar_ambush_r, _mar_ambush_l)
	self.hand_l.setup(self.mar_ambush_l)
	self.hand_r.setup(self.mar_ambush_r)

func _process(_delta: float) -> void:
	super._process(_delta)
	self.attack_actual = 1
	
func in_attack_1 (_delta : float) -> void:
	self.hand_r.in_attack_1(_delta)
	self.hand_l.in_attack_1(_delta)
	
	if self.hand_l.punchs == 0 and self.hand_r.punchs == 0:
		self.beast_manager.trading()
		self.hand_l.punchs = 3
		self.hand_r.punchs = 3
