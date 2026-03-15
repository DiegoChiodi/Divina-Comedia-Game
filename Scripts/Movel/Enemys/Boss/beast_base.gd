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
const INVENCIBLE_DELAY : float = 0.3
var invencibleWait : float = self.INVENCIBLE_DELAY

var damageFlashDelay : float = 0.5
const DESFREEZEFLASH : float = 0.1
var damageFlashWait : float = 100.0 #Alto para n começar piscando já que não tem bool controlando
const NEUTRALIZATINGDELAY : float = 1.0 
var neutralizingWait : float = self.NEUTRALIZATINGDELAY

var in_attack : bool = false
var life : float = 200
var rotation_personality : float = 0.0
var is_dead : bool = false
var is_dying : bool = false

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
	self.global_rotation_degrees = rotation_personality
	
	if self.invencibleWait < self.INVENCIBLE_DELAY:
		self.invencibleWait += _delta
	else:
		self.invencible = false
	
	if self.damageFlashWait < self.damageFlashDelay:
		self.damageFlashWait += _delta
		damageFlashing(_delta)
	elif self.neutralizingWait < self.NEUTRALIZATINGDELAY:
		stopFlashing(_delta)
		self.neutralizingWait += _delta
		
func start_attack () -> void:
	self.in_attack = true
	if self.is_dying:
		self.is_dead = true


func attacking(_delta : float) -> void:
	if self.attack_wait < self.attack_delay:
		self.attack_wait += _delta 
		if self.is_dead:
			self.beast_manager.trading()
		elif self.is_dying:
			self.dying(_delta)
		else:
			attack_process(_delta)
	else:
		self.beast_manager.trading()
		self.attack_wait = 0.0
		self.in_attack = false

func attack_process(_delta : float) -> void:
	pass

func _on_are_hb_take_damage_area_entered(area: Area2D) -> void:
	self.check_damage(area)

func take_damage() -> void:
	self.life -= int(game_manager.player.damage)
	self.damageFlashWait = 0.0
	
	self.invencible = true
	self.invencibleWait = 0.0
	if self.life <= 0:
		self.to_die()

func damageFlashing(_delta : float) -> void:
	if self.damageFlashWait < self.DESFREEZEFLASH:
		self.modulate = Color.RED
	else:
		self.modulate = self.modulate.lerp(Color.WHITE, _delta * 5)
	self.neutralizingWait = 0.0

func stopFlashing(_delta : float) -> void:
	self.modulate = self.modulate.lerp(Color.WHITE, _delta * 10)

func to_die() -> void:
	self.beast_manager.beast_dead(self)
	game_manager.entityDead(self)
	if !self.is_dying: 
		self.is_dying = true
		self.attack_delay = 1.5
		self.attack_wait = 0.0

func dying(_delta : float) -> void:
	self.return_normal(_delta)

func return_normal(_delta : float) -> void:
	pass

func check_damage(_area : Area2D) -> void:
	if _area.get_parent() is Player and _area.is_in_group("hbAttack") and !self.invencible:
		self.take_damage()
