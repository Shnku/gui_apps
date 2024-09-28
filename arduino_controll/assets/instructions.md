
## Usage Instructions

### Main Code Snippet for Lookup

The following code snippet demonstrates how to control an ID based on incoming requests:

```arduino
if (request.indexOf("/ID=ON") != -1) {
  digitalWrite(PIN, HIGH);
} else if (request.indexOf("/ID=OFF") != -1) {
  digitalWrite(PIN, LOW);
}
```
Here,
- To turn the pin ON: /PIN=ON
- To turn the pin OFF: /PIN=OFF


## Adding New Pin Configurations to the App

If you are adding a new pin, ensure that you include a similar block of code in your Arduino sketch. \
For example, to add **a pin named LED**, you would write:
arduino

#### Configure the code:

```arduino
if (request.indexOf("/LED=ON") != -1) {
  digitalWrite(ledPin, HIGH);
} else if (request.indexOf("/LED=OFF") != -1) {
  digitalWrite(ledPin, LOW);
}
```
#### Configure the App:
In the app,\
For example, if you want to control a pin named LED,
**You must named (`ID = LED`).**

