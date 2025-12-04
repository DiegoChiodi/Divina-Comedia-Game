extends Movel
class_name Entity

var lifeMax : float = 100.0
var life : float = lifeMax
var damage : float = 20.0

var invencible : bool = false
var invencibleDelay : float = 0.4
var invencibleWait : float = 0.0

var damageFlash : bool = false
const DAMAGEFLASH : float = 0.5
const DESFREEZEFLASH : float = 0.1
var damageFlashWait : float = self.DAMAGEFLASH

var groupRival : String = ""
var colRival :  = false
var bodysCol : Array[Entity] = []
var iniScale : Vector2 = scale
var loseScale : float = 0.1



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	groupsAdd()

func _process(delta: float) -> void:
	super._process(delta)
	
	if self.invencible:
		if self.invencibleWait < self.invencibleDelay:
			self.invencibleWait += delta
		else:
			self.invencible = false
	
	if self.damageFlashWait < self.DAMAGEFLASH:
		self.damageFlashWait += delta
		if self.damageFlashWait < self.DESFREEZEFLASH:
			self.modulate = Color.RED
		else:
			self.modulate = self.modulate.lerp(Color.WHITE, delta * 5)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	checkColliding()

func collidingRival(_body) -> void:
	if !self.invencible:
		_body.AttackSucess(self)

	self.takeAttack((self.position - _body.position).normalized(), _body.damage, _body.speed)

func checkColliding() -> void:
	#Entrei na htbox de ataque de alguém
	if !self.bodysCol.is_empty():
		for _body in self.bodysCol:
			if _body.is_in_group(self.groupRival):
				collidingRival(_body)
			elif self.is_in_group("Object"):
					self.takeAttack((self.position - _body.position).normalized(), _body.damage, _body.speed)

func AttackSucess(_body : CharacterBody2D) -> void:
	self.takeImpulseDir((self.position - _body.position).normalized(), self.speed)

func groupsAdd() -> void:
	pass

func takeDamage(_damage : float) -> void:
	self.life -= _damage
	invencibilityActivate()
	self.scale -= self.iniScale * self.loseScale
	if self.life <= 0:
		self.dead()

func takeAttack(_impulseDir : Vector2, _damage : float = 0.0, _impulseSpeed : float = 3000):
	if !self.invencible:
		self.takeDamage(_damage)
	self.takeImpulseDir(_impulseDir)

func _on_are_hb_take_damage_area_entered(area: Area2D) -> void:
	if area.is_in_group("hbAttack"):
		self.bodysCol.append(area.get_parent())

func _on_are_hb_take_damage_area_exited(area: Area2D) -> void:
	if area.is_in_group("hbAttack"):
		self.bodysCol.erase(area.get_parent())

func dead() -> void:
	game_manager.entityDead(self)
	self.queue_free()

func invencibilityActivate() -> void:
	self.invencible = true
	self.invencibleWait = 0.0
	self.damageFlashWait = 0.0
