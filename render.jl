using PyPlot
using Camera
using SceneObjects
using Lighting

function render(object::Object; figAxis = [-1, 1, -1, 1], figNum=1, figTitle="Object")
  # make figure figNum current figure
  figure(figNum)
	# clear content of figure figNum
	clf()
  title("$figTitle");
	# set and label axis
	axis(figAxis)
	xlabel("X Axis")
	ylabel("Y Axis")
	# isometric z-projection of vertices onto plane z=0
	x = [v.e1 for v in object.vertices]
	y = [v.e2 for v in object.vertices]

	# plot projection data
	plot(x,y);
  show();
end

function render(object::Object, camera::ICamera; figNum=1)
	# transform scene given in world coordinates to camera space
	camObject = camera.worldToCam * object
	render(camObject; figNum=figNum);
end

function tracerays(scene::Scene, lights::SceneLights, camera::ICamera, shader::Function)
  nx = camera.nx;
  ny = camera.ny;
  screen = Array(Float32, nx, ny);
  for i = 1:nx
    for j = 1:ny
      ray = generateRay(camera, i, j);
      screen[i, j] = shader(ray, scene, lights);
    end
  end

  figure();
  gray();
  imshow(screen');
  colorbar();
end
