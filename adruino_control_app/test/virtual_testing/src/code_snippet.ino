#include <WiFi.h>

#define WIFI_SSID "Wokwi-GUEST"
#define WIFI_PASSWORD ""
// Defining the WiFi channel speeds up the connection:
#define WIFI_CHANNEL 6

WiFiServer server(80);
// Setup pin according to your wiring
const int ledPin = 13;

void setup()
{
  Serial.begin(115200);
  pinMode(ledPin, OUTPUT);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD, WIFI_CHANNEL);
  Serial.print("Connecting to WiFi ");
  Serial.print(WIFI_SSID);
  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(100);
    Serial.print(".");
  }
  Serial.println(" Connected!");

  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());
  server.begin();
}

void loop()
{
  WiFiClient client = server.available();
  // Read the request if client exist
  if (client)
  {
    String request = client.readStringUntil('\r');
    client.flush(); // Clear client buffer

    // Control the LED based on the request
    if (request.indexOf("/LED=ON") != -1)
    {
      digitalWrite(ledPin, HIGH);
    }
    else if (request.indexOf("/LED=OFF") != -1)
    {
      digitalWrite(ledPin, LOW);
    }
    // Send HTTP response
    client.println("HTTP/1.1 200 OK");
    client.println("Content-type:text/html");
    client.println(); // End of headers

    client.stop(); // Close the connection
  }
}