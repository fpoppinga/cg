module SceneObjects
  using CG;

  export SceneObject, Sphere, AABB, Scene;

  abstract SceneObject;

  type Sphere <: SceneObject
    center::Vec4f;
    radius::Float32;
  end

  type AABB <: SceneObject
    center::Vec4f;
    # positive half length from center to face of box
    hx::Float32;
    hy::Float32;
    hz::Float32;
  end

  type Scene
    sceneObjects::Vector{SceneObject};
  end
end
