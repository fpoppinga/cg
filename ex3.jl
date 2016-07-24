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

cam = PinholeCamera(Vec4f(0, 0, 0, 1), Vec4f(0, 0, -1, 1), Vec4f(0, 1, 0, 1));
sphere1 = Sphere(Vec4f(-0.5, 0.5, 0, 1), 0.25f0);
sphere2 = Sphere(Vec4f(-0.5, -0.5, 0, 1), 0.5f0);
aabb1 = AABB(Vec4f(0.5, -0.5, 0, 1), 0.25f0, 0.25f0, 0.25f0);
aabb2 = AABB(Vec4f(0.5, 0.5, 0, 1), 0.5f0, 0.5f0, 0.5f0);

light1 = PointLight(Vec4f(0.9, -0.5, 0.3, 1));
light2 = PointLight(Vec4f(-1, 0, 5, 1));

scene = Scene(SceneObject[sphere1, sphere2, aabb1, aabb2]);
lights = SceneLights([light1, light2]);
tracerays(scene, lights, cam, blinnPhongShader);
show();
