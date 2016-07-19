module Lighting
  using CG;
  export PointLights, Lights;

  abstract Lights;

  type PointLights <: Lights
    positions::Vector{Vec4f};
  end
end
