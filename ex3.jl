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

cam = PinholeCamera(Vec4f(0, 0, 1, 1), Vec4f(0, 0, -1, 1), Vec4f(0, 1, 0, 1));
sphere1 = Sphere(Vec4f(-0.5, 0.5, 0, 1), 0.25f0);
sphere2 = Sphere(Vec4f(-0.5, -0.5, 0, 1), 0.5f0);

scene = Scene(SceneObject[sphere1, sphere2]);
lights = PointLights(Vec4f[Vec4f(10, 5, 0, 1), Vec4f(-2, 0, 0, 1)]);
tracerays(scene, lights, cam, lambertShader);
show();
