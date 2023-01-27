# Temp-Hum-IoT-Project

My Capstone project for third secondary year.

---

# Table Of Content

* **Application:** The frond-end application that view sensor readings
* **ESP:** Module that collect data from **DHT22** sensor and send it to the server
* **Server:** The median between esp and application that get data, store it, and send it

---

# How To Install

1. Install Go-lang
1. Install Platform.io
1. Install Flutter framework

Download the project:

```
https://github.com/MohamedYasser343/Temp-Hum-IoT-Project.git
```
use command:
```
flutter create <project name>
```
Replace files in the project into the flutter project.

---
# How To Run

Remember to change IP address to your server address:
(Application/weather_app/lib/main.dart)

```dart
const serverIP = "<IP>:<Port>";
```

(ESP/Post_DHT/src/main.cpp)

```cpp
client.begin("<IP>:<Port>/Readings");
```

and change ssid and password to yours:

```cpp
// wifi config
const char *ssid = "<your ssid>";
const char *password = "<your password>";
```

1. upload esp32 code on the module
2. start the server using:
```
go run main.go
```
3. build mobile application using:
```
flutter build apk --release --split-per-abi
```
4. view the results


---
