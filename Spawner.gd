extends Position2D

signal GameOver;

export var keep_spawning : bool = false;

onready var obs = preload("res://Obstacle.tscn");
onready var obs_cactus = preload("res://ObstacleCactus.tscn");
var spedd_inc : float = 0;

func _signal_data():
	keep_spawning = true;
	_start();

func _process(delta):
	spedd_inc += 5 * delta;

func _ready():
	get_parent().connect("ReadyPlay",self,"_signal_data");

func _start():
	while (keep_spawning):
		yield( get_tree().create_timer(rand_range(0.5,2.3)), "timeout" )
		_spawn()

func _spawn():
	var object;
	if randi()%2+1 == 1:
		object = obs.instance();
	else:
		object = obs_cactus.instance();
	object.speed += spedd_inc;
	self.add_child(object)
	object.connect("PlayerDeath",self,"_game_over")

func _game_over():
	keep_spawning = false;
	emit_signal("GameOver")

