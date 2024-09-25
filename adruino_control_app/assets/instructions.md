# Demo Instruction Page

Welcome to the demo application! This page provides detailed instructions on how to use the app effectively and configure new pins for control.

## Usage Instructions

### Main Code Snippet for Lookup

The following code snippet demonstrates how to control an ID based on incoming requests:

```arduino
// Control the ID based on the request
if (request.indexOf("/ID=ON") != -1) {
  digitalWrite(DEMO_PIN, HIGH);
} else if (request.indexOf("/ID=OFF") != -1) {
  digitalWrite(DEMO_PIN, LOW);
}
```

**To control a different pin, simply change the identifier (ID) in the request URL. For example, if you want to control a pin named LED, you would modify the requests as follows:**

- To turn the led ON: /LED=ON
- To turn the led OFF: /LED=OFF

## Adding New Pin Configurations to the App
To add a new pin configuration to the app, follow these steps:

### Identify the Pin:
In the ID field, enter the ID exactly as it is used in your Arduino code. For the previous example, the ID would be ID.

### Update the Code:
If you are adding a new pin, ensure that you include a similar block of code in your Arduino sketch. For example, to add a pin named LED, you would write:
arduino

```arduino
// Control the LED based on the request
if (request.indexOf("/LED=ON") != -1) {
  digitalWrite(ledPin, HIGH);
} else if (request.indexOf("/LED=OFF") != -1) {
  digitalWrite(ledPin, LOW);
}
```
### Configure the App:
In the app, 
- navigate to the configuration section where you can add new pins. 
- Enter the ID for the new pin (e.g., LED) in the appropriate field.

### Test the Configuration:
After updating the code and adding the new pin configuration in the app, test the functionality by sending requests to control the new pin. You can use a web browser or a tool like Postman to send requests:
- To turn the led ON: /LED=ON
- To turn the led OFF: /LED=OFF

### Important Notes
- Ensure that the pin numbers in your Arduino code match the physical connections on your hardware.
- Always test your configurations in a safe environment to prevent any damage to your components.
- If you encounter any issues, check the serial monitor for error messages or debugging information.

By following these instructions, you can easily add and control new pins in your application! If you have any questions or need further assistance, feel free to reach out for support.