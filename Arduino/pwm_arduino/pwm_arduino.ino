
int led_pin1=44;
int led_pin2=45;

void setup() {
 pinMode(led_pin1,OUTPUT);
 pinMode(led_pin2,OUTPUT);

}

void loop() {

  for(int i=0;i<255;i++){
    analogWrite(led_pin1,i);
    analogWrite(led_pin2,i);
    delay(5);
  }
  delay(10);
  
  for(int i=255;i>0;i--){
    analogWrite(led_pin1,i);
    analogWrite(led_pin2,i);
    delay(5);
  }

  for(int i=0; i<50; i++)
  {
     analogWrite(led_pin1,0);
    analogWrite(led_pin2,0);
    delay(65);
    analogWrite(led_pin1,210);
    analogWrite(led_pin2,210);
    delay(65);
 

}}
