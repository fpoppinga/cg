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
    direction.e4 = 0;
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
    tmin::Float32 = -Inf32
  	tmax::Float32 = Inf32
  	p = aabb.center-ray.origin
  	# reduce hiting problem to 1D
  	# for each axis aligned band calculate the intersection points
  	for (f,g,h) in [(p.e1,ray.direction.e1,aabb.hx),(p.e2,ray.direction.e2,aabb.hy),(p.e3,ray.direction.e3,aabb.hz)]
  		t₁ = (f+h)/g
  		t₂ = (f-h)/g
  		if t₁ > t₂
  			tmp = t₁
  			t₁ = t₂
  			t₂ = tmp
  		end
  		t₁ > tmin && (tmin=t₁)
  		t₂ < tmax && (tmax=t₂)
  		# if cube hit this wont hold true
  		if tmin > tmax
  			return false, 0.0f0
  		# if tmax < 0 cube is behind camera
  		elseif tmax < 0
  			return false, 0.0f0
  		end
  	end
  	# cube is in front of us
  	if tmin > 0
  		return true, tmin
  	# cam is inside the cube
  	else
  		return true, tmax
  	end
  end

  function intersect(ray::Ray, scene::Scene)
    tmin = Inf;
    hitObject = nothing;
    for obj in scene.sceneObjects
      hit, t = intersect(ray, obj);
      if (hit && t < tmin)
        tmin = t;
        hitObject = obj;
      end
    end

    return hitObject != nothing, tmin, hitObject;
  end

  function surfaceNormal(ray::Ray, t::Float32, sphere::Sphere)
    p = ray.origin + t * ray.direction;
    n = unitize(p - sphere.center);
    n.e4 = 0;
    return n;
  end

  function surfaceNormal(ray::Ray, t::Float32, aabb::AABB)
    # center of cube
    c = aabb.center
    #point ray hits on aabb
    h = ray.origin+t*ray.direction
    ch = h-c
    x = abs(ch.e1/aabb.hx)
    y = abs(ch.e2/aabb.hy)
    z = abs(ch.e3/aabb.hz)
    if x > y
      if x > z
        return sign(ch.e1/aabb.hx)*Vec4f(1,0,0,0)
      else
        return sign(ch.e3/aabb.hz)*Vec4f(0,0,1,0)
      end
    else
      if y > z
        return sign(ch.e2/aabb.hy)*Vec4f(0,1,0,0)
      else
        return sign(ch.e3/aabb.hz)*Vec4f(0,0,1,0)
      end
    end
  end
end
