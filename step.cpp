

int pasos = 13;                                     // pin digital 13 para pulsos del arduino
int direccion = 9;                               // pin digital 9  dar el sentido de giro
int reset = 10;                                     // pin digital 10 para poner en «enable» el motor
int totalpasos = 2000;                     // totalpasos para cantidad de pulsos a dar (pasos)

void setup() {
pinMode(pasos, OUTPUT);            //definimos pasos como salida digital
pinMode(direccion, OUTPUT);     //definimos direccion como salida digital
pinMode(reset, OUTPUT);            //definimos reset como salida digital
}

void loop() {

digitalWrite(reset, LOW);             //Mientras reset este en LOW, el motor permanece apagado
delay(2000);                                    //Retardo en la instruccion
digitalWrite(reset, HIGH);           //Cuando reset se encuentre en HIGH el motor arranca
digitalWrite(direccion, HIGH);   //mandamos direccion al servo

for (int i = 0; i<totalpasos; i++)   //Equivale al numero de vueltas (200 pasos son 360º grados de servo )

{
digitalWrite(pasos, HIGH);                // ponemos a high «pasos»
digitalWrite(pasos, LOW);                  // ponemos a low «pasos»
delayMicroseconds(VELOCIDAD);  // leemos la referencia de velocidad
}
