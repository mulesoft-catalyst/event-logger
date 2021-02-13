# Custom Event Logger Extension

## Introduction

Event Logger is a Mule Extension that can be used to log events using a custom logging strategy implementation not supported out-of-the-box by MuleSoft.

Before using this extension, make sure the logging strategies offered by MuleSoft are not suitable for your scenario. For more information about MuleSoft OOTB logging strategies, check MuleSoft's documentation:

 - https://docs.mulesoft.com/mule-runtime/latest/logging-in-mule
 - https://docs.mulesoft.com/runtime-manager/custom-log-appender
 - https://docs.mulesoft.com/runtime-fabric/latest/runtime-fabric-logs#forward-logs-to-external-services

## How it works

The extension contains the *Logger* operation which is responsible to dispatch event log requests to the event logger processor. Event log requests are dispatched asynchronously to the Mule Application that implements the Event Logger System API specification via an HTTP request (POST /api/events).

In case of failure while executing the HTTP request, the operation will be retried according to the extension configuration properties (max retry count and interval between retries). When all retries are exhausted, the corresponding error will be logged using MuleSoft's core logger component.

Whether the HTTP request was successful or not, the log event request will be logged using MuleSoft's core logger component.

Check the [demo application](demo/event-logger-demo-app) to see how the extension can be used.

## Instructions

### Installation

1. Publish the Event Logger Extension to Anypoint Exchange (see [Event Logger Extension readme file](event-logger-extension/README.md) for more information)
2. Import the [Event Logger System API Specification](event-logger-api-spec/event-logger-sapi-v1.zip)  in Anypoint Design Center and publish it to Anypoint Exchange. For information about how to import zip files as API Spec, see [Create and Publish an API Specification or Fragment from an External File](https://docs.mulesoft.com/design-center/design-create-publish-api-specs-from-file). 
    > Changes made in the specification must be reflected in the extension implementation

Once the extension and Event Logger System API Specification are available in Anypoint Exchange, you can implement your custom event logging strategy.

### Importing Projects into Anypoint Studio Workspace

To import the projects in Anypoint Studio:

1. Clone this Git repository using your preferred Git client
2. In Anypoint Studio, open Git perspective: go to Window > Perspective > Open Perspective > Other... , select Git and click "Open"
3. Add the repository right clicking inside the "Git Repositories" view (left pane in Git Perspective), and select "Add a Git Repository..."
4. Make sure the Directory field points to the directory where the repository is located and click "Search"
5. From the Search Result, select the event logger repository (<directory>/event-logger/.git) and click "Add"
6. Expand the newly added event-logger repository in "Git Repositories" view, right click on "Working Tree" and select "Import Projects".
7. Select only the event-logger-demo-app and event-logger-api-samples projects (root event-logger project and event-logger-extension don't need to be imported). After selecting the projects, click "Finish" 

### Logger System API Implementation

1. Create a new Mule Application in Anypoint Studio based on the Event Logger System API Specification.
2. Implement the POST /api/events flow according to your strategy.

> Implementation of the logging strategy should take into account aspects like scalability, latency, resilience. In order to achieve that, it is recommended to use publish / subscribe pattern. The [samples](event-logger-api-impl-samples) folder contains examples of different logging strategy implementations.

## Final Notes

Found and issue or had an exciting idea? Great! Feel free to fork this repo and create pull requests with bug fixes and/or feature implemetations. You can also submit an issue, if you prefer!

Provide feedback, contribute and enjoy! :)
