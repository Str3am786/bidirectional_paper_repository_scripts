#!/bin/bash

# burndown loc
hercules --burndown --first-parent --pb https://github.com/JuliaPlots/Plots.jl | labours -f pb -m burndown-project

# burndown people
# hercules --burndown --burndown-people --first-parent --pb https://github.com/JuliaPlots/Plots.jl | labours --style tableau-colorblind10 --max-people 11 -f pb -m ownership

# burndown people to json
hercules --burndown --burndown-people --first-parent --pb https://github.com/JuliaPlots/Plots.jl | python3 -m labours --font-size 20 --style tableau-colorblind10 --max-people 11 -f pb -m ownership --start-date 1/1/2016 -o Burndown_people_Plots1.13.2.json

