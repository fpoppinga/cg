include("cg.jl")
using CG;
include("rasterization.jl")
using Rasterization;

s = FrameBuffer(51, 51);

clear!(s);
triangle!(s, 40, 10, 10, 42, 42, 42, 0x40, 0x80, 0xf0);
#triangle!(s, 2, 1, 10, 40, 50, 50, 0x10, 0x90, 0xff);
plot(s);
