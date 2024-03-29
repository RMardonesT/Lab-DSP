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

/******************************************************************************
**      MODULE PREPROCESSOR CONSTANTS
******************************************************************************/


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

extern double notch(double);



/******************************************************************************
**      FUNCTION DEFINITIONS
******************************************************************************/

extern double notch(double data)
{
  return filterBiquad(&Notch440 , data);
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
            - filterNState->bqA1*filterNState->bqOutput[1]
            - filterNState->bqA2*filterNState->bqOutput[2];

  filterNState->bqOutput[0] = y;
  return y;


}
