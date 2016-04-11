-------------------------------------------------------------------------------------------
-- MTA ELS System
-- Author: MasterM, Zuck3rFr3i
-- Lizenz: Opensource
-- Disclaimer: Do not reupload and pls use Github Repository to Push changes.
-------------------------------------------------------------------------------------------
-- light presets for specified vehicle ids (can be overwritten with per-vehicle-light (addVehicleELS))
-------------------------------------------------------------------------------------------


tblELSPresets = {
    [490] = { -- FBI Rancher
        duration = 1000,
    	lights = {
    		--front flash
    		{x = -0.9,    y = 3.3, z = -0.45, rx = -10, rz = 10,  angle = 40, color = {255,255,255}, start = 50,  stop = 100, size = 2},
    		{x = 0.9,     y = 3.3, z = -0.45, rx = -10, rz = -10, angle = 40, color = {255,255,255}, start = 50,  stop = 100, size = 2},
    		{x = -0.9,    y = 3.3, z = -0.45, rx = -10, rz = 10,  angle = 40, color = {255,255,255}, start = 150, stop = 200, size = 2},
    		{x = 0.9,     y = 3.3, z = -0.45, rx = -10, rz = -10, angle = 40, color = {255,255,255}, start = 150, stop = 200, size = 2},
    		--back
    		{x = -0.7,    y = -3.1, z = 0.45, rx = -30, rz = 110,             color = {255,0,0,255},  start = 250, stop = 500, size = 1},
    		{x = 0.7,     y = -3.1, z = 0.45, rx = -30, rz = 250,             color = {0,0,255,255},  start = 250, stop = 500, size = 1},
    		{x = -0.5,    y = -3.1, z = 0.45, rx = -30, rz = 170, angle = 80, color = {255,0,0,255},  start = 700, stop = 950, size = 1},
    	    {x = 0.5,     y = -3.1, z = 0.45, rx = -30, rz = 200, angle = 80, color = {0,0,255,255},  start = 700, stop = 950, size = 1},
            --back side
            --[[{x = -1,    y = -1.5, z = 0.9, rx = -30, rz = 110,             color = {255,0,0,255},  start = 200, stop = 400, size = 0.8, noshine = true},
            {x = -1,    y = -2.4, z = 0.9, rx = -30, rz = 110,             color = {0,0,255,255},  start = 300, stop = 500, size = 0.8, noshine = true},
            {x = 1,    y = -2.4, z = 0.9, rx = -30, rz = 110,             color = {255,0,0,255},  start = 500, stop = 700, size = 0.8, noshine = true},
            {x = 1,    y = -1.5, z = 0.9, rx = -30, rz = 110,             color = {0,0,255,255},  start = 600, stop = 800, size = 0.8, noshine = true},]]
            --front
    		{x = 0.3, y = 1.4, z = 0.55, color = {255,0,0,255}, start = 200, stop = 400,  size = 0.8, noshine = true},
    		{x = 0.6, y = 1.4, z = 0.55, color = {0,0,255,255}, start = 300, stop = 500,  size = 0.8, noshine = true},
            {x = 0.3, y = 1.4, z = 0.55, color = {255,0,0,255}, start = 700, stop = 900,  size = 0.8, noshine = true},
    		{x = 0.6, y = 1.4, z = 0.55, color = {0,0,255,255}, start = 800, stop = 1000, size = 0.8, noshine = true},
    	}
    },

    [596] = { -- Police LS
        duration = 400,
        lights = {
            {x = -0.3, y = -0.37, z = 1, rz = 50,   color = {255,0,0}, start = 0,   stop = 200, size = 1},
            {x = 0.3,  y = -0.37, z = 1, rz = -50,  color = {0,0,255}, start = 0,   stop = 200, size = 1},
            {x = -0.5, y = -0.37, z = 1, rz = 130,  color = {255,0,0}, start = 200, stop = 400, size = 1},
            {x = 0.5,  y = -0.37, z = 1, rz = -130, color = {0,0,255}, start = 200, stop = 400, size = 1},
            {x = -0.7, y = -0.37, z = 1, rz = 90,   color = {255,0,0}, start = 100, stop = 300, size = 1},
            {x = 0.7,  y = -0.37, z = 1, rz = -90,  color = {0,0,255}, start = 100, stop = 300, size = 1},


        }
    },
    [597] = { -- Police SF
        duration = 400,
        lights = {
            {x = -0.3, y = -0.37, z = 1, rz = 50,   color = {255,0,0}, start = 0,   stop = 200, size = 1},
            {x = 0.3,  y = -0.37, z = 1, rz = -50,  color = {0,0,255}, start = 0,   stop = 200, size = 1},
            {x = -0.5, y = -0.37, z = 1, rz = 130,  color = {255,0,0}, start = 200, stop = 400, size = 1},
            {x = 0.5,  y = -0.37, z = 1, rz = -130, color = {0,0,255}, start = 200, stop = 400, size = 1},
            {x = -0.7, y = -0.37, z = 1, rz = 90,   color = {255,0,0}, start = 100, stop = 300, size = 1},
            {x = 0.7,  y = -0.37, z = 1, rz = -90,  color = {0,0,255}, start = 100, stop = 300, size = 1},


        }
    },
    [598] = { -- Police LV
        duration = 400,
        lights = {
            {x = -0.3, y = -0.37, z = 1, rz = 50,   color = {255,0,0}, start = 0,   stop = 200, size = 1},
            {x = 0.3,  y = -0.37, z = 1, rz = -50,  color = {0,0,255}, start = 0,   stop = 200, size = 1},
            {x = -0.5, y = -0.37, z = 1, rz = 130,  color = {255,0,0}, start = 200, stop = 400, size = 1},
            {x = 0.5,  y = -0.37, z = 1, rz = -130, color = {0,0,255}, start = 200, stop = 400, size = 1},
            {x = -0.7, y = -0.37, z = 1, rz = 90,   color = {255,0,0}, start = 100, stop = 300, size = 1},
            {x = 0.7,  y = -0.37, z = 1, rz = -90,  color = {0,0,255}, start = 100, stop = 300, size = 1},


        }
    },

    [599] = { -- Police Ranger
        duration = 400,
        lights = {
            --top
            {x = -0.3,    y = 0.05, z = 1.25, rz = 50, color = {255,0,0}, start = 0,  stop = 200, size = 1},
            {x = 0.3,    y = 0.05, z = 1.25, rz = -50, color = {0,0,255}, start = 0,  stop = 200, size = 1},
            {x = -0.5,    y = 0.05, z = 1.25, rz = 130, color = {255,0,0}, start = 200,  stop = 400, size = 1},
            {x = 0.5,    y = 0.05, z = 1.25, rz = -130, color = {0,0,255}, start = 200,  stop = 400, size = 1},
            {x = -0.7,    y = 0.05, z = 1.25, rz = 90, color = {255,0,0}, start = 100,  stop = 300, size = 1},
            {x = 0.7,    y = 0.05, z = 1.25, rz = -90,color = {0,0,255}, start = 100,  stop = 300, size = 1},
            --front
            {x = -0.7,    y = 2.55, z = 0, color = {255,0,0}, start = 0,  stop = 200, size = 1, noshine = true},
            {x = 0.7,    y = 2.55, z = 0, color = {0,0,255}, start = 200,  stop = 400, size = 1, noshine = true},
            {x = 0.5,    y = 2.55, z = 0, color = {255,0,0}, start = 0,  stop = 200, size = 1, noshine = true},
            {x = -0.5,    y = 2.55, z = 0, color = {0,0,255}, start = 200,  stop = 400, size = 1, noshine = true},
            --side
            {x = -1.15,    y = -1.5, z = 0.4, color = {255,0,0}, start = 0,  stop = 200, size = 1, noshine = true},
            {x = 1.15,    y = -1.5, z = 0.4, color = {0,0,255}, start = 0,  stop = 200, size = 1, noshine = true},
        }

    },


    [544] = { -- Fire Truck Ladder
        duration = 500,
        lights = {
            --top big
            {x = 0.95,    y = 2, z = 1.5, rz = -100, color = {255,128,0}, start = 0,  stop = 200, size = 2},
            {x = -0.95,    y = 2, z = 1.5, rz = 100, color = {255,128,0}, start = 0,  stop = 200, size = 2},
            {x = -0.95,    y = 2.75, z = 1.5, rz = 80, color = {255,128,0}, start = 100,  stop = 300, size = 2},
            {x = 0.95,    y = 2.75, z = 1.5, rz = -80, color = {255,128,0}, start = 100,  stop = 300, size = 2},

            --top front
            {x = 0.8,    y = 3.15, z = 1.45, rz = -80, color = {255,128,0}, start = 200,  stop = 500, size = 1, noshine = true},
            {x = 0.3,    y = 3.15, z = 1.45, rz = -30, color = {255,128,0}, start = 100,  stop = 400, size = 1, noshine = true},
            {x = -0.3,    y = 3.15, z = 1.45, rz = 30, color = {255,128,0}, start = 100,  stop = 400, size = 1, noshine = true},
            {x = -0.8,    y = 3.15, z = 1.45, rz = 80, color = {255,128,0}, start = 200,  stop = 500, size = 1, noshine = true},

            -- front
            {x = -0.8,    y = 3.7, z = 0.06, color = {255,145.7,0}, start = 0,  stop = 250, size = 1, noshine = true},
            {x = 0.8,    y = 3.7, z = 0.06, color = {255,145.7,0}, start = 0,  stop = 250, size = 1, noshine = true},
            {x = 0.65,    y = 3.7, z = 0.06, color = {255,0,0}, start = 250,  stop = 500, size = 1, noshine = true},
            {x = -0.65,    y = 3.7, z = 0.06, color = {255,0,0}, start = 250,  stop = 500, size = 1, noshine = true},
        }
	},
    [427] = {--Enforcer
        duration = 500,
        lights = {
    		-- top front
            {x = -0.4, y = 1.1, z = 1.45, color = {255,0,0}, start = 0,  stop = 100, size = 2},
            {x = 0.4, y = 1.1, z = 1.45, color = {255,0,0}, start = 0,  stop = 100, size = 2},
            {x = -0.4, y = 1.1, z = 1.45, color = {255,0,0}, start = 150,  stop = 250, size = 2},
            {x = 0.4, y = 1.1, z = 1.45, color = {255,0,0}, start = 150,  stop = 250, size = 2},
            {x = 0, y = 1.1, z = 1.45, color = {255, 145,0}, start = 250,  stop = 350, size = 3},
            {x = 0, y = 1.1, z = 1.45, color = {255, 145,0}, start = 400,  stop = 500, size = 3},

    		-- center top
            {x = 0.9, y = -0.25, z =  1.65, color = {255, 145,0}, start = 0,  stop = 250, size = 1, noshine = true},
            {x = 0.9, y = -1.5, z =  1.65, color = {255, 145,0}, start = 250,  stop = 500, size = 1, noshine = true},
            {x = 0.9, y = -2.8, z =  1.65, color = {255, 145,0}, start = 0,  stop = 250, size = 1, noshine = true},
            {x = -0.9, y = -0.25, z =  1.65, color = {255, 145,0}, start = 0,  stop = 250, size = 1, noshine = true},
            {x = -0.9, y = -1.5, z =  1.65, color = {255, 145,0}, start = 250,  stop = 500, size = 1, noshine = true},
            {x = -0.9, y = -2.8, z =  1.65, color = {255, 145,0}, start = 0,  stop = 250, size = 1, noshine = true},


    		-- side yellow
            {x = 1.2, y = 0.1, z =  1.25, color = {255,145,0}, start = 0,  stop = 100, size = 1, noshine = true},
            {x = 1.2, y = -1.65, z =  1.25, color = {255,145,0}, start = 150,  stop = 250, size = 1, noshine = true},
            {x = 1.2, y = -3.4, z =  1.25, color = {255,145,0}, start = 0,  stop = 100, size = 1, noshine = true},
            {x = -1.2, y = 0.1, z =  1.25, color = {255,145,0}, start = 0,  stop = 100, size = 1, noshine = true},
            {x = -1.2, y = -1.65, z =  1.25, color = {255,145,0}, start = 150,  stop = 250, size = 1, noshine = true},
            {x = -1.2, y = -3.4, z =  1.25, color = {255,145,0}, start = 0,  stop = 100, size = 1, noshine = true},


    		-- side red
                --first
                {x = 1.2, y = 0.1, z = 0.95, color = {255, 0,0}, start = 0,  stop = 100, size = 1, noshine = true},
                {x = 1.2, y = -1.6, z = 0.95, color = {255, 0,0}, start = 150,  stop = 250, size = 1, noshine = true},
                {x = 1.2, y = -3.4, z = 0.95, color = {255, 0,0}, start = 0,  stop = 100, size = 1, noshine = true},
                {x = -1.2, y = 0.1, z = 0.95, color = {255, 0,0}, start = 0,  stop = 100, size = 1, noshine = true},
                {x = -1.2, y = -1.6, z = 0.95, color = {255, 0,0}, start = 150,  stop = 250, size = 1, noshine = true},
                {x = -1.2, y = -3.4, z = 0.95, color = {255, 0,0}, start = 0,  stop = 100, size = 1, noshine = true},
                --second
                {x = 1.2, y = 0.1, z = 0.95, color = {255, 0,0}, start = 250,  stop = 350, size = 1, noshine = true},
                {x = 1.2, y = -1.6, z = 0.95, color = {255, 0,0}, start = 400,  stop = 500, size = 1, noshine = true},
                {x = 1.2, y = -3.4, z = 0.95, color = {255, 0,0}, start = 250,  stop = 350, size = 1, noshine = true},
                {x = -1.2, y = 0.1, z = 0.95, color = {255, 0,0}, start = 250,  stop = 350, size = 1, noshine = true},
                {x = -1.2, y = -1.6, z = 0.95, color = {255, 0,0}, start = 400,  stop = 500, size = 1, noshine = true},
                {x = -1.2, y = -3.4, z = 0.95, color = {255, 0,0}, start = 250,  stop = 350, size = 1, noshine = true},

            --back
            {x = -0.95, y = -3.9, z = 0.65, color = {255, 0,0}, start = 200,  stop = 300, size = 1, noshine = true},
            {x = 0.95, y = -3.9, z = 0.65, color = {255, 0,0}, start = 200,  stop = 300, size = 1, noshine = true},
            {x = -0.95, y = -3.9, z = 0.65, color = {255, 0,0}, start = 350,  stop = 450, size = 1, noshine = true},
            {x = 0.95, y = -3.9, z = 0.65, color = {255, 0,0}, start = 350,  stop = 450, size = 1, noshine = true},
    	},
    }

}
