// #include <WiFi.h>

const char *ssid = "Arnab";        
const char *password = "12345678"; 

WiFiServer server(80);
// Setup pin according to your wiring
const int ledPin = 13; 

void setup(){
  pinMode(ledPin, OUTPUT);
  Serial.begin(115200);
  WiFi.begin(ssid, password);

  // Wait for the Wi-Fi to connect
  while (WiFi.status() != WL_CONNECTED){
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  // Print IP & Start the server
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP()); 
  server.begin(); 
}

void loop(){
  WiFiClient client = server.available();
  // Read the request if client exist
  if (client){
    String request = client.readStringUntil('\r'); 
    client.flush(); // Clear client buffer

    // Control the LED based on the request
    if (request.indexOf("/LED=ON") != -1){
      digitalWrite(ledPin, HIGH);
    }else if (request.indexOf("/LED=OFF") != -1){
      digitalWrite(ledPin, LOW);
    }
    // Send HTTP response
    client.println("HTTP/1.1 200 OK");
    client.println("Content-type:text/html");
    client.println(); // End of headers
    
    client.stop(); // Close the connection
  }
}