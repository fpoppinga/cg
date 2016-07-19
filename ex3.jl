include("cg.jl")
using CG;
include("camera.jl")
include("sceneobjects.jl")
include("raytracing.jl")
include("lighting.jl");
include("shaders.jl")
include("render.jl")
include("objects.jl")
using Objects;
using Camera;
using Raytracing;
using Shaders;
using Lighting;

cam = PinholeCamera(Vec4f(0, 0, 1, 1), Vec4f(0, 0, 1, 1), Vec4f(0, 1, 0, 1));
sphere = Sphere(Vec4f(0, 0, 2, 1), 0.25f0);

scene = Scene(SceneObject[sphere]);
lights = PointLights(Vec4f[Vec4f(10, 5, 0, 1)]);
tracerays(scene, lights, cam, hitShader);
show();
