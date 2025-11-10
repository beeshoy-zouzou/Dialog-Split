extends Node



onready var key_message = $KeyMessage/KeyMessage
onready var collectible = $Collectible/Collectible
onready var old_man_npc = $NPC1/OldManNpc
onready var map = $Map/Map



var has_key = false


func _ready():
	collectible.connect("key_collected", self, "_on_key_collected")
	DialogSystem.connect("dialog_ended", self, "_on_first_dialog_finished")

	# Connect visibility signals from the forest background
	
	
	
#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		var sfx = tilemap.get_node("Background/DarkForestSound")
#		if sfx:
#			sfx.play()
#			print("Trying to play forest sound manually")

#func _process(delta):
#	if not forest_active:
#		return
#
#	var background = tilemap.get_node("Background")
#	if not background:
#		return
#
#	var forest_sfx = background.get_node("DarkForestSound")
#	if not forest_sfx:
#		return
#
#	var sprite_rect = _get_sprite_global_rect(background)
#
#	var screen_rect = get_viewport().get_visible_rect()
##	print("Visible: ", sprite_rect.intersects(screen_rect))
#	if sprite_rect.intersects(screen_rect):
#		if not forest_sfx.playing:
#			forest_sfx.play()
#	else:
#		if forest_sfx.playing:
#			forest_sfx.stop()
	
func open_chest(show_river := true, show_key := true, show_door := true):
	var closed = map.get_node("Chest")
	var opened = map.get_node("OpenChest")
	var river = map.get_node("River")
	var fence = map.get_node("Fence")
	var decorations = map.get_node("Decorations5")
	
	if closed and opened:
		closed.visible = false
		opened.visible = true
	if river:
		river.visible = show_river
		fence.visible = true
		decorations.visible = true
		
	else:
		push_error("Chest not found")
	
	if show_key:
		show_collectible()
	
	if show_door:
		var door = get_node("Door/Door")
		if door:
			door.activate()
#	else:
#		if river:
#			river.queue_free()
#		var door = get_node("Door/Door")
#		if door:
#			door.visible = false
#			for child in door.get_children():
#				if child is CollisionShape2D:
#					child.disabled = true
#			for child in door.get_children():
#				if child is Area2D:
#					child.set_monitoring(false)
#					child.set_process(false)
#				for grandchild in child.get_children():
#					if grandchild is CollisionShape2D:
#						grandchild.disabled = true
	
func show_dark_forest():
	print(">> show_dark_forest CALLED")
	
	var background = map.get_node("Background")
	if background:
		background.visible = true
		if background is AnimatedSprite and not background.is_playing():
			background.play("switch")
		var notifier = map.get_node("Background/VisibilityNotifier")
		if notifier:
			notifier.connect("screen_entered", self, "_on_forest_visible")
			notifier.connect("screen_exited", self, "_on_forest_hidden")	
		if notifier and notifier.is_on_screen():
			var forest_sfx = background.get_node("DarkForestSound")
			print("Forest SFX:", forest_sfx)
			if forest_sfx and not forest_sfx.playing:
				forest_sfx.play()
	
	var fence = map.get_node("Fence")
	var decorations = map.get_node("Decorations5")
	var forest_decorations = map.get_node("DecorationsForest")
	var dark_forest = map.get_node("DarkForest")
	if dark_forest:
		fence.visible = true
		dark_forest.visible = true
		decorations.visible = true
		forest_decorations.visible = true
#	var dark_forest1= tilemap.get_node("TileMap8")
#	if dark_forest1:
#		dark_forest1.visible = true
##	var dark_forest = map.get_node("TileMap7")
##	if dark_forest:
#		dark_forest.visible = true
	var river = map.get_node("River")
	if river:
		river.queue_free()
		var door = get_node("Door/Door")
		if door:
			door.visible = false
			for child in door.get_children():
				if child is CollisionShape2D:
					child.disabled = true
			for child in door.get_children():
				if child is Area2D:
					child.set_monitoring(false)
					child.set_process(false)
				for grandchild in child.get_children():
					if grandchild is CollisionShape2D:
						grandchild.disabled = true
		



func show_collectible():
	var collectible = get_node("Collectible/Collectible")
	if collectible:
		collectible.visible = true
		collectible.monitoring = true
	else:
		push_error("Collectible not found")


func _on_key_collected():
	GameState.has_key = true
	key_message.show_message("You found the key! Search for the door.")

func _on_first_dialog_finished():
	
	old_man_npc.visible = true


#func _get_sprite_global_rect(sprite: AnimatedSprite) -> Rect2:
#	var tex = sprite.frames.get_frame(sprite.animation, sprite.frame)
#	if tex:
#		var sprite_size = tex.get_size() * sprite.scale
#		var global_pos = sprite.get_global_position() - (sprite_size / 2)
#		return Rect2(global_pos, sprite_size)
#	return Rect2()



func _on_forest_visible():
	var sfx = map.get_node("Background/DarkForestSound")
	if sfx and not sfx.playing:
		sfx.play()
		print("SFX playing:", sfx.playing)
		print("🌲 Forest sound started (visible)")

func _on_forest_hidden():
	var sfx = map.get_node("Background/DarkForestSound")
	if sfx and sfx.playing:
		sfx.stop()
		print("🌲 Forest sound stopped (not visible)")





















