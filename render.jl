using PyPlot

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
