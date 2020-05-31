--
--    Copyright 2010-2016 the original author or authors.
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--       http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.
--

-- // add version to location metadata
-- Migration SQL that makes the change goes here.

ALTER TABLE core.location_metadata Add column version integer NOT NULL DEFAULT 1;

ALTER TABLE core.location_metadata DROP CONSTRAINT IF EXISTS location_metadata_geojson_id_key;
ALTER TABLE core.location_metadata ADD CONSTRAINT location_metadata_geojson_id_version_indx UNIQUE (geojson_id, version);

-- //@UNDO
-- SQL to undo the change goes here.

ALTER TABLE core.location_metadata DROP CONSTRAINT IF EXISTS location_metadata_geojson_id_version_indx;
ALTER TABLE core.location_metadata ADD CONSTRAINT location_metadata_geojson_id_key UNIQUE  (geojson_id);

ALTER TABLE core.location_metadata DROP column version;

