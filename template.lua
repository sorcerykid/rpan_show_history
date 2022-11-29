local subreddit, stream_id, post_date, post_title, post_score = ...

local function from_timestamp( timestamp )
	return os.date( "%Y-%m-%dT%H:%M:%SZ", timestamp )
end

return table.concat( { subreddit, stream_id, from_timestamp( post_date ), post_title }, "\t" )
