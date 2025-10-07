extends Movel
class_name Entity

var lifeMax : float = 100
var life : float = lifeMax
var damage : float = 20

var invencible : bool = false
var invencibleDelay : float = 0.2
var invencibleWait : float = self.invencibleDelay

var groupRival : String = ""
var colRival : bool = false
var rivalId = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	groupsAdd()

func _process(delta: float) -> void:
	super._process(delta)
	if life <= 0:
		self.queue_free()
	
	if self.invencible:
		if invencibleWait < invencibleDelay:
			invencibleWait += delta
		else:
			invencible = false

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	collidingRival()
	
func collidingRival() -> void:
	if colRival:
		self.takeAttack((self.position - self.rivalId.position).normalized() * 3, self.rivalId.damage)

func groupsAdd() -> void:
	pass

func takeDamage(_damage : float) -> void:
	if !invencible:
		life -= damage
		invencible = true
		invencibleWait = 0.0

func takeAttack(_impulse : Vector2, _damage : float):
	super.takeAttack(_impulse, _damage)
	takeDamage(_damage)

func _on_are_hb_take_damage_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group(groupRival) and area.is_in_group("hbAttack"):
		colRival = true
		rivalId = area.get_parent()

func _on_are_hb_take_damage_area_exited(area: Area2D) -> void:
	if area.get_parent().is_in_group(groupRival) and area.is_in_group("hbAttack"):
		colRival = false
		rivalId = null

func dead() -> void:
	pass

func printGrup() -> void:
	print(groupRival)
	print(get_groups())
