extends KinematicBody2D

var velocity = Vector2.ZERO
var velocity_previous = Vector2.ZERO
var hp := 3;
var isAlive := true;
var hit_the_ground = false;
const JUMP_HEIGHT = -1200
export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var initScale = Vector2.ONE;

class_name Player

func take_damage():
	hp -= 1;
	if hp <= 0:
		hp = 0;
		isAlive = false;

func _ready():
	var s = Vector2.ZERO
	s.x = $Sprite.scale.x
	s.y = $Sprite.scale.y
	self.initScale = s


func get_input():
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
	if Input.is_action_pressed("ui_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
	squish_sprite(delta)
	velocity_previous = velocity



func squish_sprite(delta):
	var sx = initScale.x
	var sy = initScale.y
	if not is_on_floor():
		hit_the_ground = false
		$Sprite.scale.y = range_lerp(abs(velocity.y), 0, abs(JUMP_HEIGHT), sy * 0.75, sy * 1.75)
		$Sprite.scale.x = range_lerp(abs(velocity.y), 0, abs(JUMP_HEIGHT), sx * 1.25, sx * 0.75)
	
	if not hit_the_ground and is_on_floor():
		hit_the_ground = true
		$Sprite.scale.x = range_lerp(abs(velocity_previous.y), 0, abs(JUMP_HEIGHT), sx * 1.2, sx* 2.0)
		$Sprite.scale.y = range_lerp(abs(velocity_previous.y), 0, abs(JUMP_HEIGHT), sy*  0.8, sy * 0.5)
	
	$Sprite.scale.x = lerp($Sprite.scale.x, sx, 1 - pow(0.01, delta))
	$Sprite.scale.y = lerp($Sprite.scale.y, sy, 1 - pow(0.01, delta))


func nextToWall():
	pass
	
func nextToRightWall():
	
	return $RightWall.is_colliding();
	
func nextToLeftWall():
	return $LeftWall.is_colliding();
	
