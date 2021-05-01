extends Node2D

signal ReadyPlay;

var high_score : int = 0;
var score : int  = 0;
var game_over : bool = true;
onready var score_label = $UI/Box/Left/Score;
onready var highscore_label = $UI/Box/Righ/HighScore
onready var button = $UI/Center/Retry;
onready var player = $Player;
onready var spawner = $Spawner;
onready var play_button = $UI/Center/Play;
onready var info_label = $UI/Info;

func _ready():
	load_score()
	highscore_label.set_text(str("HighScore: ", high_score))
	button.visible = false
	$Spawner.connect("GameOver",self,"_game_over");

func _play():
	game_over = false
	player.game_over = false;
	_score_count();

func _input(event):
	if event:
		if Input.is_action_pressed("Quit"):
			get_tree().quit();

func _score_count():
	while !game_over:
		yield( get_tree().create_timer(0.1), "timeout")
		score += 1;
		score_label.set_text(str(" Score: ", score))

func _game_over():
	game_over = true;
	if high_score < score:
		high_score = score;
	highscore_label.set_text(str("HighScore: ", high_score))
	save_to_file()
	button.visible = true;
	player.game_over = true;

func _on_Retry_pressed():
	get_tree().reload_current_scene();

func _on_Play_pressed():
	info_label.visible = false;
	_play();
	emit_signal("ReadyPlay");
	play_button.visible = false;

var score_file = "user://score.save"

func save_to_file():
	var file = File.new()
	file.open(score_file, File.WRITE)
	file.store_var(high_score, true)
	file.close()


func load_score():
	var file = File.new()
	if file.file_exists(score_file):
		file.open(score_file, File.READ)
		high_score = file.get_var()
		file.close()
	else:
		high_score = 0
