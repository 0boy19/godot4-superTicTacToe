extends Node2D


func _ready():
	$CrossSprite.self_modulate= PlayerData.xModulateColour#set colour from player_data


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
