module Raytracing
  using CG, Camera, SceneObjects;
  export Ray, generateRay, intersect;

  type Ray
    origin::Vec4f;
    direction::Vec4f;
  end

  function generateRay(camera::PinholeCamera, i::Int, j::Int)
    u = -camera.w / 2 + camera.w * (i - 0.5) / camera.nx
  	v = +camera.h / 2 - camera.h * (j - 0.5) / camera.ny
  	# pixel position
  	p = Vec4f(u, v, 0, 1)
  	# eye position
  	o = Vec4f(0, 0, camera.d, 1)

  	# origin in world coordinates
  	origin = camera.camToWorld * p
  	# unit vector for ray direction
  	direction = camera.camToWorld * (unitize(p-o))
  	return Ray(origin, direction)
  end

  function intersect(ray::Ray, sphere::Sphere)
    d = ray.direction;
    o = ray.origin;
    c = sphere.center;
    r = sphere.radius;

    A = d * d;
    B = 2 * d * (o - c);
    C = (o - c) * (o - c) - r^2;

    radical = B * B - 4 * A * C;
    if radical < 0
      return false, 0.0f0;
    else
      t1 = -B / (2 * A) + sqrt(radical);
      t2 = -B / (2 * A) - sqrt(radical);

      return true, C > 0 ? t2 : t1;
    end
  end

  function intersect(ray::Ray, aabb::AABB)
    return false; #TODO: implement
  end

  function surfaceNormal(ray::Ray, t::Float32, sphere::Sphere)
    p = ray.origin + t * ray.direction;
    n = unitize(p - sphere.origin);
    return n;
  end

  function surfaceNormal(ray::Ray, t::Float32, aabb::AABB)
    return Vec4f(1, 0, 0, 1); #TODO: implement
  end
end
