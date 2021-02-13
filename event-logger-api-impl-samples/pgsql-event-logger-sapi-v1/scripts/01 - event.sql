CREATE TABLE event (
  id SERIAL PRIMARY KEY,
  timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
  domain VARCHAR(100) NOT NULL,
  application VARCHAR(255) NOT NULL,
  environment VARCHAR(50) NOT NULL,
  correlation_id VARCHAR(255) NULL,
  severity VARCHAR(10) NOT NULL,
  event_type VARCHAR(50) NULL,
  business_key VARCHAR(255) NULL,
  message TEXT NOT NULL,
  details TEXT NULL
);

CREATE INDEX event_ie1 ON event (business_key, environment, application, domain);
CREATE INDEX event_ie2 ON event (correlation_id);
CREATE INDEX event_ie3 ON event (severity, environment, application, domain);
CREATE INDEX event_ie4 ON event (event_type, environment, application, domain);
CREATE INDEX event_ie5 ON event (timestamp, environment, application, domain);
CREATE INDEX event_ie6 ON event (timestamp, severity, environment, application, domain);
CREATE INDEX event_ie7 ON event (timestamp, business_key, severity, environment, application, domain);
CREATE INDEX event_ie8 ON event (timestamp, event_type, severity, environment, application, domain);

