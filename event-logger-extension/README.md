# Event Logger Extension

## Publish to Anypoint Exchange

1. Make sure your Anypoint Platform credentials are correctly configured in `~/.m2/settings.xml` file
2. Edit `pom.xml` file:
    - replace all occurrences of **custOrgId** with customer's Anypoint Platform OrgId
    - replace all occurrences of **cust-repo-server-id** with the server id defined in `~./m2/settings.xml`
3. Run ``mvn clean deploy -DskipTests``
4. Check that the extension is available in Anypoint Exchange

For more information about how to publish assets in Exchange, see how to [Publish Assets using Maven](https://docs.mulesoft.com/exchange/to-publish-assets-maven) 

## Using the Extension

Once the extension is available in Anypoint Exchange, it can be used in your Mule Apps. 

1. Add the extension to your Mule project. For instructions, see [Adding Modules to Your Project](https://docs.mulesoft.com/studio/latest/add-modules-in-studio-to)
2. Create the HTTP Request Configuration that will be used by the Logger operation.
3. In the Mule Palette, select EventLoggerExtension and drag the Logger operation into the desired flow. 
4. Create a new module configuration (if none exists), and set the Domain Name, Application Name and Environment properties available in the General tab. Select the Event Logger System API tab and provide the HTTP Request configuration reference (should correspond to the name of the HTTP request configuration created previously).
5. Setup the operation parameters as desired

That's it! Your log events should be dispatched to the event logger processor.

Check the [demo](../demo/event-logger-demo-app) to see an example of how the extension can be used.
