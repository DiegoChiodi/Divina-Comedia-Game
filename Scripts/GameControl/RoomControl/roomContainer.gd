extends Node2D
class_name RoomContainer

var currentRoom : Level
var previousMapId : int = -1
var previousCurrentRoomTemp : int

var inInit : bool = true
var restart : bool = false
var tentativa : int = 0

func destroy_room() -> void:
	self.currentRoom.call_deferred("queue_free")

func load_room(path) -> void:
	#Guarda o id da cena atual que está preste a ser modificada antes que modifique
	if self.currentRoom != null:
		self.previousCurrentRoomTemp = self.currentRoom.map.id
	
	#Instancia a scena atual, configura e adiciona
	self.currentRoom = load(path).instantiate()
	self.currentRoom.setup()
	self.add_child(self.currentRoom)
	
	if self.inInit: #Inicío do jogo, previousMapId = null
		posPlayerSpawn()
		self.inInit = false
		return
	
	#Se o jogo acabou de iniciar e previousMapId acabou de ser criado
	#Estou no mapa inicial e acabei de vir dele
	if self.restart and self.previousMapId == -1 and self.currentRoom.map.get_node("player_spawn") != null:
		posPlayerSpawn()
		self.restart = false
		return
	
	#Para reiniciar no marker certo da scena anterior
	if !self.restart:
		self.previousMapId = previousCurrentRoomTemp
	posPlayerPreviousRomm()
	self.restart = false

func change_room(path) -> void:
	destroy_room()
	load_room(path)

func restartRoom(path: String) -> void:
	self.restart = true
	change_room(path)

func posPlayerSpawn() -> void:
	var mark_position = self.currentRoom.map.get_node("player_spawn").position
	game_manager.player.set_deferred("position", mark_position)
	game_manager.camera.setPosition(mark_position)

func posPlayerPreviousRomm() -> void:
	var marker_name = game_manager.marker_names[previousMapId]
	var marker : Marker2D = self.currentRoom.map.get_node(marker_name)
	var mark_position = marker.position
	game_manager.player.set_deferred("position", mark_position)
	game_manager.camera.setPosition(mark_position)
