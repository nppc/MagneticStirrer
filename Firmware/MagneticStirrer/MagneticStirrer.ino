// The firmware for controlling brushed motor speed in the Magnetic stirrer.
// the PCB is borrowed from mine TinyDiversity as it has place for MCU and mosfet and reasonably small. :)
// MCU: Attiny85 @ 1mhz (default)
// Mosfet: AO3400
// Buttons pins are pulled down externally with 10K resistors
#include <EEPROM.h>

//#define DEBUG

#define MAXPWM  255  // Maximum safe value for motor
#define MINPWM   80  // Minimum value for safe motor start

#define PIN_PWM			PB0
#define PIN_BUTTON1		PB3
#define PIN_BUTTON2		PB4

// don't use first byte of EEPROM. It can be corrupted
#define EEPROM_LAST_PWM	5	// (byte)

uint8_t pwm_val;
unsigned long eestore_millis;

void setupPins() {
	bitSet(DDRB, PIN_PWM);
	bitClear(PORTB, PIN_PWM);
	bitClear(DDRB, PIN_BUTTON1);
	bitClear(DDRB, PIN_BUTTON2);
}

void setup()
{
	setupPins();

	pwm_val = EEPROM.read(EEPROM_LAST_PWM);
	if(pwm_val>MAXPWM){pwm_val=MAXPWM;}
	if(pwm_val<MINPWM){pwm_val=MINPWM;}

	// start motor smoothly
	for(uint8_t i=MINPWM; i<pwm_val; i++){
		analogWrite(PIN_PWM, i);
		mDelay(10);
	}
	analogWrite(PIN_PWM, pwm_val);

	eestore_millis = millis();
}

	
void loop() {
	// read buttons
	//uint8_t but1 = bitRead(PINB, PIN_BUTTON1);
	if(bitRead(PINB, PIN_BUTTON1)==1){
		// if button left pressed for 150ms then increase or decrease pwm
		uint8_t but_valid = 1; // button pressed 
		for(uint8_t i=0; i<15; i++){
			if(bitRead(PINB, PIN_BUTTON1)!=1){
				but_valid = 0;
				break;
			}
			mDelay(10);
		}
		if(but_valid==1){if(pwm_val+10<=MAXPWM){pwm_val+=10;}else{pwm_val=MAXPWM;}}
	}
	if(bitRead(PINB, PIN_BUTTON2)==1){
		// if button left pressed for 150ms then increase or decrease pwm
		uint8_t but_valid = 1; // button pressed 
		for(uint8_t i=0; i<15; i++){
			if(bitRead(PINB, PIN_BUTTON2)!=1){
				but_valid = 0;
				break;
			}
			mDelay(10);
		}
		if(but_valid==1){if(pwm_val-10>=MINPWM){pwm_val-=10;}else{pwm_val=MINPWM;}}
	}  
	analogWrite(PIN_PWM, pwm_val);

	// store PWM value to EEPROM. Check every 30 seconds, but update only if changed
	if(millis() > eestore_millis + 30000){
		EEPROM.update(EEPROM_LAST_PWM, pwm_val);  // Only update if value is changed
		eestore_millis = millis();
	}
}


void mDelay(int dtmp){
	unsigned long tmp = millis();
	while((tmp+dtmp)>millis()){}
}
