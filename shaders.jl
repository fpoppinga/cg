module Shaders
  using CG, Raytracing, SceneObjects, Lighting;
  export hitShader, lambertShader, blinnPhongShader;

  function hitShader(ray::Ray, scene::Scene, lights::SceneLights)
    intersection, t, = Raytracing.intersect(ray, scene);
    if intersection
      return 1.0f0;
    else
      return 0.0f0;
    end
  end

  function lambertShader(ray::Ray, scene::Scene, lights::SceneLights)
    intersection, t, o = Raytracing.intersect(ray, scene);

    if (!intersection)
      return 0.0f0;
    end

    p = ray.origin + t * ray.direction;
    n = Raytracing.surfaceNormal(ray, t, o);

    L = 0f0;
    for l in lights.lights
      L = L + 1.0f0 * max(0, n * l.position);
    end
    return L;
  end

  function blinnPhongShader(ray::Ray, scene::Scene, lights::SceneLights)
    hit, t, object = Raytracing.intersect(ray, scene)
    if hit
      # compute surface normal
      normal = Raytracing.surfaceNormal(ray,t,object)
      # intersection point of camera ray
      p = ray.origin+t*ray.direction
      # initial shade of object
      shade = 1.0f0
      for light in lights.lights
        l = light.position;
        # direction intersection point to light source
        d = unitize(l-p)
        # dot product of normal vector and direction to light
        s = normal * d;
        # phong
        v = unitize(ray.origin - p);
        h = unitize(l + v);
        phong = 1000;
        specular = 1.0f0 * max(0.0f0, (normal * h)^phong)
        # add light if light is in front of surface
        shade += specular + max(0.0f0,s);
      end
      return shade
    else
      return 0.0f0
    end
  end
end
