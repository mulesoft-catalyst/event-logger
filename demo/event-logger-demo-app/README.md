# Event Logger Extension Demo Application

## Overview

This demo application shows how to configure and use the Event Logger Extension.

## Requirements

- Event Logger Extension is published in Anypoint Exchange (see [main readme file](../../README.md#installation))
- Your Event Logger processor is implemented and tested, or you'll use one of the [provided sample event logger processor implementations](../../event-logger-api-impl-samples). Check the [main readme file](../../README.md#logger-system-api-implementation) for more information about event logger processor implementation.

## Putting it all together

Now that you have your custom event logger processor implemented and tested, you can start using it in your Mule Apps through the Event Logger Extension.

In order to test your implementation using the Event Logger Extension:

1. Import the demo application in Anypoint Studio. For instructions, check the [main readme file](../../README.md#importing-projects-into-anypoint-studio-workspace)
2. Add the Event Logger Extension to you Mule App from Anypoint Exchange
3. If not present in AnypointStudio workspace, import your Event Logger Processor implementation (make sure the HTTP listener is configured to listen on port 8081).
4. Create a new _Run Configuration_ selecting both demo and event logger processor implementation apps (both applications will be deployed when launching the AnypointStudio embedded Mule Runtime)
5. Start Mule Runtime using the configuration previously created
6. Once the Mule Runtime is up and running, send an HTTP request to the demo app using your preferred HTTP client: 

    `POST http://localhost:8082/test`
    > The body content of this request will be assigned to the event details.
    
7. Verify that the event was correctly processed by the Event Logger Processor implementation you are using.


