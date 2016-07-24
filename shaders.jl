module Shaders
  using CG, Raytracing, SceneObjects, Lighting;
  export hitShader, lambertShader;

  function hitShader(ray::Ray, scene::Scene, lights::SceneLights)
    for o in scene.sceneObjects
      intersection, t = Raytracing.intersect(ray, o);
      if intersection
        return 1.0f0;
      else
        return 0.0f0;
      end
    end
  end

  function lambertShader(ray::Ray, scene::Scene, lights::SceneLights)
    for o in scene.sceneObjects
      intersection, t = Raytracing.intersect(ray, o);

      if (!intersection)
        return 0.0f0;
      end

      p = ray.origin + t * ray.direction;
      n = Raytracing.surfaceNormal(ray, t, o);

      L = 0.0f0;
      for l in lights.lights
        L = L + 1.0f0 * max(0, n * l.position);
      end
      return L;
    end
  end

  function blinnPhongShader(ray::Ray, scene::Scene, lights::SceneLights)

  end
end
