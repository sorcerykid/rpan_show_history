-----------------------------------------------------
-- RPAN Show History (rpan_show_history)
--
-- See README.txt for licensing and release notes.
-- Copyright (c) 2022, Leslie E. Krause
-----------------------------------------------------

local _C = { }

local function is_match( text, pattern )
        local res = { string.match( text, pattern ) }
        setmetatable( _C, { __index = res } )
        return #res > 0
end

local function to_timestamp( str )
        -- convert from 2016-08-13T17:27:06.886Z
        assert( is_match( str, "^(%d%d%d%d)%-(%d%d)%-(%d%d)T(%d%d):(%d%d):(%d%d)" ) )
        return os.time( {
                year = tonumber( _C[ 1 ] ),
                month = tonumber( _C[ 2 ] ),
                day = tonumber( _C[ 3 ] ),
                hour = tonumber( _C[ 4 ] ),
                min = tonumber( _C[ 5 ] ),
                sec = tonumber( _C[ 6 ] ),
        } )
end

assert( arg[ 1 ], "Missing filename, aborting!" )
assert( is_match( arg[ 1 ], "^(.+)#%.html$" ), "Invalid filename, aborting!" )
local filename = _C[ 1 ]

local history = { }
local idx = 1

while true do
	local input = io.open( filename .. idx .. ".html", "r" )
	if not input then break end

	local data = input:read( "*a" )
	input:close( )

	for str in string.gmatch( data, '<div class=" search%-result (.-)</div></div></div>' ) do
		assert( is_match( str, 'class="search%-subreddit%-link may%-blank" >(.-)</a>' ) )
		local subreddit = _C[ 1 ]
		assert( is_match( str, 'data%-fullname="t3_(......)"' ) )
		local stream_id = _C[ 1 ]
		assert( is_match( str, 'class="search%-title may%-blank" >(.-)</a>' ) )
		local post_title = _C[ 1 ]
		assert( is_match( str, 'datetime="(.-)%+00:00"' ) )
		local post_date = to_timestamp( _C[ 1 ] )
		assert( is_match( str, 'class="search%-score">(.-) points?</span>' ) )
		local post_score = _C[ 1 ]

		table.insert( history, {
			subreddit = subreddit,
			stream_id = stream_id,
			post_date = post_date,
			post_title = post_title,
			post_score = post_score,
		} )
	end

	idx = idx + 1
end

assert( idx > 1, "No files found, aborting!" )

table.sort( history, function ( a, b ) return a.post_date > b.post_date end )

local script_path = string.match( arg[ 0 ], "^(.+[\\/])[^\\/]+$" ) or "./"
local template = loadfile( script_path .. "../template.lua" )

for i, v in ipairs( history ) do
	print( template( v.subreddit, v.stream_id, v.post_date, v.post_title, v.post_score ) )
end
