include("cg.jl")
using CG;
include("render.jl")
include("objects.jl")
using Objects;

house = houseOfSantaClaus();

T = rotz(pi/2);

import Base: inv;

render(inv(T) * house, figAxis = [-2, 2, -2, 2]);
