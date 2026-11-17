# What changes with the time of day, in what the clock says: its time,
# its date, the stopwatch, and when it asks for its next frame; the
# alarm's time, how long until it rings (its page's and its card's),
# and when the phone is to wake the app for it, or ring the alarm set
# with it (0, not at all, is kept).
s/"[0-9][0-9]:[0-9][0-9]:[0-9][0-9]"/"HH:MM:SS"/
s/"[A-Z][a-z]*day, [A-Z][a-z]* [0-9]*"/"DATE"/
s/[0-9][0-9]:[0-9][0-9]\.[0-9][0-9]/MM:SS.hh/g
s/\[next frame in [0-9]* ms\]/[next frame in N ms]/
s/"[0-9][0-9]:[0-9][0-9]"/"HH:MM"/
s/"Rings in [^"]*"/"Rings in T"/
s/#wake-at([1-9][0-9]*)/#wake-at(N)/
s/#set([1-9][0-9]*, /#set(N, /
s/"Alarm in [^"]*"/"Alarm in T"/
s/"Once · in [^"]*"/"Once · in T"/
s/"\(Mon, Fri\|Every day\|Mon to Fri\|Weekends\) · in [^"]*"/"\1 · in T"/
