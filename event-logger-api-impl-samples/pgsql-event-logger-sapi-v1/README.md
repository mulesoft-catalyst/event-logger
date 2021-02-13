
# PostgreSQL Event Logger System API

## Introduction

This Mule App implements the [Event Logger System API Specification](../event-logger-api-spec) and it stores log events in a PostgreSQL database.

This application implements the publish / subscribe pattern using Kafka as the message broker.

## Environment Setup

Before running the application and test it, let's setup Kafka and PostgreSQL.

### Kafka

1. Install and start Kafka as described in the [Apache Kafka Quickstart](https://kafka.apache.org/quickstart). 
2. Once Kafka is up and running, let's create the topic issuing the following command:

```shell
bin/kafka-topics.sh --create --topic PGSQL_EVENT_LOGGER_TOPIC --zookeeper localhost:2181 --partitions 1 --replication-factor 1
```

For more information about Kafka, check the [official documentation](https://kafka.apache.org/documentation/)

### PostgreSQL

1. Install [Docker](https://docs.docker.com/get-docker/) if not already installed.  

2. Start a PostgreSQL docker container instance running the following command:

```shell
docker run --name eventloggerdemodb -v <path/to/db/data>:/var/lib/postgresql/data -e POSTGRES_PASSWORD=admin@01 -p 5432:5432 -d postgres
```
After running the above command for the first time, if the docker instance is not running, you can start it issuing the following command:

```docker start eventloggerdemodb```

For more information about Docker, check the [official documentation](https://docs.docker.com/).

3. Once the the container is up and running, execute an interactive bash shell on the container:

```shell
docker exec -it eventloggerdemodb bash
```

4. After getting access to the docker container instance, connect to PostgreSQL via psql:

```shell
psql -U postgres
```

5. Execute the following SQL commands to create the database and the user:

```sql
CREATE DATABASE eventdb;
CREATE USER mulesoft with encrypted password 'mulesoft';
GRANT ALL PRIVILEGES ON DATABASE eventdb TO mulesoft;
```

6. Connect to the _**eventdb**_ database: ```\connect eventdb mulesoft```

7. Create database event objects:
    - _**event**_: [scripts/01 - event.sql](scripts/01%20-%20event.sql)
    - _**event_data**_: [scripts/02 - event.sql](scripts/02%20-%20event_data.sql)
  > Keep the terminal open as we will use it later to verify that events are being correctly persisted.
  
  For more information about PostgreSQL, check the [official documentation](https://www.postgresql.org/docs/).

## Testing

Now that Kafka and PostgreSQL are up and running, we can test our custom event logger processor implementation.

1. First, import the Mule Project into an AnypointStudio workspace. For instructions, check the [main readme file](../../README.md#importing-projects-into-anypoint-studio-workspace)
2. Add the Event Logger System API Spec to the project:
    - Right click on the the Mule Project and select Manage Dependencies > Manage APIs
    - Click on the + icon and select "From Exchange"
    - Select the account where the Event Logger System API Spec was published. For more informatin, check the [main readme file](../../README.md#installation)
    - In the search box, type "event-logger-sapi-v1". The API spec should be listed in the available modules.
    - From the Available modules list, select "event-logger-sapi-v1", click "Add >" and "Finish". The selected module should appear in the API list.
    - Click "Apply and Close", and when prompted to scaffold the specification, click "No".
    - Open pgsql-event-logger-api.xml, edit the APIKit router configuration (Open "Global Elements" tab, select the router configuration and click edit). In the "API Definition" field, select "event-logger-sapi-v1" from the dropdown list, and click Ok. 
2. Review the local configuration properties located at config/local.yaml
3. Start the Mule Application
4. Using your favorite HTTP client, submit the following request: `POST http://localhost:8081/api/events`

```json
{
	"domain": "somedomain",
	"application": "my-test-app",
	"environment": "local",
	"severity": "INFO",
	"timestamp": "2021-01-07T10:19:00.000-03:00",
	"message": "This is a test",
	"correlationId": "1234566",
	"event_type": "TEST"
	"businessKey": "987654",
	"details": "Some additional information",
	"eventData": [
		{"name": "dtValue", "value": "2021-01-07T10:19:00.000-03:00"},
		{"name": "strValue", "value": "some string value"},
		{"name": "intValue", "value": 12345677899},
		{"name": "dblValue", "value": 123456.23},
		{"name": "boolValue", "value": true}
	]	
}
```

5. Let's check if the event was correctly persisted:
    - In the psql session, run the following SQL command:
    ```sql
    SELECT * FROM event;
    ```
    The query should return a record containing the values posted in the request.
    
    - Check if event data was correctly persisted issuing the following SQL command:
    ```sql
    SELECT * FROM event_data = :event_id -- replace :event_id by the id value returned in the previous query.
    ```

Now that you have checked that you custom event logging strategy is working as expected, it can be used by the Mule Event Logger Extension.

Check the [demo application readme](../../demo/event-logger-demo-app/README.md) for instructions on how to configure the Mule Extension to use this event logger processor implementation.
