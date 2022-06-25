extends KinematicBody2D

var hp := 3;
var isAlive := true;

class_name Player

func take_damage():
	hp -= 1;
	if hp <= 0:
		hp = 0;
		isAlive = false;


