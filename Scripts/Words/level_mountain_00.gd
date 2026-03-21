extends Level
class_name Level_Moutain_00

const shadow_path : String = "res://Scene/Enemys/shadow_enemy.tscn"
const shield_path : String = "res://Scene/Enemys/shieldEnemy.tscn"
const ranged_path : String = "res://Scene/Enemys/rangeEnemy.tscn"
const confused_path : String = "res://Scene/Enemys/confuseEnemy.tscn"

const beasts : String = "res://Scene/Enemys/Beasts/beasts.tscn"
var beasts_ins : BeastsManager = load(self.beasts).instantiate()

var in_ascend_quest : bool = false

func _process(_delta: float) -> void:
	if game_manager.player != null and quest_manager.current_quest is QuestMountain:
		game_manager.ui.clr_shadow.color.a = game_manager.player.position.y / self.map.roomSize.y - 100.0 / 255.0
	if self.in_ascend_quest:
		self.beasts_ins.global_position.x = lerp(self.beasts_ins.global_position.x, game_manager.camera.global_position.x, 0.5 * _delta)
		self.beasts_ins.global_position.y = lerp(self.beasts_ins.global_position.y, game_manager.camera.global_position.y - 600, 3.0 * _delta)
		
		

func load_pt(pt : int) -> void:
	var pt_node := self.get_node('pt_' + str(pt))
	unload(pt)
	for children in pt_node.get_children(false):
		if children.is_in_group('ranged'):
			var ranged : RangedEnemy = load(self.ranged_path).instantiate()
			ranged.position = children.position
			self.add_child(ranged)
		elif children.is_in_group('shadow'):
			var shadow : ShadowEnemy = load(self.shadow_path).instantiate()
			shadow.position = children.position
			self.add_child(shadow)
		elif children.is_in_group('confused'):
			var confused : ConfuseEnemy = load(self.confused_path).instantiate()
			confused.position = children.position
			self.add_child(confused)
		elif children.is_in_group('shield'):
			var shield : ShieldEnemy = load(self.shield_path).instantiate()
			shield.position = children.position
			self.add_child(shield)
	


func unload(pt : int) -> void:
	var pt_node = get_node('pt_' + str(pt)) 
	for children in pt_node.get_children(false):
		if children is Enemy:
			children.queue_free()

func init_quest_descend () -> void:
	self.beasts_ins.position = game_manager.player.position
	for i in self.beasts_ins.beasts:
		i.life = 100000.0
	self.add_child(self.beasts_ins)
	self.in_ascend_quest = true
	game_manager.camera.zoomTarget *= 0.8
