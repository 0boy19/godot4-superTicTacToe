extends Control
#this whole thing is the multiplayer controller
@export var Address ="192.168.10.111" #"localhost"
@export var port = 8910
var peer
var wins = PlayerData.wins
#https://www.youtube.com/watch?v=e0JLO_5UgQo&ab_channel=FinePointCGI
var ip_address= ""
var ip_test = ""



#peers are the "players"
##TODO##
#make a bool isMultiplayer to run certain things if it's multiplayer
#apply it in slelectedArea.gd and Board.gd
# for board you also have to do it for the signals
# there has to be turns system, you need to know whose turn is it




# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	
	#test 
		
	if OS.get_name() == "Windows":
		ip_address = IP.get_local_addresses()[7]
	elif OS.get_name() == "Android":
		ip_address = IP.get_local_addresses()[0]
	else:
		ip_address = IP.get_local_addresses()[3]
	
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168.") and not ip.ends_with(".1"):
			ip_address = ip
			
			
	$Host/HostIP.text = "IP: " + str(ip_address)# idk why it's 7

#this gets called on the server and clients
func peer_connected(id):
	print("player connected with id: ", id)

#this gets called on the server and clients
func peer_disconnected(id):
	print("Player Disconnected with id: ", id)

#this only called from clients
func connected_to_server():
	print("connected to server")
	SendPlayerInformation.rpc_id(1,$LineEdit.text, multiplayer.get_unique_id(), wins)

#this only called from clients
func connection_failed():
	print("connection failed")


@rpc("any_peer")
func SendPlayerInformation(name,id): 
	if !MultiplayerGameManager.Players.has(id):
		MultiplayerGameManager.Players[id] = {
			"name": name,
			"id": id,
			"wins": 0
		}#"score" can be removed since this is tictactoe # also we can make new info to add at will!
		
	if multiplayer.is_server():
		for i in MultiplayerGameManager.Players:
			SendPlayerInformation.rpc(MultiplayerGameManager.Players[i].name,i)#passes info to everyone in server ig

@rpc("any_peer","call_local")
func Start_Game():
	var scene = load("res://Scenes/main.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()#hides this ui scene

func _on_host_pressed():#sets up host
	peer = ENetMultiplayerPeer.new() #new instance of peer
	var error= peer.create_server(port,2) #port and max amt of clients
	if error != OK:
		print("cannot host ",error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER) #to save bandwith usage #same compression has to be used anytime
	
	multiplayer.set_multiplayer_peer(peer)#basically use the host as peer
	print("Waiting for Players...")
	print(ip_address)
	SendPlayerInformation($LineEdit.text, multiplayer.get_unique_id())


func _on_join_pressed():
	var txtIP =""
	if $Join/HostsIP.text.is_valid_ip_address(): #if valid, join.
		peer = ENetMultiplayerPeer.new()
		#peer.create_client(Address,port)
		peer.create_client(txtIP,port)
		peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
		multiplayer.set_multiplayer_peer(peer) #set urslef as the multiplayer peer
	else:
		$Join/HostsIP/InvalidIP.show()
	


func _on_start_game_pressed():
	Start_Game.rpc()


func _process(delta):
	pass


func _on_back_to_main_menu_pressed():
	Game.reset_data_store()
	Game.reset_Loc_Boards_Score()
	Game.reset_global_winTie()
	Game.reset_active_Boards()
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
