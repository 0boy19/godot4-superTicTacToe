extends Node

#pos of rows, collums and diagonals to check is stored in this dictonary
@onready var checker_dict = {
	"row_one" : [0,1,2],
	"row_two" : [3,4,5],
	"row_three" : [6,7,8],
	"col_one" : [0,3,6],
	"col_two" : [1,4,7],
	"col_three" : [2,5,8],
	"dia_one" : [0,4,8],
	"dia_two" : [2,4,6]

}

var data_store = []#stores current values in each pos
var win = false #to check won or not


# Called when the node enters the scene tree for the first time.
func _ready():
	reset_data_store()

func reset_data_store():
# this function resets empty values in data store
	win = false
	data_store = []
	for i in range(0,9):
		data_store.append("--")




func get_keys_for_value(value): #this func returns the keys containing that particular value
	var all_keys = checker_dict.keys()
	var keys=[]
	for i in range(0,all_keys.size()):
		var values = checker_dict[String(all_keys[i])]
		for j in range(0, values.size()):
			if values[j] == value:
				keys.append(String(all_keys[i]))
	return keys

func check_win(pos, letter): # this is checked every turn
	var tally = 0
	var key =[]
	var keys_to_check = get_keys_for_value(pos) 
#	print(keys_to_check) #check what win conditons does clicked pos have

# check if win occured on the keys
	for i in range (0,keys_to_check.size()):
		key = keys_to_check[i]
		for j in range (0,checker_dict[key].size()):
			if data_store[checker_dict[key][j]] == letter:
				tally +=1

		if tally == 3:
			win = true
			break
		else:
			tally = 0

	if win:
		print("YOU WIN")
		reset_data_store()
		#TODO:
		# every board needs own pos and list thing.
		# reseting resets for whole thing



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# use to reset game
	if(Input.is_key_pressed(KEY_ENTER)): 
		get_tree().reload_current_scene()
#		LocBoard.reset_data_store()


