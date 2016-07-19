module Camera
  using CG;
  export ICamera, OrthoCamera, PinholeCamera;

  abstract ICamera;

  # OrthoCamera for ex2:
  type OrthoCamera <: ICamera
    camToWorld::Transformation;
    worldToCam::Transformation;
  end

  OrthoCamera(rc::Vec4f, rv::Vec4f, ru::Vec4f) =
  begin
    a = xproduct(rv, ru); # pointing right
    b = ru; # pointing up
    c = -rv; # pointing backwards
    camToWorld = Transformation(
      Vec4f(a[1], b[1], c[1], rc[1]),
      Vec4f(a[2], b[2], c[2], rc[2]),
      Vec4f(a[3], b[3], c[3], rc[3]),
      Vec4f(0.0, 0.0, 0.0, 1.0)
    );

    worldToCam = inv(camToWorld);
    return OrthoCamera(camToWorld, worldToCam);
  end

  # PinholeCamera for ex3:
  type PinholeCamera <: ICamera
    camToWorld::Transformation;
    worldToCam::Transformation;
    # screen resolution
    nx::Int;
    ny::Int;
    # screen dimensions
    w::Float32;
    h::Float32;
    # distance eye to screen
    d::Float32;

    PinholeCamera(camToWorld::Transformation, worldToCam::Transformation) =
      new(camToWorld, worldToCam, 800, 800, 2.0f0, 2.0f0, 2.0f0);
  end

  function PinholeCamera(rc::Vec4f, rv::Vec4f, ru::Vec4f)
    oc = OrthoCamera(rc, rv, ru);
    return PinholeCamera(oc.camToWorld, oc.worldToCam);
  end
end
