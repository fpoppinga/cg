module Rasterization
  using CG;
  using PyPlot;

  export FrameBuffer, clear!, colorPixel!, line!, triangle!, plot;
  type FrameBuffer
    nx::Int;
    ny::Int;
    data::Array{UInt8};
    FrameBuffer(nx::Int, ny::Int) = new(nx, ny, zeros(nx, ny));
  end

  function clear!(buffer::FrameBuffer)
    buffer.data = zeros(buffer.nx, buffer.ny);
  end

  function colorPixel!(buffer::FrameBuffer, x::Int, y::Int, color::UInt8)
    buffer.data[x, y] = color;
  end

  function plot(buffer::FrameBuffer)
    figure()
    gray()
  	clf()
    imshow(buffer.data', interpolation="nearest");
    show();
  end

  function swap!(a, b)
    tmp = a;
    a = b;
    b = tmp;
  end

  function line!(buffer::FrameBuffer, x0::Int, y0::Int, x1::Int, y1::Int, color::UInt8)
    # reassign input variables:
    if (x1 < x0)
      tmp = x0;
      x0 = x1;
      x1 = tmp;
    end

    if (y0 > y1)
      tmp = y0;
      y0 = y1;
      y1 = tmp;
    end

    m = (y1 - y0) / (x1 - x0);
    if m < 0

    elseif m >= 1
      tmp = y0;
      y0 = x0;
      x0 = tmp;

      tmp = y1;
      y1 = x1;
      x1 = tmp;
    end
    # Bresenham
    A = y1 - y0;
    B = -(x1 - x0);
    C = (x1 - x0) * y0 - (y1 - y0) * x0;

    F = function(x, y)
      return A*x + B*y + C
    end

    x = x0;
    y = y0;
    while x < x1
      colorPixel!(buffer, x, y, color);

      if (F(x + 1, y + 0.5) > 0)
        y = y + 1;
      end

      x = x + 1;
    end
  end

  function triangle!(s::FrameBuffer, x0::Int, y0::Int, x1::Int, y1::Int, x2::Int, y2::Int, ca::UInt8, cb::UInt8, cc::UInt8)
    # calculate bounding box
    xmax = min(max(x0, x1, x2), s.nx);
    ymax = min(max(y0, y1, y2), s.ny);
    xmin = max(min(x0, x1, x2), 1);
    ymin = max(min(y0, y1, y2), 1);

    for x = xmin:xmax
      for y = ymin:ymax
        gamma = ((y0 - y1) * x + (x1 - x0) * y + x0*y1 - x1*y0) / ((y0 - y1) * x2 + (x1 - x0) * y2 + x0*y1 - x1*y0);
        beta = ((y0 - y2) * x + (x2 - x0) * y + x0*y2 - x2*y0) / ((y0 - y2) * x1 + (x2 - x0) * y1 + x0*y2 - x2*y0);
        alpha = 1 - beta - gamma;

        if (0 < alpha && alpha < 1 && 0 < beta && beta < 1 && 0 < gamma && gamma < 1)
          color = UInt8(round(alpha * ca + beta * cb + gamma * cc));
          colorPixel!(s, x, y, color);
        end
      end
    end
  end
end
