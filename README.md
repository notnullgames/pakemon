# Pakémon

Short for "packet monitor/monster". Gamified fun device/platform for hacking technology around you.

Eventually this will contain all the sub-projects, as a mono-repo. Our plan is to break it up like [this](https://github.com/notnullgames/pakemon/wiki/Projects).


# frontend

There is a [web-build of the app](https://pakemon.surge.sh/), but currently many of the features might not work, and it will probably break past the intro.

## local dev

There is a Makefile included with a few targets for dev. Run `make` for help.

There is a docker-compose network you can explore, use `make interrogate` to get a nice console on an entry-point machine (running kali) inside the network.


## keys

The keys are mapped to feel like a retro-console. If you have a gamepad, these should match.

Buttons:

- `A` (`Z`) - OK
- `B` (`X`) - Back
- `X` (`A`) - secondary action
- `Y` (`S`) - tertiary action
- `START` (`ENTER`) - top-level action (pause, etc)
- `SELECT` (`TAB`) - secondary top-level action (oopen ggame maenu, etc)
- `R` (`PgUp`) - lean or scroll right in a menu
- `L` (`PgDown`) - lean or scroll left in a menu

Directionals are arrows on keyboard.

There are a few magic-keys, that are meant to be kind of like the equivilant keys in browser-dev:

- `F12` - enter "dev-mode" which will show FPS and approximate RAM of game (not the whole runtime, which you can see with `top` nix command.) It also shows keys pressed and other things like that. Good for working on pakemon.
- `F11` - give you a list of all the scenes, so you can load one
- `F5` - reload the current scene.
