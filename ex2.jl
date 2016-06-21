include("cg.jl")
using CG;

x = rotx(pi/4) * rotx(pi/4);
y = rotx(pi/2);

println(x);
println(y);
