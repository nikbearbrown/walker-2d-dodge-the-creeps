extends SceneTree

var failures := 0
func _initialize() -> void:
	call_deferred("run")

func check(ok: bool, label: String) -> void:
	if not ok:
		failures += 1
	print("PASS " if ok else "FAIL ", label)

func key(code: Key, down: bool) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = code
	event.pressed = down
	Input.parse_input_event(event)
	await process_frame

func click(button: Button) -> void:
	for down in [true, false]:
		var event := InputEventMouseButton.new()
		event.position = button.get_global_rect().get_center()
		event.global_position = event.position
		event.button_index = MOUSE_BUTTON_LEFT
		event.pressed = down
		root.push_input(event, true)
		await process_frame

func run() -> void:
	seed(123)
	root.size = Vector2i(480, 720)
	var game: Node = load("res://main.tscn").instantiate()
	root.add_child(game)
	await process_frame
	await process_frame
	var player: Area2D = game.get_node("Player")
	check(not player.visible, "initial player hidden")
	await click(game.get_node("HUD/StartButton"))
	check(player.visible and game.score == 0 and game.get_node("Music").playing, "start resets player score and music state")
	await key(KEY_S, true)
	await create_timer(0.1).timeout
	await key(KEY_S, false)
	check(is_equal_approx(player.rotation, PI), "downward orientation")
	await key(KEY_D, true)
	await create_timer(0.1).timeout
	await key(KEY_D, false)
	check(is_zero_approx(player.rotation), "horizontal movement resets orientation")
	var before := player.position
	await key(KEY_W, true)
	await key(KEY_A, true)
	await create_timer(0.2).timeout
	await key(KEY_W, false)
	await key(KEY_A, false)
	var distance := player.position.distance_to(before)
	check(distance > 70 and distance < 100, "diagonal motion normalized near 400px/s")
	await key(KEY_A, true)
	await create_timer(0.8).timeout
	await key(KEY_A, false)
	check(is_zero_approx(player.position.x), "left boundary clamps")
	await create_timer(2.0).timeout
	check(get_nodes_in_group("mobs").size() > 0, "timer spawns mobs")
	check(game.score >= 1 and game.get_node("HUD/ScoreLabel").text == str(game.score), "timed score updates label")
	# Explicit collision fixture, not a claimed natural encounter or footage.
	var mob: RigidBody2D = load("res://mob.tscn").instantiate()
	mob.position = player.position
	mob.freeze = true
	game.add_child(mob)
	await create_timer(0.15).timeout
	check(not player.visible and player.get_node("CollisionShape2D").disabled, "physics collision hides/disables player")
	check(game.get_node("MobTimer").is_stopped() and game.get_node("ScoreTimer").is_stopped(), "collision stops gameplay timers")
	check(not game.get_node("Music").playing, "game over stops music state")
	await create_timer(2.2).timeout
	check(game.get_node("HUD/StartButton").visible, "restart offered after messages")
	await click(game.get_node("HUD/StartButton"))
	await process_frame
	check(player.visible and not player.get_node("CollisionShape2D").disabled and game.score == 0, "restart restores player and score")
	check(get_nodes_in_group("mobs").is_empty(), "restart clears mobs")
	game.get_node("Music").stop()
	game.get_node("DeathSound").stop()
	await create_timer(0.25).timeout
	print("RESULT failures=", failures, "; headless state and collision fixture, not footage")
	quit(1 if failures else 0)
