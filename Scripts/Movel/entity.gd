extends Movel
class_name Entity

var lifeMax : float = 100.0
var life : float = self.lifeMax
var damage : float = 20.0

var invencible : bool = false
var invencibleDelay : float = 0.4
var invencibleWait : float = self.invencibleDelay

var damageFlashDelay : float = 0.5
const DESFREEZEFLASH : float = 0.1
var damageFlashWait : float = 100.0 #Alto para n começar piscando já que não tem bool controlando
const NEUTRALIZATINGDELAY : float = 1.0 
var neutralizingWait : float = self.NEUTRALIZATINGDELAY

var groupRival : String = ""
var colRival :  = false
var bodysCol : Array[Entity] = []

var is_dead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	groupsAdd()

func _process(_delta: float) -> void:
	super._process(_delta)
	
	if self.invencible:
		if self.invencibleWait < self.invencibleDelay:
			self.invencibleWait += _delta
		else:
			self.invencible = false
	
	if self.damageFlashWait < self.damageFlashDelay:
		self.damageFlashWait += _delta
		damageFlashing(_delta)
	elif self.neutralizingWait < self.NEUTRALIZATINGDELAY:
		stopFlashing(_delta)
		self.neutralizingWait += _delta
	
	if self.is_dead:
		self.dying(_delta)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	checkColliding()

func collidingRival(_body) -> void:
	if !self.invencible:
		_body.AttackSucess(self)
	self.takeAttack((self.position - _body.position).normalized(), _body.damage, _body.speed * 3)

func checkColliding() -> void:
	#Entrei na htbox de ataque de alguém
	if !self.bodysCol.is_empty():
		for _body in self.bodysCol:
			if _body.is_in_group(self.groupRival):
				collidingRival(_body)
			elif self.is_in_group("Object"):
				if !self.invencible:
					_body.AttackSucess(self)
				self.takeAttack((self.position - _body.position).normalized(), _body.damage, _body.speed)

func AttackSucess(_body : CharacterBody2D) -> void:
	self.takeImpulse((self.position - _body.position).normalized(), self.speed)

func groupsAdd() -> void:
	pass

func takeDamage(_damage : float) -> void:
	self.life -= _damage
	invencibilityActivate()
	if self.life <= 0:
		self.dead()

func takeAttack(_impulseDir : Vector2, _damage : float = 0.0, _impulseSpeed : float = 1000) -> void:
	if !self.invencible:
		self.takeDamage(_damage)

	self.takeImpulse(_impulseDir, _impulseSpeed)

func _on_are_hb_take_damage_area_entered(area: Area2D) -> void:
	var parent := area.get_parent()
	if area.is_in_group("hbAttack") and parent is Entity:
		self.bodysCol.append(parent)
	elif parent.is_in_group('intangibleDash'):
		dash_intangible_col()
	elif parent is Projectile:
		colliding_projectile(parent)


func _on_are_hb_take_damage_area_exited(area: Area2D) -> void:
	var parent := area.get_parent()
	if area.is_in_group("hbAttack") and parent is Entity:
		self.bodysCol.erase(area.get_parent())

func dead() -> void:
	self.is_dead = true
	game_manager.entityDead(self)

func invencibilityActivate(_flash : bool = true, _invencible_wait : float = 0.0) -> void:
	self.invencible = true
	self.invencibleWait = _invencible_wait
	if _flash:
		self.damageFlashWait = 0.0

func damageFlashing(_delta : float) -> void:
	if self.damageFlashWait < self.DESFREEZEFLASH:
		self.modulate = Color.RED
	else:
		self.modulate = self.modulate.lerp(Color.WHITE, _delta * 5)
	self.neutralizingWait = 0.0

func stopFlashing(_delta : float) -> void:
	self.modulate = self.modulate.lerp(Color.WHITE, _delta * 10)

func dying (_delta : float) -> void:
	self.queue_free()

func dash_intangible_col() -> void:
	self.velocity *= -4

func colliding_projectile(projectile : Projectile) -> void:
	if !self.invencible:
		projectile.self_destruction()
		self.takeAttack((self.position - projectile.position).normalized(), projectile.damage, projectile.speed * 5)
