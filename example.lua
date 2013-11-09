require "AddAppDirectory"
require "getScriptFilename"
AddAppDirectory()

local gp = runfile[[gnuplot.lua]]
gp.bin = [["C:\Program Files (x86)\gnuplot\bin\gnuplot.exe"]]


local function createFullFilePathForWindows(filename)
	local filenamefullpath = string.match(getScriptFilename(), "(.-)([^\\]-([^%.]+))$")..filename
	filenamefullpath = string.gsub(filenamefullpath,"\\","/")
	return filenamefullpath
end

local outfile = createFullFilePathForWindows("sample.png")

local g = gp{
    -- all optional, with sane defaults
    width  = 640,
    height = 480,
    xlabel = "X axis",
    ylabel = "Y axis",
	xrange = "[0:10]",
	yrange = "[0:100]",
    key    = "top left",
    consts = {
        gamma = 2.5
    },
    
    data = {
        -- gp.file {   -- plot from a file
            -- createFullFilePathForWindows("my_data_file"),                   -- file path
            -- title = "Title 1",          -- optional
        -- },
        
        gp.array {  -- plot from an 'array-like' thing in memory. Could be a numlua matrix, for example.
                   
            {
                {0,1,2,3,4,5,6,7,8,9},  -- x
                {30,40,50,60,70,80,90,80,70,60},   -- y
            },
            
            title = "My Bar Graph",          -- optional
            using = {1,2},              -- optional
            with  = 'lines',       -- optional

        },
        
        -- gp.func {   -- plot from a Lua function
            -- function(x)                 -- function to plot
                -- return 3* math.sin(2*x) + 4
            -- end,
            
            -- range = {-2, 10, 0.01},     -- optional
            -- width = 3,                  -- optional
        -- },
        
        -- gp.gpfunc { -- plot from a native gnuplot function
            -- "gamma*sin(1.8*x) + 3",
            -- width = 2,
        -- },
    }    
}:plot(outfile)


-- plot with other terminals
--g:plot('output.svg')
--g:plot('output.pdf')
--g:plot('output.wxt')
