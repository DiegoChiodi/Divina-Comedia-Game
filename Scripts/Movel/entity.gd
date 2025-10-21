extends Movel
class_name Entity

var lifeMax : float = 100.0
var life : float = lifeMax
var damage : float = 20.0

var invencible : bool = false
var invencibleDelay : float = 0.2
var invencibleWait : float = self.invencibleDelay

var groupRival : String = ""
var colRival : bool = false
var bodysCol : Array[Entity] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	groupsAdd()

func _process(delta: float) -> void:
	super._process(delta)
	
	if self.invencible:
		if invencibleWait < invencibleDelay:
			invencibleWait += delta
		else:
			invencible = false

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	checkColliding()

func collidingRival(body) -> void:
	self.takeAttack((self.position - body.position).normalized(), body.damage, body.speed)
	body.AttackSucess(self)

func checkColliding() -> void:
	if !bodysCol.is_empty():
		for body in bodysCol:
			if checkCollidingRival(body):
				collidingRival(body)
			else:
				collidingRandom(body)
	
func collidingRandom(body) -> void:
	self.takeImpulseDir((self.position - body.position).normalized(), self.speed * 3)
	body.takeImpulseDir((body.position - self.position).normalized(), self.speed * 3)

func checkCollidingRival(body) -> bool:
	return body != null and body.is_in_group(groupRival)

func AttackSucess(body : CharacterBody2D) -> void:
	if body != null:
		self.takeImpulseDir((self.position - body.position).normalized(), self.speed)

func groupsAdd() -> void:
	pass

func takeDamage(_damage : float) -> void:
	if !invencible:
		life -= _damage
		invencible = true
		invencibleWait = 0.0
		scale -= Vector2(0.15,0.15)
		if life <= 0:
			self.queue_free()

func takeAttack(_impulseDir : Vector2, _damage : float = 0.0, _impulseSpeed : float = 2000):
	takeDamage(_damage)
	takeImpulseDir(_impulseDir)

func _on_are_hb_take_damage_area_entered(area: Area2D) -> void:
	if area.is_in_group("hbAttack"):
		bodysCol.append(area.get_parent())

func _on_are_hb_take_damage_area_exited(area: Area2D) -> void:
	if area.is_in_group("hbAttack"):
		bodysCol.erase(area.get_parent())

func dead() -> void:
	pass

func printGrup() -> void:
	print(groupRival)
	print(get_groups())

func invencibilityActivate() -> void:
	invencible = true
	invencibleWait = 0.0
