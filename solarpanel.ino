int analogPin = A0;
float sensorValue;
float voltage;

void setup(){
  Serial.begin(9600);
}

void loop(){
  sensorValue = analogRead(analogPin);
  voltage = sensorValue * (5.0 / 1023.0);
  Serial.println(voltage);
  delay(1000);
}
