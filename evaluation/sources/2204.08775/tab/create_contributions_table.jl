using Pkg
Pkg.activate(joinpath(@__DIR__, "..", ".."))
Pkg.instantiate()
using JSON3, JSONTables, DataFrames, PrettyTables, Plots

jt = JSON3.read(read(joinpath(dirname(pathof(Plots)), "..", ".zenodo.json")))
df = outerjoin(
        DataFrame(jsontable(jt.creators)),
        DataFrame(jsontable(jt.contributors)),
        on = [:name, :affiliation],
        matchmissing=:equal
    )
first(df).type = "Creator"
df = select(df, "name", "affiliation", "type" => "role", "orcid")


open(joinpath(@__DIR__, "contributors_table.tex"), "w") do io
    buf = IOBuffer()
    pretty_table(buf, df, backend = Val(:latex), table_type = :longtable, nosubheader = true, alignment = :l)
    data = split(String(take!(buf)), "\n")
    insert!(data, 2, raw"    \caption{Contributors sorted by number of commits.}")
    write(io, join(data, "\n"))
end
