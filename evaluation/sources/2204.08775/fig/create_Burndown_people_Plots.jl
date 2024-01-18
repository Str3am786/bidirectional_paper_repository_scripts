using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()
using Plots, LaTeXStrings, JSON3, Dates
pgfplotsx()

js = JSON3.read(read("Burndown_people_Plots1.13.2.json"))
dates = Date.(getindex.(split.(js.date_range, "T"), 1)[4:end])
label_ind = findall(x->!occursin("[bot]",x), js.names)
labels = permutedims(getindex.(split.(js.names[label_ind], "|"), 1)) |> reverse
lines = Array.(getindex.(js.people[label_ind], Ref(4:70))) |> cumsum |> reverse

scalefontsizes()
scalefontsizes(1.5);
this_colors = [colorant"black"; collect(palette(:seaborn_colorblind))[[2, 3, 4, 5, 6, 7, 8, 9, 10, 1]]]
p = plot(
    dates,
    lines,
    label = labels,
    ylims = (0, :auto),
    widen = false,
    fill = true,
    legendfonthalign = :left,
    palette = palette(this_colors),
    xlabel = "Time",
    ylabel = "Lines of code",
    yrotation = 90,
    title  = "Code ownership over time of Plots.jl"
); display(p)
savefig(p, "Burndown_people_Plots1.13.2.pdf")
