/***************************************************************************//**
* \file     Funciones que deben impementar los alumnos
*
* \brief    
*
* \authors  Gonzalo Carrasco
*******************************************************************************/

/******************************************************************************
**      HEADER FILES
******************************************************************************/
#include <goertzel.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>

/******************************************************************************
**      MODULE PREPROCESSOR CONSTANTS
******************************************************************************/


/******************************************************************************
**      MODULE MACROS
******************************************************************************/
#define SAMPLING_FREQ			(16000)

#define GOERTZEL_N				(256)
/*---------------------------------------------------------------------------*/

/*
 * Bins arbitrarios.
 */
 
#define GOERTZEL1_K_BIN	    	(8)			
#define GOERTZEL2_K_BIN	    	(9)
#define GOERTZEL3_K_BIN	    	(10)
#define GOERTZEL4_K_BIN	    	(11)
#define GOERTZEL5_K_BIN	    	(12)
#define GOERTZEL6_K_BIN	    	(13)
#define GOERTZEL7_K_BIN	    	(14)

/*
 * bins para DTMF con N=256 @16 ksps
 */



/*
 * Constante
 */
#ifndef M_PI
#define M_PI					(3.141592653589793)
#endif

/******************************************************************************
**      MODULE DATATYPES
******************************************************************************/

/*
 * Estructura de estado de filtros goertzel
 */
typedef struct goertzelStateTag {
	uint64_t samplesCounter;
    double cosW;
	double sinW;
	double A1;
    double outputs[3];
	double binReal;
	double binImag;
	double binMag;
} goertzelState_t;

typedef struct bqState_t {
    double bqA1;
    double bqA2;
    double bqB0;
    double bqB1;
    double bqB2;
    double bqInput[3];
    double bqOutput[3];
} bqState_t;

/******************************************************************************
**      MODULE VARIABLE DEFINITIONS
******************************************************************************/


/*---------------------------------------------------------------------------*/
/* VARABLES FILTROS GOERTZEL*/
/*---------------------------------------------------------------------------*/
goertzelState_t gGoertzelState1 = {0};
goertzelState_t gGoertzelState2 = {0};
goertzelState_t gGoertzelState3 = {0};
goertzelState_t gGoertzelState4 = {0};
goertzelState_t gGoertzelState5 = {0};
goertzelState_t gGoertzelState6 = {0};
goertzelState_t gGoertzelState7 = {0};


/******************************************************************************
**      PRIVATE FUNCTION DECLARATIONS (PROTOTYPES)
******************************************************************************/

static double filterBiquad(bqState_t *filterNState, double filterInput);

static void initGoertzel(goertzelState_t *state, uint64_t kFrequency);
static void resetGoertzel(goertzelState_t *state);
static double computeGoertzel(goertzelState_t *state, double filterInput);

/******************************************************************************
**      FUNCTION DEFINITIONS
******************************************************************************/

/******************************************************************************
*   \brief  Esta función implementa una etapa de filtro biquad
*
*   \param filterNState     : puntero a la estructura del biquad a ejecutar
*   \param filterInput          : señal de entrada al filtro biquad a ejecutar
*
*   \return filterOutput        : señal de salida del filtro biquad ejecutado
******************************************************************************/
static double filterBiquad(bqState_t *filterNState, double filterInput)
{
  //Desplazamiento de datos en la linea de retardo de tamaño 3
  filterNState->bqInput[2] = filterNState->bqInput[1];
  filterNState->bqInput[1] = filterNState->bqInput[0];
  filterNState->bqInput[0] = filterInput;

  filterNState->bqOutput[2] = filterNState->bqOutput[1];
  filterNState->bqOutput[1] = filterNState->bqOutput[0];

  //y[n] = -a1*y[n] -a2*y[n-2] + b0*x[n] + b1*x[n-1] + b2*x[n-2]

  double w =   filterNState->bqB0*filterNState->bqInput[0]
              + filterNState->bqB1*filterNState->bqInput[1]
              + filterNState->bqB2*filterNState->bqInput[2];

  double y = w
      - filterNState->bqA1 * filterNState->bqOutput[1]
      - filterNState->bqA2 * filterNState->bqOutput[2];
            
  filterNState->bqOutput[0] = y;
  return y;
}


