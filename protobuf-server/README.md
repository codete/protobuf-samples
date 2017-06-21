# Protobuf Sample Server #

>
> This repository is an integral part of the "High performance web services with Swift and Protocol Buffers" article available on [Codete Blog](https://codete.com/blog/).
>

This is a sample server application in Swift using [Protocol Buffers](https://developers.google.com/protocol-buffers/) and JSON as the serialization methods. It was implemented using Swift 3.1, [Kitura](http://www.kitura.io/) and [Swift Protobuf](https://github.com/apple/swift-protobuf). Swift dependences are managed by Swift Package Manager.

It uses CSV documents as a data source for web services and it loads them on the boot only. CSV documents were generated with [Ruby](https://www.ruby-lang.org) and [Faker](https://github.com/stympy/faker). 

## Requirements ##

* Swift 3.1
* Swift Package Manager 
* macOS or Linux (Ubuntu) OS
* Ruby (for generating data assets only)

## Installation ##

1. Build the application using Swift Package Manager: 
```bash
cd protobuf-server
swift package update
swift build
```

2. Run the application:
```bash
.build/debug/protobuf-server
```

## Generating data assets ##

The CSV documents used for the server to create a data model are generated and ready to use, but they can ge regenerated if needed.

1. Install dependencies:
```bash
cd MocksGenerator
bundle install
```
2. Run the Ruby script:
```bash
ruby Src/generate-transactions.rb
```

The CSV files are gerenated into `MocksGenerator/Mock` folder.

## How to use it ##

When the application is running, it servers 2 endpoints:

* `http://localhost:8080/accountList` - returns the accountList object with a list of all accounts
* `http://localhost:8080/account/:accountId` - returns an account object for the specific accountId

The sample data contains two accounts that can be accessed by id as follows:

* `http://localhost:8080/account/1`
* `http://localhost:8080/account/2`

Each endpoint can return data as JSON or Protocol Buffers. It uses the `Accept` header to determine which format should be used:

|Accept header value|Used serialization method|
|----|----|
|application/octet-stream|Protocol Buffers|
|application/x-protobuf|Protocol Buffers|
|application/x-google-protobuf|Protocol Buffers|
|application/json|JSON|

The default serialzation method is JSON so if the `Accept` header is not specified then JSON serialization is used.