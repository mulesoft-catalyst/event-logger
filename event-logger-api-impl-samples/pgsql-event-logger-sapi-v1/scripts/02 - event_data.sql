CREATE TABLE event_data (
  id SERIAL PRIMARY KEY,
  event_id BIGINT NOT NULL REFERENCES event,
  name VARCHAR(50) NOT NULL,
  str_value VARCHAR(4000) NULL,
  num_value DECIMAL NULL,
  dt_value TIMESTAMP WITH TIME ZONE NULL,
  bool_value BOOLEAN NULL
);

CREATE INDEX event_data_ie1 ON event_data (event_id);
CREATE INDEX event_data_ie2 ON event_data (event_id, name);
