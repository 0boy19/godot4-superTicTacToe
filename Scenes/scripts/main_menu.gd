extends Control
var xColour :=Color(PlayerData.xModulateColour)
var oColour :=Color(PlayerData.oModulateColour)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/options_Menu/ColorPickerButton_X.color = xColour#change color on picker wheel
	$Menu/options_Menu/ColorPickerButton_X/X_img.self_modulate = xColour # change the x menu img colour
	
	$Menu/options_Menu/ColorPickerButton_O.color = oColour
	$Menu/options_Menu/ColorPickerButton_O/O_img.self_modulate = oColour

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_play_pressed():#pay button pressed
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_options_pressed():
	$Menu/main_Screen.hide()
	$Menu/options_Menu.show()
	$Menu/BackButton.show()


func _on_quit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/multiplayer_ui.tscn")


func _on_color_picker_button_x_color_changed(color):#when we change colour in the wheel,
	PlayerData.xModulateColour= Color(color) # change the colour in player_data
	$Menu/options_Menu/ColorPickerButton_X/X_img.self_modulate = Color(color) # change that in img


func _on_color_picker_button_o_color_changed(color):
	PlayerData.oModulateColour= Color(color) # change the colour in player_data
	$Menu/options_Menu/ColorPickerButton_O/O_img.self_modulate = Color(color) # change that in img


func _on_back_button_pressed():
	$Menu/options_Menu.hide()
	$Menu/BackButton.hide()
	$Menu/main_Screen.show()
