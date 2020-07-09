# GoParty 

## Description
A social app that aims to integrate friends or strangers by organizing meetings and inviting different people to spend time together. After creating an account in the application, the user will have the opportunity to create their own events and to join already created events by their friends or by professional organizational companies.
## Requirements

**Server**

 - [NodeJS](https://nodejs.org/en/) v.12.13
 - [SailsJS](https://sailsjs.com/) v.1.2.3
 - Redis v.2.8.x

**App**

 - Flutter,  sdk: ">=2.1.0 <3.0.0" 
 -  Android Studio (to launch android emulator)

## How to run?

**Server**

Go to `.../goparty-project/backend/` and run `npm install	` from the terminal. This command will download all required dependencies to the server side project.

  If you haven't installed Redis yet you can do this from [this](https://github.com/rgl/redis/downloads).   After downloading and installing run ``redis-server`` from the terminal. This command  will launch `Redis` who will manage the sessions in our project.
  
After above steps, we can  launch us project with ``sails lift`` command in the terminal( in the `.../goparty-project/backend/`).

Documentation in swagger will be at: [`http://localhost:80/swagger`](http://localhost:80/swagger).


**App**

Go to `.../goparty-project/mobile/` and run `flutter pub get` from the terminal. This command will download all required dependencies to the mobile app project.

Run emulator in your Android Studio. After this, open project in your IDE(for eq. VSCode) and launch project,   
when the emulator is found(Debug -> Run) or run `flutter run` in the terminal.

## License
MIT License

Copyright (c) 2020 Piotrek98

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. 

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.





 
