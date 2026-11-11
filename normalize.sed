# What changes with the time of day, in what the clock says: its time,
# its date, the stopwatch, and when it asks for its next frame.
s/"[0-9][0-9]:[0-9][0-9]:[0-9][0-9]"/"HH:MM:SS"/
s/"[A-Z][a-z]*day, [A-Z][a-z]* [0-9]*"/"DATE"/
s/[0-9][0-9]:[0-9][0-9]\.[0-9]/MM:SS.t/g
s/\[next frame in [0-9]* ms\]/[next frame in N ms]/
