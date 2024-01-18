using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()
using Plots, LaTeXStrings, JSON3, Dates, DataFrames
pgfplotsx()

files = [
    "Burndown_people_Plotsv1.13.2.json",
    "Burndown_people_PlotThemesv2.0.1.json",
    "Burndown_people_PlotUtilsv1.0.10.json",
    "Burndown_people_RecipesBasev1.1.1.json",
    "Burndown_people_RecipesPipelinev0.3.2.json",
    "Burndown_people_StatsPlotsv0.14.22.json",
    "Burndown_people_GraphRecipesv0.5.6.json",
    "Burndown_people_PlotDocsmaster.json"
]
jss = [JSON3.read(read(file)) for file in files]
function merge(new::Vector{Pair{Date,Int}}, old::Vector{Pair{Date,Int}}, i=1, j=1, res = Pair{Date,Int}[])
    # @show i, j, length(new), length(old)
    # @show res
    old_start = j > length(old) ? missing : old[j].first
    new_start = i > length(new) ? missing : new[i].first
    if old_start === missing
        news = new[i:end]
        append!(res, [n.first => old[end].second + n.second for n in news])
        return res
    elseif new_start === missing
        olds = old[j:end]
        append!(res, [o.first => new[end].second + o.second for o in olds])
        return res
    elseif new_start > old_start# old starts earlier
        olds = filter(x -> x.first < new_start, old[j:end] )
        n = length(olds)
        append!(res, i > 1 ? [o.first => new[i-1].second + o.second for o in olds] : olds)
        merge(new, old, i, j + n, res)
    elseif new_start < old_start # new starts earlier
        news = filter(x -> x.first < old_start, new[i:end] )
        n = length(news)
        append!(res, [n.first => n.second .+ (j > 1 ? old[j-1].second : 0) for n in news])
        merge(new, old, i + n, j, res)
    else ## they are equal
        push!(res, new[i].first => new[i].second + old[j].second)
        merge(new, old, i+1, j+1, res)
    end
end
the_record = Dict{String,Vector{Pair{Date,Int}}}()
for js in jss
    raw_dates = Date.(getindex.(split.(js.date_range, "T"), 1))
    indices = findall(>=(Date("2016-01-01")), raw_dates)
    local dates = raw_dates[indices]
    raw_labels = getindex.(split.(js.names, "|"), 1)
    l_indices = findall(x->!occursin("[bot]", x), raw_labels)
    local labels = raw_labels[l_indices] |> permutedims |> reverse
    local lines = Array.(getindex.(js.people[l_indices], Ref(indices))) |> reverse
    for (i, label) in enumerate(labels)
        the_record[label] = get(the_record, label, [])
        @assert length(dates) == length(lines[i])
        if the_record[label] == []
            the_record[label] = [date => val for (date, val) in zip(dates, lines[i])]
        else
            the_record[label] = merge(the_record[label], [date => val for (date, val) in zip(dates, lines[i])])
        end
    end
end
the_record["michael k. borregaard"] = merge(the_record["michael k. borregaard"], the_record["michael krabbe borregaard"])
delete!(the_record, "michael krabbe borregaard")

labels = first.(sort!([key => maximum(last.(the_record[key])) for key in keys(the_record)], by=last, rev = true)[1:11])
cum_records = [reduce(merge,[the_record[label] for label in labels[1:i]]) for i in 1:length(labels)]
labels = reverse(labels)
dates = [first.(record) for record in cum_records] |> permutedims |> reverse
lines = [last.(record) for record in cum_records] |> permutedims |> reverse

scalefontsizes()
scalefontsizes(1.5);
this_colors = [colorant"black"; collect(palette(:seaborn_colorblind))[[2, 3, 4, 5, 6, 7, 8, 9, 10, 1]]]
p = plot(
    dates[1],
    lines[1],
    label = labels[1],
    xlims = :round,
    ylims = (0, :auto),
    widen = false,
    fill = true,
    legendfonthalign = :left, # FIXME: should be default
    palette = palette(this_colors),
    xlabel = "Time",
    ylabel = "Lines of code",
    yrotation = 90,
    title  = "Code ownership over time of the Plots.jl ecosystem"
)
for i in 2:length(dates) # FIXME: shouldn't be needed
    plot!(p, dates[i], lines[i], label = labels[i], fill = true)
end
display(p)
savefig(p, "Burndown_people_Plots_Ecosystem1.13.2.pdf")
