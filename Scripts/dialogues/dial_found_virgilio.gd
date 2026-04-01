extends DialogueBase
class_name DiaFoundVirgilio

var virgilio : Virgilio = preload("res://Scene/virgilio.tscn").instantiate()
var zoom_normals : Vector2 = game_manager.camera.zoom

func _ready() -> void:
	super._ready()

func set_speechs() -> void:
	self.speechs = [
	Speech.new(D, "A saída… estava tão perto…"),
	Speech.new(D, "Por que fui impedido?"),
	Speech.new(D, "Estou… preso aqui."),

	Speech.new(D, "Isso não faz sentido…"),
	Speech.new(D, "Nada faz sentido."),

	Speech.new(V, "", Speech.Event.SPAWN_ENTITY, [self.virgilio, game_manager.roomContainer.currentRoom.spawn_virg.global_position]),

	Speech.new(G, "Faz mais sentido do que você imagina."),

	Speech.new(D, "Quem está aí?"),
	Speech.new(D, "Mostre-se!"),

	Speech.new(V, "", Speech.Event.MOVE_ENTITY, [game_manager.player, game_manager.roomContainer.currentRoom.spawn_virg.global_position + Vector2.LEFT * 530]),
	Speech.new(V, "", Speech.Event.CAM_ZOOM, [1.6]),
	
	Speech.new(G, "Alguém que conhece este caminho."),
	Speech.new(G, "E o seu destino."),

	Speech.new(D, "Se conhece o caminho… me tire daqui."),

	Speech.new(G, "Não por onde você tentou."),
	Speech.new(G, "A subida está bloqueada para você."),

	Speech.new(D, "Então não há saída?"),

	Speech.new(G, "Há."),
	Speech.new(G, "Mas não acima."),

	Speech.new(G, "Você deve descer… antes de subir."),
	Speech.new(G, "Atravessar aquilo que teme."),

	Speech.new(D, "Descer… para onde?"),

	Speech.new(G, "Para onde todos evitam olhar."),

	Speech.new(D, "Por que eu?"),

	Speech.new(G, "Porque você foi chamado."),

	Speech.new(D, "Chamado… por quem?"),

	Speech.new(G, "Alguém que ainda acredita em você."),
	Speech.new(G, "Uma alma do alto viu sua queda."),
	Speech.new(G, "E recusou deixá-lo aqui."),
	Speech.new(G, "Ela pediu que eu viesse."),

	Speech.new(D, "Eu não sou forte o suficiente."),
	Speech.new(D, "Você viu o que me fez recuar."),

	Speech.new(G, "Você recuou… mas não fugiu."),
	Speech.new(G, "Isso já o diferencia."),

	Speech.new(G, "O medo não é o fim."),
	Speech.new(G, "É o começo."),

	Speech.new(D, "E se eu falhar?"),

	Speech.new(G, "Então falhará avançando."),
	Speech.new(G, "Não parado."),

	Speech.new(G, "Mas você não está sozinho."),

	Speech.new(G, "Venha."),
	Speech.new(G, "O caminho começa… aqui."),

	Speech.new(D, "…Certo."),
	Speech.new(D, "Eu vou.")
	]

func event_control(_delta : float) -> void:
	if self.current_speench >= self.speechs.size():
		return
	var data : Array = speechs[current_speench].data
	match speechs[current_speench].event:
		Speech.Event.MOVE_ENTITY:
			self.per_pass_spreench = self.move_ani_entity_to_point(data[0], data[1])
			if self.per_pass_spreench:
				self.pass_text()
			
		Speech.Event.SPAWN_ENTITY:
			self.spawn_entity(data[0], data[1])
		Speech.Event.CAM_ZOOM:
			self.per_pass_spreench = self.camera_zoom(data[0])
			if self.per_pass_spreench:
				self.pass_text()
		Speech.Event.VOID:
			pass

func move_ani_entity_to_point(entity : AnimationEntity, point : Vector2, stop_marge : float = 50.0) -> bool:
	if abs((entity.global_position - point).length()) > stop_marge:
		entity.direction = entity.global_position.direction_to(point)
		return false
	entity.direction = Vector2.ZERO
	return true

func camera_zoom(zoom : float) -> bool:
	if abs(game_manager.camera.zoomTarget.length() - (self.zoom_normals * zoom).length()) >= 0.1:
		game_manager.camera.zoomTarget = self.zoom_normals * zoom
		game_manager.camera.posComp = Vector2(300.0, 150.0)
	return true

func spawn_entity(entity, pos : Vector2) -> void:
	game_manager.roomContainer.currentRoom.add_child(entity)
	entity.global_position = pos
