# Clock

The Arche phone's clock, written in [Arche](https://github.com/arche-family/arche-lang): a Nimadir mini-app, a WebAssembly component of Nimadir's world, which the phone installs from its repository and Nimadir runs on a desktop.

It works like Android's:

- The time, large, with the date and the time zone under it. The time is the shell's (`now-millis`), as the user reads it (`utc-offset`, `time-zone`).
- A stopwatch with Start and Stop, Lap and Reset, and its laps.

The app asks for a frame when the second turns, and every 100 ms while the stopwatch runs. It is an app of the page: its buttons' taps come as click events.

## Build

With [arche-lang](https://github.com/arche-family/arche-lang) checked out next to this repository and built (`make -C stage0 && make -C compiler && make -C wasm`):

```sh
../arche-lang/wasm/nimadir-app.sh . clock.component.wasm
```

`manifest` is what the phone's repository packages with the component. It gives the app's name, version and title, and what it may do: nothing beyond its own screen.

## Test

`headless` holds the taps of a headless run, and `expected.txt` holds what Nimadir's own shell said to them. `app-check.sh` runs the app with arche-wasm, by the interpreter and by the JIT, and compares what it says with `expected.txt`. What changes with the time of day (the time, the date, the stopwatch and when the next frame is asked for) is normalized on both sides by `normalize.sed`. CI runs the check on every push.

```sh
../arche-lang/wasm/app-check.sh .
NIMADIR=~/nimadir ../arche-lang/wasm/app-expected.sh .   # expected.txt again, from Nimadir's shell
```

## License

MIT or Apache-2.0, at your option ([LICENSE](LICENSE)).
