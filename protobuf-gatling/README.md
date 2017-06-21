# Protobuf Sample Gatling Load Tests #

>
> This repository is an integral part of the "High performance web services with Swift and Protocol Buffers" article available on [Codete Blog](https://codete.com/blog/).
>

These are load tests for Protobuf Sample Server. It mesures how efficient the application endpoints respond when they are loaded by many users.

## Requirements ##

* sbt 
* Scala
* Protobuf Sample Server running

## Installation ##

1. Install sbt:
   * macOS:
      ```
      brew install sbt
      ```
   * Linux:
      ```
      sudo apt-get update
      sudo apt-get install sbt
      ```
2. Go to the project directory:
    ```
    cd protobuf-gatling
    ```
3. Run sbt:
    ```
    sbt
    ```
4. Run the test target:
    ```
    gatling:test
    ```
5. The address of the report should be printed out from sbt.

## How to use it ##

In `src/test/scala` you can find two simulations. One of them is for JSON serialization and the second one is for Protobuf serialization. Our sample server endpoints can return data in each of the format based on the `Accept` header.

To change the number of users using the API simultaneously in one simulation please modify this line in a simulation source code:

```scala
setUp(scn.inject(atOnceUsers(100))).protocols(httpProtocol)
```

Where the number of users is the parameter of the `atOnceUsers` method.