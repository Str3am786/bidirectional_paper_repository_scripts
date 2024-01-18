using Plots, Measurements, OrdinaryDiffEq
pgfplotsx() # change to pgfplotsx backend

# define Lotka-Volterra equations
function f(du,u,p,t)
  du[1] = p[1]*u[1] - p[2]*u[1]*u[2]  #prey
  du[2] = -p[3]*u[2] + p[4]*u[1]*u[2] #predator
end
u0 = [1.0 \pm 0.1 ; 1.0 \pm 0.1] # define initial conditions with uncertainty
tspan = (0.0,10.0)               # define start and end time
p = [1.5,1.0,3.0,1.0]            # define vector of parameters
prob = ODEProblem(f,u0,tspan,p)     # create a ODEProblem object

sol = solve(prob, Tsit5())          # solve the problem using the Tsit5
                                    # integrator. Returs a ODESolution
pl = scatter(sol, plotdensity = 75) # plotdensity is a keyword of the recipe
                                    # defined in OrdinaryDiffEq
savefig(pl, "DiffEq<3Measurements.pdf") # save plot as pdf-file
pl                                      # return plot to display
