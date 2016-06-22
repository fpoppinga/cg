module Objects
  using CG;
  export houseOfSantaClaus;
  function houseOfSantaClaus()
    return Object(Vec4f(-1, -1, 0, 1),
    Vec4f(1, -1, 0, 1),
    Vec4f(-1, 1, 0, 1),
    Vec4f(0, 2, 0, 1),
    Vec4f(1, 1, 0, 1),
    Vec4f(1, 1, 0, 1),
    Vec4f(-1, -1, 0, 1),
    Vec4f(-1, 1, 0, 1),
    Vec4f(1, 1, 0, 1),
    Vec4f(1, -1, 0, 1));
  end
end
