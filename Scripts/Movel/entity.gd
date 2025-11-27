extends Movel
class_name Entity

var lifeMax : float = 100.0
var life : float = lifeMax
var damage : float = 20.0

var invencible : bool = false
const INVENCIBLE : float = 0.3
var invencibleDelay : float = 0.0
var invencibleWait : float = self.invencibleDelay

var groupRival : String = ""
var colRival :  = false
var bodysCol : Array[Entity] = []
var iniScale : Vector2 = scale

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	groupsAdd()

func _process(delta: float) -> void:
	super._process(delta)
	
	if self.invencible:
		if invencibleWait > invencibleDelay:
			invencibleWait -= delta
		else:
			invencible = false

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	checkColliding()

func collidingRival(_body) -> void:
	self.takeAttack((self.position - _body.position).normalized(), _body.damage, _body.speed)
	_body.AttackSucess(self)

func checkColliding() -> void:
	if !bodysCol.is_empty():
		for _body in bodysCol:
			if checkCollidingRival(_body):
				collidingRival(_body)
			else:
				collidingRandom(_body)
	
func collidingRandom(_body) -> void:
	self.takeImpulseDir((self.position - _body.position).normalized(), self.speed * 3)
	_body.takeImpulseDir((_body.position - self.position).normalized(), self.speed * 3)

func checkCollidingRival(_body) -> bool:
	return _body != null and _body.is_in_group(groupRival)

func AttackSucess(_body : CharacterBody2D) -> void:
	if _body != null:
		self.takeImpulseDir((self.position - _body.position).normalized(), self.speed)

func groupsAdd() -> void:
	pass

func takeDamage(_damage : float) -> void:
	if !self.invencible:
		self.life -= _damage
		invencibilityActivate(INVENCIBLE)
		self.scale -= self.iniScale * 0.1
		if self.life <= 0:
			self.queue_free()

func takeAttack(_impulseDir : Vector2, _damage : float = 0.0, _impulseSpeed : float = 2000):
	self.takeDamage(_damage)
	self.takeImpulseDir(_impulseDir)

func _on_are_hb_take_damage_area_entered(area: Area2D) -> void:
	if area.is_in_group("hbAttack"):
		self.bodysCol.append(area.get_parent())

func _on_are_hb_take_damage_area_exited(area: Area2D) -> void:
	if area.is_in_group("hbAttack"):
		self.bodysCol.erase(area.get_parent())

func dead() -> void:
	pass

func invencibilityActivate(invWait : float) -> void:
	self.invencible = true
	self.invencibleWait = invWait
