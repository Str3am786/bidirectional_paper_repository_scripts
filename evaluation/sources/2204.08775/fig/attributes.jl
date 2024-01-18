using StatsPlots
import RDatasets
pgfplotsx()                                  # switching to the PGFPlotsX backend

iris = RDatasets.dataset("datasets", "iris") # loading the iris data as a DataFrame
default(palette=:seaborn_colorblind)         # change the default color palette

plot(                                        # plot two Plot objects for
                                             # a 2x1 layout
    @df(iris, scatter(                       # plot SepalWidth against
        :SepalLength,                        # SepalLength in a scatter plot
        :SepalWidth,
        group=:Species,                      # series attribute
        title="Sepal length vs. width",      # subplot attribute
        xlabel="Length",                     # axis attribute
        ylabel="Width",                      # axis attribute
        marker=(0.5, [:cross :pentagon :utriangle], 12),
        # marker is a magic attribute to set many marker properties simultaneously
    )),
    @df(iris, boxplot(                       # create a boxplot of the distribution
        :Species,                            # of the SepalLengths per Species
        :SepalLength,
        group=:Species,
        ylabel="Length",
        title = "Distribution of sepal lengths per species",
        xtickfontsize = 11,
        legend = false,
    )),
    plot_title="Visualization of the iris dataset", # plot attribute
    right_margin=1Plots.cm,                 # subplot attribute
    size=(900, 600)                         # plot attribute
)

Plots.pdf("attributes.pdf")                 # save the last current Plot object
                                            # as a pdf-file
