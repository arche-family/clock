# What changes with the time of day, in what the clock says: its time,
# its date, the stopwatch, and when it asks for its next frame; the
# alarm's time, which starts as the time now, how long until it rings,
# and when the phone is to wake the app for it (0, not at all, is kept).
s/"[0-9][0-9]:[0-9][0-9]:[0-9][0-9]"/"HH:MM:SS"/
s/"[A-Z][a-z]*day, [A-Z][a-z]* [0-9]*"/"DATE"/
s/[0-9][0-9]:[0-9][0-9]\.[0-9]/MM:SS.t/g
s/\[next frame in [0-9]* ms\]/[next frame in N ms]/
s/"[0-9][0-9]:[0-9][0-9]"/"HH:MM"/
s/"Rings in [^"]*"/"Rings in T"/
s/#wake-at([1-9][0-9]*)/#wake-at(N)/
