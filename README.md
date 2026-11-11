# Clock

The Arche phone's clock, written in [Arche](https://github.com/arche-family/arche-lang): a WebAssembly component of the Arche phone's world, which the phone installs from its repository. That world is Nimadir's mini-app world and what a phone adds to it, here notifications, background wakes and the alarm; its WIT is in `wit/` (from arche-os's `phone/wit`), and `world` names it. Nimadir's own shell, which has none of them, does not run it.

It works like Android's:

- The time, large, with the date and the time zone under it. The time is the shell's (`now-millis`), as the user reads it (`utc-offset`, `time-zone`).
- An alarm: its time set an hour or a minute at a time, as the picker starts at the time now, and Turn on and Turn off; when on, how long until it rings. The alarm is set with the phone (`alarm.set`), which keeps it and rings it at its time itself, as Android's alarm clocks are: the app need not run, the phone may be asleep, and it rings after a restart too, before the PIN opens the user's data. Rung (`alarm.next` says none), it is off, as a one-time alarm of Android's is. A phone that will not set it wakes the app at its time instead (`background.wake-at`), and the app rings it (`alarm.ring`). The phone shows its alarm screen over everything, with the time, the label, Snooze and Dismiss, and plays the alarm's sound until one is tapped, in Do Not Disturb too; after ten minutes unanswered the alarm is missed. Snoozed, it rings again ten minutes later, and the card says until when (`alarm.snoozed`), its button Dismiss (`alarm.dismiss`). A phone that does not ring it gets a notification (`notify.post`) instead. Its time, whether it is on, and whether the phone keeps it, are kept in the app's storage.
- A stopwatch with Start and Stop, Lap and Reset, and its laps.

The app asks for a frame when the second turns, and every 100 ms while the stopwatch runs. It is an app of the page: its buttons' taps come as click events.

## Build

With [arche-lang](https://github.com/arche-family/arche-lang) checked out next to this repository and built (`make -C stage0 && make -C compiler && make -C wasm`):

```sh
../arche-lang/wasm/nimadir-app.sh . clock.component.wasm
```

`manifest` is what the phone's repository packages with the component. It gives the app's name, version and title, and what it may do: keep its data (`storage`), for the alarm's time; ring as an alarm (`alarm`); be woken off the screen (`background`), at the alarm's time, on a phone that does not keep it; and post a notification (`notify`), on a phone that does not ring it.

## Test

`headless` holds the taps of a headless run (the alarm a minute on, turned on, an hour on, turned off; then the stopwatch) and the functions the phone's world adds, and `expected.txt` holds what arche-wasm's interpreter said to them, as Nimadir's shell does not run the app. `app-check.sh` runs the app with arche-wasm, by the interpreter and by the JIT, and compares what it says with `expected.txt`. What changes with the time of day (the time, the date, the alarm's time and how long until it rings, when the phone is to wake the app or ring the alarm, the stopwatch and when the next frame is asked for) is normalized on both sides by `normalize.sed`. CI runs the check on every push. The headless run's phone sets no alarm, so the app is woken for it. The alarm the phone keeps, ringing, the phone woken from its sleep by it, snoozed and dismissed, and ringing after a restart before the PIN is typed, is tried on the phone itself, by arche-os's `tests/phone.sh`.

```sh
../arche-lang/wasm/app-check.sh .
NIMADIR=~/nimadir ../arche-lang/wasm/app-expected.sh .   # expected.txt again, from arche-wasm
```

## License

MIT or Apache-2.0, at your option ([LICENSE](LICENSE)).
