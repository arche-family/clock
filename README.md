# Clock

The Arche phone's clock, written in [Arche](https://github.com/arche-family/arche-lang): a WebAssembly component of the Arche phone's world, which the phone installs from its repository. That world is Nimadir's mini-app world and what a phone adds to it, notifications and background wakes; its WIT is in `wit/` (from arche-os's `phone/wit`), and `world` names it. Nimadir's own shell, which has neither, does not run it.

It works like Android's:

- The time, large, with the date and the time zone under it. The time is the shell's (`now-millis`), as the user reads it (`utc-offset`, `time-zone`).
- An alarm: its time set an hour or a minute at a time, as the picker starts at the time now, and Turn on and Turn off; when on, how long until it rings. The phone wakes the app at its time (`background.wake-at`), off the screen or asleep, and the app posts a notification (`notify.post`) and turns the alarm off, as a one-time alarm of Android's does. Its time, and whether it is on, are kept in the app's storage.
- A stopwatch with Start and Stop, Lap and Reset, and its laps.

The app asks for a frame when the second turns, and every 100 ms while the stopwatch runs. It is an app of the page: its buttons' taps come as click events.

## Build

With [arche-lang](https://github.com/arche-family/arche-lang) checked out next to this repository and built (`make -C stage0 && make -C compiler && make -C wasm`):

```sh
../arche-lang/wasm/nimadir-app.sh . clock.component.wasm
```

`manifest` is what the phone's repository packages with the component. It gives the app's name, version and title, and what it may do: keep its data (`storage`), for the alarm.

## Test

`headless` holds the taps of a headless run (the alarm a minute on, turned on, an hour on, turned off; then the stopwatch) and the functions the phone's world adds, and `expected.txt` holds what arche-wasm's interpreter said to them, as Nimadir's shell does not run the app. `app-check.sh` runs the app with arche-wasm, by the interpreter and by the JIT, and compares what it says with `expected.txt`. What changes with the time of day (the time, the date, the alarm's time and how long until it rings, when the phone is to wake the app, the stopwatch and when the next frame is asked for) is normalized on both sides by `normalize.sed`. CI runs the check on every push. The alarm ringing, the phone woken from its sleep by it, is tried on the phone itself, by arche-os's `tests/phone.sh`.

```sh
../arche-lang/wasm/app-check.sh .
NIMADIR=~/nimadir ../arche-lang/wasm/app-expected.sh .   # expected.txt again, from arche-wasm
```

## License

MIT or Apache-2.0, at your option ([LICENSE](LICENSE)).
