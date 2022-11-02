
# TODO

- Things that were broken as a result of Godot 4 conversion:
	- [x] Fullscreen does not scale correctly
		- It sort of does now, may need more fiddling in the project settings
	- [x] ESC doesn't exit the game
	- [x] Highscore and score not shown
	- [ ] No particle effects (when shooting enemy helis)
		- They're there but very subtle
	- [ ] Enemies don't launch rockets
- [ ] Move graphic assets to a spritesheet / texture atlas
- [ ] ~~A favicon for Windows executable~~ -> Doesn't work for some reason
	- I really should rewrite rcedit
- [ ] Change the splash screen logo
- [ ] Better particles?
	- [ ] Explosion animation could be better
	- [ ] Rocket fire for the projectiles and ~~the jet~~
- [ ] Make the game more difficult
	- [ ] Enemies should be able to launch projectiles in different directions.
	- [ ] Spawn enemies faster every +50 score
- [ ] Scoring system
	- [ ] Near misses could amount to +2
	- [ ] Don't update High Score every frame!
- [ ] Let the jet go further up, down and right.
- [ ] Draw the graphics by hand
	- [ ] Enemies
	- [x] Jet
	- [x] Projectiles
	- [ ] Clouds
	- [ ] Mountains (?)
- [ ] Downloadable files should save other options such as fullscreen by default or not
- [ ] Add sound effects
	- [ ] Launching rockets
	- [ ] Explosion
	- [ ] Helicopter sounds (?)

## Done

- [x] Add a main ~~menu~~ screen
- [x] Projectiles just go in the direction they were launched in (based on rotation)
- [x] Parallax things such as the clouds, etc.
- [x] Fix the Game Over text by adding another font.
- [x] Add "Score" HUD
- [x] Option for restarting after game over
- [x] Enemies should fire back
- [x] 0.5 second limit for launching rockets
- [x] Make helicopter and the player smaller and faster
- [x] Blowing up animation for collisions
- [x] Add High Score
- [x] Fix the issue where players can hit themselves with the rockets they launch
- [x] Find a way to infinitely scroll the mountains and fix the current broken code
- [x] Helicopter animation
