include("cg.jl")
using CG;
include("render.jl");

v1 = Vec4f(1, 0, 0, 0);
v2 = Vec4f(0.0, 42.0, 0.0, 0.0);

println(v1 - v2);

m1 = Mat4f(Vec4f(1.0, 0.0, 0.0, 0.0),
           Vec4f(0.0, 1.0, 0.0, 0.0),
           Vec4f(0.0, 0.0, 1.0, 0.0),
           Vec4f(0.0, 0.0, 0.0, 1.0));

println(2 * (m1 * v1));
println(m1 * v2);


v1 = Vec4f(1, 0, 0, 1);
v2 = Vec4f(0, 0, 0, 1);
v3 = Vec4f(0, 0, 1, 1);

triangle = Object(v1, v2, v3);

house = Object(Vec4f(-1, -1, 0, 1),
Vec4f(1, -1, 0, 1),
Vec4f(-1, 1, 0, 1),
Vec4f(0, 2, 0, 1),
Vec4f(1, 1, 0, 1),
Vec4f(1, 1, 0, 1),
Vec4f(-1, -1, 0, 1),
Vec4f(-1, 1, 0, 1),
Vec4f(1, 1, 0, 1),
Vec4f(1, -1, 0, 1))

#render(translation(Vec4f(1.5, 0, 0, 1)) * house, figAxis=[-2, 2, -2, 2]);
#render(scaling(Vec4f(0.5, 0.5, 0.5, 1)) * house, figAxis=[-2, 2, -2, 2]);
render(roty(pi/4) * house, figAxis=[-2, 2, -2, 2]);
