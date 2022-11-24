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

local source_filename = arg[ 1 ] or "results.html"

local input = io.open( source_filename, "r" )
assert( input, "Could not open file for reading: " .. source_filename )

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
	local post_created = _C[ 1 ] .. "Z"
	assert( is_match( str, 'class="search%-score">(.-) points</span>' ) )
	local post_points = _C[ 1 ]

	print( string.format( '%s\t%s\t%s\t%s',
		subreddit, stream_id, post_created, post_title ) )
end
