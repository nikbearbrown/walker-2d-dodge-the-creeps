# Verification and friction — 2026-09-24

Read all four gameplay scripts, main/HUD scenes, project configuration, README,
game MIT and font OFL licenses. No source 2d AGENTS.md found. Created separate
local copy; original checkout untouched. No visible game window opened.

Godot 4.7.2 headless import exited 0. Normal main scene ran 120 frames and exited
0 without errors (import-20260924.log, runtime-20260924.log). This only reaches
the title screen; it is NOT gameplay verification.

NEXT: inspect player/mob scenes; route actual Start and movement input; verify
normalized motion, bounds, timed spawning/scoring, collision game over and restart.
Source inspection suggests horizontal motion after downward motion may retain
the player's PI rotation; reproduce before changing it. Do not call that a
confirmed bug yet. Audio audibility, visuals and both films remain pending.
Retain this item for behavioral verification before advancing.

## Behavioral follow-up — 05:14 UTC heartbeat

Read player/mob scenes and checked no Godot process was running. Added separate
test_input.gd; initial probe parse errors from inferred load().instantiate()
types are preserved in input-20260924.log (engine returned 0 despite errors).
Explicit Node/RigidBody2D annotations fixed the probe. input-repro-20260924.log
then reproduced one runtime defect: down followed by right retained PI rotation.
Local player.gd now resets rotation to zero in the horizontal-motion branch.
Original source remains unchanged.

input-fixed-20260924.log exits 0 with 14 passing checks and no logged errors.
Routed Start mouse events and physical WASD events verify start state, down/right
orientation, approximately normalized diagonal movement, left bound, natural
timer mob spawning and score display. Collision test inserts a frozen mob at
the player's current position (explicit fixture, not a natural gameplay claim):
actual physics overlap hides/disables player, stops timers/music, then offers
restart. Routed restart clears mobs and restores player/collision/zero score.
Music/death streams were stopped and drained before diagnostic shutdown.

No sound was heard or GPU frames inspected. Collision fixture and engine-injected
inputs are test evidence, not film footage. Remaining bounds, gamepad controls,
GPU trails, offscreen mob cleanup and extended play remain unverified. Both
films stay pending under the capture blocker; next feasible source may proceed.
