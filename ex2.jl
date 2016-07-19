include("cg.jl")
using CG;
include("camera.jl")
include("render.jl")
include("objects.jl")
using Objects;
using Camera;

house = scaling(Vec4f(0.5, 0.5, 0.5, 1)) * houseOfSantaClaus();

T = rotz(pi/2);

import Base: inv;
#render(inv(T) * house, figAxis = [-2, 2, -2, 2]);

cam = OrthoCamera(Vec4f(0, 0, 1, 1), Vec4f(0, 0, -1, 1), Vec4f(10, 0, 0, 1));
render(house, cam, figNum=2);
