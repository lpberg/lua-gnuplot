require "AddAppDirectory"
AddAppDirectory()

runfile[[vrj_interface.lua]]

myImage = gnuplotImage{
	title = "My Sample Data",     -- optional, but probably a good idea
	values = my_data,		      -- must pass table of values (or xvalues and yvalues separately)
	m_type = "lines",			  -- "lines" for line-graph, "boxes" or bar-graph
	color = "#FF0000", 		      -- optional
	outfile = "mySampleData.png", -- optional
}

print(myImage)