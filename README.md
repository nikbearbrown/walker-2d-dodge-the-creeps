# Walker — Dodge the Creeps

This is a local Walker adaptation of Godot's `2d/dodge_the_creeps`, the finished
game from the "Your first 2D game" tutorial. You move a character and avoid the
creeps for as long as possible. One touch ends the run, and your score is the
time you survived. Unlike most Walker demo adaptations, this is a small,
complete game. It sits in Walker as the simplest full game loop in the set.
Headless tests (14 checks) verify movement, bounds, spawning, scoring, game over
and restart. They also reproduced and verified one real fix: a sprite-rotation
bug after moving down and then sideways. No film is ready yet.

## How to run

Open `godot/project.godot` in Godot 4.7 and run the main scene (`main.tscn`).

Controls:

- Move: WASD or the arrow keys, or a gamepad D-pad or left stick.
- Start / restart: click **Start**, or press Enter or Space.

## Design

- [GDD.md](GDD.md): the recovered game design document (identical copy of
  `design/GDD.md`).
- [design/DECK.html](design/DECK.html): slide deck for review.
- [design/IMPLEMENTATION-MAP.md](design/IMPLEMENTATION-MAP.md): feature → scene/script paths.
- [design/decisions.md](design/decisions.md): open questions.

The GDD is a **recovered, unapproved description** of what the code does,
produced by Walker's `/gdd reverse` pass in silent mode. No design gate has been
signed.

## Source & license

An independent local adaptation of Godot `2d/dodge_the_creeps`, source commit
`a3b5c113112f77291d5f3d1360f33a882fdc52f7`. The upstream is unchanged. The
runtime adaptation is title-only, plus a reproduced fix that resets the
down-to-horizontal rotation. The original scenes, assets, UIDs, import settings
and README are retained under godot/. The root LICENSE.md retains the Godot
contributors' MIT notice. godot/LICENSE retains KidsCanCode's 2017 MIT notice.

Music: House In a Forest Loop, HorrorPen (2012), CC-BY 3.0. The original source
and license links are retained in godot/README.md. Images: Kenney Abstract
Platformer (2016), CC0. Xolonium font: Severin Meyer (2011–2016), SIL OFL 1.1;
the full license and font log are retained. Carry these attributions into any
eventual film descriptions.

## Status

No film is ready. Both native-4K Liam films remain pending under the shared
capture blocker. The original game is portrait. A film's landscape presentation
must not be confused with a verified native landscape game layout.

The collision check uses an explicit test fixture, not natural gameplay. Sound
has not been heard, and GPU frames have not been inspected. Remaining bounds,
gamepad controls, GPU trails, off-screen mob cleanup and extended play are
unverified. See FRICTIONAL.md for the evidence trail.

Repository: https://github.com/nikbearbrown/walker-2d-dodge-the-creeps
