extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CircleSprite.self_modulate= PlayerData.oModulateColour#set colour from player_data


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