/***************************************************************************//**
*   \brief Funci�n prncipal llamada por la sFunction
*
*   \param  input : una entrada de se�al desde simulink
*
*   \param  output: salidas hacia simulink
*
*   \return Void.
*******************************************************************************/
void goertzelFunction(double input1,
				double *output1,
				double *output2,
				double *output3,
				double *output4,
				double *output5,
				double *output6,
				double *output7
				)
{   
	*output1 = computeGoertzel(&gGoertzelState1, input1);
	*output2 = computeGoertzel(&gGoertzelState2, input1);
	*output3 = computeGoertzel(&gGoertzelState3, input1);
	*output4 = computeGoertzel(&gGoertzelState4, input1);
	*output5 = computeGoertzel(&gGoertzelState5, input1);
	*output6 = computeGoertzel(&gGoertzelState6, input1);
	*output7 = computeGoertzel(&gGoertzelState7, input1);
}

/******************************************************************************
*   \brief  Esta funci�n se ejecuta una vez cuando se corre la simulaci�n
*           de Simulink. Se usa para inicializar variables y estructuras.
*
*   \return  void
******************************************************************************/
extern void initialization(void)
{	
	initGoertzel( &gGoertzelState1 , GOERTZEL1_K_BIN );
	initGoertzel( &gGoertzelState2 , GOERTZEL2_K_BIN );
	initGoertzel( &gGoertzelState3 , GOERTZEL3_K_BIN );
	initGoertzel( &gGoertzelState4 , GOERTZEL4_K_BIN );
	initGoertzel( &gGoertzelState5 , GOERTZEL5_K_BIN );
	initGoertzel( &gGoertzelState6 , GOERTZEL6_K_BIN );
	initGoertzel( &gGoertzelState6 , GOERTZEL7_K_BIN );

	
	return;
}

/******************************************************************************
*   \brief  Esta funci�n inicializa un filtro goertzel
*
*   \param state                : puntero a la estructura del filtro a ejecutar
*   \param kFrequency           : bin de frecuencia a calcular
*
*   \return filterOutput        : se�al de salida del filtro goertzel ejecutado
******************************************************************************/
static void initGoertzel(goertzelState_t *state, uint64_t kFrequency)
{
	// TO-DO
	// Inicializar las variables y par�metros de la estructura de estado
	// en funci�n de las constantes M_PI, GOERTZEL_N  y el argumento kFrequency.
	state->samplesCounter 	= 0;
  state->cosW = cos(2*M_PI*kFrequency/GOERTZEL_N);
  state->sinW = sin(2*M_PI*kFrequency/GOERTZEL_N);
  state->A1  = 2*cos(2*M_PI*kFrequency/GOERTZEL_N);

  state->outputs[0] = 0.0;
  state->outputs[1] = 0.0;
  state->outputs[2] = 0.0;

  state->binReal =0;
  state->binImag=0;
  state->binMag = 0;
	// state->
    //...
	
	return;
}

/******************************************************************************
*   \brief  Esta funci�n pone en cero los estados de un filtro goertzel
*
*   \param state                : puntero a la estructura del filtro a ejecutar
*
******************************************************************************/
static void resetGoertzel(goertzelState_t *state)
{
	state->samplesCounter 	= 0;
    state->outputs[0] 		= 0.0;
	state->outputs[1] 		= 0.0;
	state->outputs[2] 		= 0.0;
	// Se quere retener el �ltimo resultado para el bin sin llevarlos a cero
	
	return;
}

/******************************************************************************
*   \brief  Esta funci�n implementa el filtro goertzel
*
*   \param state               : puntero a la estructura del filtro a ejecutar
*   \param filterInput          : se�al de entrada al filtro biquad a ejecutar
*
*   \return filterOutput        : se�al de salida del filtro goertzel ejecutado
******************************************************************************/
static double computeGoertzel(goertzelState_t *state, double filterInput)
{
	// TO-DO
	// Completar todo el algoritmo de Goertzel  usando la estructura de estado,
	// filterInput y GOERTZEL_N
	// Existe la funci�n sqrt() provista por el <math.h>

	// Se crea estructura bqState para aplicar filtro
	static bqState_t* iirGoertzel = {
                      -2*(state->cosW),  // a1
                      1,      		     // a2
                      0, 				 // b0
                      0, 				 // b1
                      1,  				 // b2

                      {0 ,0 ,0},         //Inputs buffer
                      {0,0,0}            //Outputs buffer
                    };

	if ((state->samplesCounter) < (N-1) ){
		
	}

	else
	

	
	
	
	return state->binMag;						
}

/******************************************************************************
**      END OF SOURCE FILE
******************************************************************************/
