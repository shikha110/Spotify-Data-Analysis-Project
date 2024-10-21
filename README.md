Spotify Data Analysis Project:

![spotify_logo11](https://github.com/user-attachments/assets/731be678-ebec-4ee0-aac0-8090d7baffbf)

Description: 

In this project, we'll delve into a comprehensive Spotify dataset, encompassing various attributes related to tracks, albums, and artists. Utilizing SQL (Structured Query Language), we'll tackle an end-to-end process that includes:

1. Data normalization: Transforming the denormalized dataset into a well-structured format.
2. Querying: Executing SQL queries of varying complexity (easy, medium, and advanced) to extract insights.
3. Optimization: Enhancing query performance for efficient data retrieval.

The primary objectives are:

- Honing advanced SQL skills
- Uncovering valuable insights from the Spotify dataset

Through this project, we'll demonstrate expertise in data analysis, query optimization, and SQL proficiency, ultimately gaining a deeper understanding of the Spotify data landscape.

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
