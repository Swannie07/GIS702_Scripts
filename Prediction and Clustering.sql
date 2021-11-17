WITH 
userstats AS(
SELECT 
DISTINCT(h.username) AS user,
COUNTIF(h.version >= 2) AS node_revisions,
DATETIME_DIFF(MAX(h.osm_timestamp), MIN(h.osm_timestamp), HOUR) AS mapping_duration,
COUNTIF(h.version < 2) AS node_contributions,
FROM `gis-702-research-project.bqml_osm.sa_history_nodes` AS h
GROUP BY 
user)
SELECT * EXCEPT(nearest_centroids_distance)
FROM 
ML.PREDICT( MODEL `gis-702-research-project.bqml_osm.osm_contributor_clusters_sa`,
    (
    SELECT
      *
    FROM
      userstats))