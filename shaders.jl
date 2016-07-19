module Shaders
  using CG, Raytracing, SceneObjects, Lighting;
  export hitShader, lambertShader;

  function hitShader(ray::Ray, scene::Scene, lights::Lights)
    for o in scene.sceneObjects
      intersection, t = Raytracing.intersect(ray, o);
      if intersection
        return 1.0f0;
      else
        return 0.0f0;
      end
    end
  end

  function lambertShader(ray::Ray, scene::Scene, lights::Lights)
    for o in scene.sceneObjects
      intersection, t = Raytracing.intersect(ray, o);

      if (!intersection)
        continue;
      end

      p = ray.origin + t * ray.direction;
      n = surfaceNormal(ray, t, o);

      L = 0;
      for light in lights.positions
        L = L + 1.0f0 * max(0, n * light);
      end
      return L;
    end
  end
end
