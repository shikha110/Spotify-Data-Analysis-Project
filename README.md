Spotify Data Analysis Project:

![spotify_logo11](https://github.com/user-attachments/assets/731be678-ebec-4ee0-aac0-8090d7baffbf)

Description: 

Since I love listening to songs of various genres, I am addicted to using spotify to satisfy my ears and therefore this how i first started this project. I was curious about different number of artists, there albums and the listener count, so this project came handy. This project contains comprehensive cleaning of Spotify dataset, encompassing various attributes related to tracks, albums, and artists. Utilizing SQL (Structured Query Language),to tackle an end-to-end process which includes:

1. Data normalization: Transforming the denormalized dataset into a well-structured format.
2. Querying: Executing SQL queries of varying complexity (easy, medium, and advanced) to extract insights.
3. Optimization: Enhancing query performance for efficient data retrieval.


Through this project, I have demonstrated expertise in data analysis, query optimization, and SQL proficiency, ultimately gaining a deeper understanding of the Spotify data landscape.

Creating table:

```sql
    CREATE TABLE spotify (
  	  artist VARCHAR(255),
  	  track VARCHAR(255),
  	  album VARCHAR(255),
  	  album_type VARCHAR(50),
	  danceability FLOAT,
          energy FLOAT,
 	  loudness FLOAT,
	  speechiness FLOAT,
          acousticness FLOAT,
          instrumentalness FLOAT,
          liveness FLOAT,
          valence FLOAT,
          tempo FLOAT,
          duration_min FLOAT,
          title VARCHAR(255),
          channel VARCHAR(255),
          views FLOAT,
          likes BIGINT,
          comments BIGINT,
          licensed BOOLEAN,
          official_video BOOLEAN,
          stream BIGINT,
          energy_liveness FLOAT,
          most_played_on VARCHAR(50)
);

```


-- Easy Level--

1 Retrieve the names of all tracks that have more than 1 billion streams.
```sql
	select * from spotify
	where stream > 1000000000;
```
2 List all albums along with their respective artists.
```sql
	select distinct album, artist
	from spotify 
	order by 1;
```
3 Get the total number of comments for tracks where licensed = TRUE.
```sql
	select sum(comments) as total_comments from spotify
        where licensed = 'true';
```
 4 Find all tracks that belong to the album type single.
```sql
	select * from spotify
	where album_type ='single';
```
5 Count the total number of tracks by each artist.
```sql
	select artist, count(*) as total_no_songs
	from spotify
	group by artist; 
```
-- Medium Level--

 6 Calculate the average danceability of tracks in each album.
```sql
	select album, avg(danceability) as avg_danceability 
	from spotify
	group by 1
	order by 2 desc;
```	
7 Find the top 5 tracks with the highest energy values.
```sql
	select track, max(energy)
	from spotify
	group by 1
	order by 2 desc
	limit 5;
```
8 List 5 tracks along with their views and likes where official_video = TRUE.
```sql
	select track, 
	sum(views) as total_views,
	sum(likes) as total_likes
	from spotify
	where official_video = 'true'
	group by 1
	order by 2 desc
	limit 5;
```	

9 For each album, calculate the total views of all associated tracks.
```sql
	select album, track, sum(views)
	from spotify
	group by 1, 2
	order by 3 desc;
```
10 Retrieve the track names that have been streamed on Spotify more than YouTube
```sql
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
```

-- Advanced Level--

11 Find the top 3 most-viewed tracks for each artist using window functions.
```sql
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
```
12 Write a query to find tracks where the liveness score is above the average.
```sql
	select track, artist, liveness
	from spotify
	where liveness > (select avg(liveness) from spotify);
```
13 Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
```sql
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

```
--Technology Stack--

Database: PostgreSQL
SQL Queries: DDL, DML, Aggregations, Joins, Subqueries, Window Functions
Tools: pgAdmin 4, PostgreSQL 





