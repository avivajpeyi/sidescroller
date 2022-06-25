extends "res://addons/gut/test.gd"


var Player = load("res://src/Player.gd")

func test_player_health():
	var p = Player.new();
	p.take_damage();
	assert_eq(p.isAlive, true);
	for _i in range(10):
		p.take_damage();
	assert_eq(p.isAlive, false);
	assert_eq(p.hp, 0);

