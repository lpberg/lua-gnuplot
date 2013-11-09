require "AddAppDirectory"
require "getScriptFilename"
AddAppDirectory()

local gp = runfile[[gnuplot.lua]]
gp.bin = [["C:\Program Files (x86)\gnuplot\bin\gnuplot.exe"]]

local function createFullFilePathForWindows(filename)
	local filenamefullpath = string.match(getScriptFilename(), "(.-)([^\\]-([^%.]+))$")..filename
	return string.gsub(filenamefullpath,"\\","/")
end

function gnuplotImage(a)
	local outfile = createFullFilePathForWindows(a.outfile or "sample.png")
	local xvalues = {}
	local yvalues = {}
	if a.values and not (a.xvalues and a.yvalues) then
		yvalues = a.values
		for i = 1, #yvalues, 1 do table.insert(xvalues,i) end
	else
		xvalues = a.xvalues or {1,2,3,4,5,6,7,8,9,10}
		yvalues = a.yvalues or {1,2,3,4,5,6,7,8,9,10}
	end
	local my_title = a.title or "My Data Graph"
	local graph_type = a.m_type or 'boxes'
	if a.color then mycolor = string.format('rgb "%s"',a.color) else mycolor = 'rgb "#0000FF"' end
	local g = gp{
		width  = a.width or 640,
		height = a.height or 480,
		xlabel = a.xlabel or "X axis",
		ylabel = a.ylabel or "Y axis",
		xrange = "["..math.min(unpack(xvalues))..":"..math.max(unpack(xvalues)).."]",
		yrange = "["..math.min(unpack(yvalues))..":"..math.max(unpack(yvalues)).."]",
		key    = a.key or "top",
		style = a.style or "fill solid .25",
		consts = {
			gamma = 2.5
		},
		data = {
			gp.array {		   
				{
					xvalues,   -- x
					yvalues,   -- y
				},
				title = my_title,           -- optional
				using = {1,2},              -- optional
				with  = graph_type,         -- optional
				color = mycolor,
			},
		}    
	}
	g:plot(outfile)
	print("gnuplotImage: "..outfile.." created")
	return outfile
end

local my_data = {220,16,805,11,305,30,45,76,91,50}



