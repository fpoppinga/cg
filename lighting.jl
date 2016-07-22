module Lighting
  using CG;
  export PointLights, Lights;

  abstract Lights;

  type PointLights <: Lights
    position::Vec4f
  end

  type SceneLights
    lights::Vector{Lights}
  end
end
