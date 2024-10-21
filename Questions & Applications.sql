-- Easy Level

-- 1 Retrieve the names of all tracks that have more than 1 billion streams.

	select * from spotify
	where stream > 1000000000;

-- 2 List all albums along with their respective artists.

	select distinct album, artist
	from spotify 
	order by 1;

-- 3 Get the total number of comments for tracks where licensed = TRUE.

	select sum(comments) as total_comments from spotify
    where licensed = 'true';


-- 4 Find all tracks that belong to the album type single.

	select * from spotify
	where album_type ='single';

-- 5 Count the total number of tracks by each artist.

	select artist, count(*) as total_no_songs
	from spotify
	group by artist; 

-- Medium Level

-- 6 Calculate the average danceability of tracks in each album.
	
	select album, avg(danceability) as avg_danceability 
	from spotify
	group by 1
	order by 2 desc;
	
-- 7 Find the top 5 tracks with the highest energy values.

	select track, max(energy)
	from spotify
	group by 1
	order by 2 desc
	limit 5;

-- 8 List 5 tracks along with their views and likes where official_video = TRUE.

	select track, 
	sum(views) as total_views,
	sum(likes) as total_likes
	from spotify
	where official_video = 'true'
	group by 1
	order by 2 desc
	limit 5;
	

-- 9 For each album, calculate the total views of all associated tracks.

	select album, track, sum(views)
	from spotify
	group by 1, 2
	order by 3 desc;

-- 10 Retrieve the track names that have been streamed on Spotify more than YouTube

	select * from
	(select track, 
	coalesce(sum(case when most_played_on ='Youtube' then stream end),0) as streamed_on_youtube,
	coalesce(sum(case when most_played_on ='Spotify' then stream end),0) as streamed_on_spotify
	from spotify
	group by 1
	) as t1
	where 
	streamed_on_spotify > streamed_on_youtube
	and 
	streamed_on_youtube <> 0
	;

-- Advanced Level

-- 11 Find the top 3 most-viewed tracks for each artist using window functions.

	with ranking_artist
	as
	(select artist, track, 
	sum(views) as total_views,
	dense_rank() over(partition by artist order by sum(views) desc) as rank
	from spotify
	group by 1, 2
	order by 1, 3 desc
	)
	select * from ranking_artist
	where rank <=3;

-- 12 Write a query to find tracks where the liveness score is above the average.

	select track, artist, liveness
	from spotify
	where liveness > (select avg(liveness) from spotify);

-- 13 Use a WITH clause to calculate the difference between the highest and lowest 
--    energy values for tracks in each album.

	with cte
	as
	(select album,
	max(energy) as highest_energy,
	min(energy) as lowest_energy
	from spotify
	group by 1
	)
	select album,
	highest_energy - lowest_energy as energy_diff
	from cte
	;

