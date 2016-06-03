import Base.+;
import Base.-;
import Base.*;

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
