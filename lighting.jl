module Lighting
  using CG;
  export PointLight, Light, SceneLights;

  abstract Light;

  type PointLight <: Light
    position::Vec4f
  end

  type SceneLights
    lights::Vector{Light}
  end
end
