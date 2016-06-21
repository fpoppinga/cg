module CG
  import Base.+;
  import Base.-;
  import Base.*;

  export Vec4, Vec4f, Mat4, Mat4f, Object;

  # Basic types
  type Vec4{T<:Number}
    e1::T
    e2::T
    e3::T
    e4::T
  end

  type Mat4{T<:Vec4}
    v1::T
    v2::T
    v3::T
    v4::T
  end

  #typedefs
  Vec4f = Vec4{Float32};
  Mat4f = Mat4{Vec4f};

  ##operators
  # 1) vector addition
  + (v1::Vec4, v2::Vec4) =
  begin
    return Vec4f(
      v1.e1 + v2.e1,
      v1.e2 + v2.e2,
      v1.e3 + v2.e3,
      v1.e4 + v2.e4
    );
  end

  -(v1::Vec4) =
  begin
    return Vec4(-v1.e1, -v1.e2, -v1.e3, -v1.e4);
  end

  -(v1::Vec4, v2::Vec4) =
  begin
    return v1 + - v2;
  end

  *(a::Number, v::Vec4) =
  begin
    return Vec4f(a * v.e1, a * v.e2, a * v.e3, a * v.e4);
  end

  # scalar multiplication
  *(v1::Vec4, v2::Vec4) =
  begin
    return v1.e1 * v2.e1 + v1.e2 * v2.e2 + v1.e3 * v2.e3 + v1.e4 * v2.e4;
  end
  # 2) matrix operations
  *(m::Mat4, v::Vec4) =
  begin
    return Vec4f(
      m.v1 * v,
      m.v2 * v,
      m.v3 * v,
      m.v4 * v
    );
  end

  ## Object
  type Object
    vertices::Vector{Vec4f}
    Object(x::Vector{Vec4f}) = new(x)
    Object(x::Vec4f...) = new(collect(Vec4f, x))
  end

  ## Transformation
  export Transformation;
  type Transformation
    M::Mat4f

    Transformation(v1::Vec4f, v2::Vec4f, v3::Vec4f, v4::Vec4f) = new(Mat4f(v1, v2, v3, v4))
  end

  *(T::Transformation, v::Vec4f) =
  begin
    return T.M * v;
  end

  *(T::Transformation, o::Object) =
  begin
    return Object(map(x -> T * x, o.vertices))
  end

  # 1) Translation
  export translation;
  function translation(t::Vec4f)
    return Transformation(
      Vec4f(1, 0, 0, t.e1),
      Vec4f(0, 1, 0, t.e2),
      Vec4f(0, 0, 1, t.e3),
      Vec4f(0, 0, 0, 1)
    )
  end

  # 2) scaling
  export scaling;
  function scaling(t::Vec4f)
    return Transformation(
      Vec4f(t.e1, 0, 0, 0),
      Vec4f(0, t.e2, 0, 0),
      Vec4f(0, 0, t.e3, 0),
      Vec4f(0, 0, 0, 1)
    )
  end

  # 3) rotation
  export rotx;
  function rotx(a)
    return Transformation(
      Vec4f(1, 0, 0, 0),
      Vec4f(0, cos(a), -sin(a), 0),
      Vec4f(0, sin(a), cos(a), 0),
      Vec4f(0, 0, 0, 1)
    )
  end

  export roty;
  function roty(a)
    return Transformation(
      Vec4f(cos(a), 0, sin(a), 0),
      Vec4f(0, 1, 0, 0),
      Vec4f(sin(a), 0, cos(a), 0),
      Vec4f(0, 0, 0, 1)
    )
  end

  export rotz;
  function rotz(a)
    return Transformation(
      Vec4f(cos(a), -sin(a), 0, 0),
      Vec4f(sin(a), cos(a), 0, 0),
      Vec4f(0, 0, 1, 0),
      Vec4f(0, 0, 0, 1)
    )
  end
end
