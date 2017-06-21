# Protobuf Sample iOS Application #

>
> This repository is an integral part of the "High performance web services with Swift and Protocol Buffers" article available on [Codete Blog](https://codete.com/blog/).
>

Protobuf Sample iOS Application can retrieve data from Protobuf Sample Server application using JSON and Protocol Buffers serialization methods.

## Requirements ##

* Sample Protobuf Server running
* Xcode 8.3
* Swift 3.1
* Cocoapods 1.2.0

## Installation ##

1. Run the Protobuf Sample Server as in the separate installation document
2. Install cocoapods dependencies:
```bash
cd ProtobufSampleApp
pod install
```
3. Open the workspace in Xcode:
```bash
open ProtobufSampleApp.xcworkspace/
```
4. Run the application in Xcode
```
You can use the ⌘R (command + R) shortcut
```

The application should be run in the Simulator or the network trafic should be forwarded to the local machine since it uses `localhost` in its configuration. Possibly we could also change the server application address in the iOS application source code to the server address available form the device.

## How to use it ##

The application expects that the server will be run on 8080 port locally (`localhost:8080`), so it is required to run the server before running the iOS application.

When the app is running you can follow the instructions in the app or simply tap on the 'Get list' button. We can choose the serialization method by changing the state of the segmented control located on the top of the application.