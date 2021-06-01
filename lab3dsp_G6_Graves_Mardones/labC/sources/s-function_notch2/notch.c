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
#include <notch.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>

/******************************************************************************
**      MODULE PREPROCESSOR CONSTANTS
******************************************************************************/
const double PI = (3.141592653589793);

/******************************************************************************
**      MODULE MACROS
******************************************************************************/


/******************************************************************************
**      MODULE DATATYPES
******************************************************************************/
/*
 * Estructura de estado de filtros biquad
 */
typedef struct bqState_t {
    double bqA1;
    double bqA2;
    double bqB0;
    double bqB1;
    double bqB2;
    double bqInput[3];
    double bqOutput[3];
} bqState_t;

/*---------------------------------------------------------------------------*/
/* VARABLES FILTRO NOTCH */
/*---------------------------------------------------------------------------*/
bqState_t Notch440 = {
                      -1.932273671,  // a1
                      0.9614814516, // a2
                      0.9807407258, //b0
                      -1.932273671, //b1
                      0.9807407258,  //b2

                      {0 ,0 ,0}, //Inputs buffer
                      {0,0,0} //Outputs buffer
                    };



/******************************************************************************
**      PRIVATE FUNCTION DECLARATIONS (PROTOTYPES)
******************************************************************************/

static double filterBiquad(bqState_t *filterNState, double filterInput);

extern double notch(double data1, double data2);

void filterInterface(double input1, double input2, double* output1);



/******************************************************************************
**      FUNCTION DEFINITIONS
******************************************************************************/

extern double notch(double data1, double data2)
{
    double output;
    filterInterface(data1, data2, &output);
    return output;
}

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


/******************************************************************************
*   \brief  Esta función implementa un filtro notch variable en el tiempo
*
*   \param filterNState     : puntero a la estructura del biquad a ejecutar
*   \param filterInput          : señal de entrada al filtro biquad a ejecutar
*
*   \return filterOutput        : señal de salida del filtro biquad ejecutado
******************************************************************************/

void filterInterface(double input1, double input2, double* output1) {

    //Cálculo parámetros filtro
    double BW    = 2 * PI * 100 / 16000;    //BW Se deja en 100 Hz (norm)
    double theta = 2 * PI * input2 / 16000; //Frecuencia central (norm)

    double p[] = { cos(BW), -2, cos(BW) };
    double d1 = (-p[2] + sqrt(p[2] * p[2] - 4 * p[1] * p[3])) / 2 * p[1];
    double d2 = (-p[2] - sqrt(p[2] * p[2] - 4 * p[1] * p[3])) / 2 * p[1];

    double d;
    if (abs(d1) < abs(d2)) {
        d = d1;
    }
    else {
        d = d2;
    }
    
    //Actualización de parámetros filtro
    static bqState_t Notch_variable = {
                      0,  // a1
                      0, // a2
                      0, //b0
                      0,//b1
                      0,  //b2

                      {0, 0, 0}, //Inputs buffer
                      {0, 0, 0} //Outputs buffer
    };

    (&Notch_variable)->bqA1 = -(1 + d) * cos(theta);
    (&Notch_variable)->bqA2 = d;
    (&Notch_variable)->bqB0 = (1 + d) / 2;
    (&Notch_variable)->bqB1 = (1 + d) / 2 * -2 * cos(theta);
    (&Notch_variable)->bqB2 = (1 + d) / 2;


    //Llamado a funcion de filtrado y seteo de salida
    *output1 = filterBiquad(&Notch_variable, input1);
}

