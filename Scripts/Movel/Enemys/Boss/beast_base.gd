extends Node2D
class_name BeastBase

var beast_manager : BeastsManager
var attack_delay : float = 2.0
var attack_wait : float = 0.0

var mar_ambush_r : Marker2D
var mar_ambush_l : Marker2D
var mar_relax_r : Marker2D
var mar_relax_l : Marker2D

var invencible : bool = false
var invencibleDelay : float = 0.4
var invencibleWait : float = self.invencibleDelay

var damageFlashDelay : float = 0.5
const DESFREEZEFLASH : float = 0.1
var damageFlashWait : float = 100.0 #Alto para n começar piscando já que não tem bool controlando
const NEUTRALIZATINGDELAY : float = 1.0 
var neutralizingWait : float = self.NEUTRALIZATINGDELAY

var in_attack : bool = false
var life : int = 200

func setup(_beast_manager : BeastsManager, _mar_ambush_r : Marker2D, _mar_ambush_l : Marker2D, _mar_relax_r : Marker2D, _mar_relax_l : Marker2D) -> void:
	self.beast_manager = _beast_manager
	self.mar_ambush_r = _mar_ambush_r
	self.mar_ambush_l = _mar_ambush_l
	self.mar_relax_l = _mar_relax_l
	self.mar_relax_r = _mar_relax_r

func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.global_rotation = 0
	
	if self.damageFlashWait < self.damageFlashDelay:
		self.damageFlashWait += _delta
		damageFlashing(_delta)
	elif self.neutralizingWait < self.NEUTRALIZATINGDELAY:
		stopFlashing(_delta)
		self.neutralizingWait += _delta
		
func start_attack () -> void:
	self.in_attack = true

func attacking(_delta : float) -> void:
	if self.attack_wait < self.attack_delay:
		self.attack_wait += _delta 
		attack_process(_delta)
	else:
		self.beast_manager.trading()
		self.attack_wait = 0.0
		self.in_attack = false

func attack_process(_delta : float) -> void:
	pass

func _on_are_hb_take_damage_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		self.life -= game_manager.player.damage
		self.damageFlashWait = 0.0

func damageFlashing(_delta : float) -> void:
	if self.damageFlashWait < self.DESFREEZEFLASH:
		self.modulate = Color.RED
	else:
		self.modulate = self.modulate.lerp(Color.WHITE, _delta * 5)
	self.neutralizingWait = 0.0

func stopFlashing(_delta : float) -> void:
	self.modulate = self.modulate.lerp(Color.WHITE, _delta * 10)
