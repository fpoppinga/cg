module Camera
  using CG;
  export OrthoCamera;
  type OrthoCamera
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
end
