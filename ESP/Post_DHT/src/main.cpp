// include libraries
#include <Arduino.h>
#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>

// define dht
#define DHTPIN 15
#define DHTTYPE DHT22
DHT dht(DHTPIN, DHTTYPE);

// wifi config
const char *ssid = "capapp";
const char *password = "capapp1234";
char jsonOutput[128];

void setup()
{
  Serial.begin(9600);

  WiFi.begin(ssid, password);
  Serial.println("Connecting to wifi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(500);
  }
  Serial.println("\nConnected to the wifi network");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  dht.begin();
  Serial.println(F("DHT22 Start"));
}

void loop()
{
  // get readings from dht
  float h = dht.readHumidity();
  float t = dht.readTemperature();

  // post data on server
  if (WiFi.status() == WL_CONNECTED)
  {
    HTTPClient client;
    client.begin("http://92.205.60.182:9090/Readings");
    client.addHeader("Content-Type", "application/json");
    const size_t CAPACITY = JSON_OBJECT_SIZE(2);
    StaticJsonDocument<CAPACITY> doc;

    JsonObject object = doc.to<JsonObject>();
    object["Temp"] = t;
    object["Hum"] = h;

    serializeJson(doc, jsonOutput);
    Serial.println(String(jsonOutput));

    int httpCode = client.POST(String(jsonOutput));
    Serial.println(httpCode);

    if (httpCode > 0)
    {
      String payload = client.getString();
      Serial.println("\nStatuscode: " + String(httpCode));
      Serial.println(payload);

      client.end();
    }
    else
    {
      Serial.println("Error on http request");
    }
  }

  delay(5000);
}
