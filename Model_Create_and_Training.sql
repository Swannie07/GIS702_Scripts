CREATE OR REPLACE MODEL
  bqml_osm.osm_contributor_clusters_sa OPTIONS(model_type='kmeans', num_clusters=4) AS
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
SELECT * EXCEPT (user)
FROM 
userstats