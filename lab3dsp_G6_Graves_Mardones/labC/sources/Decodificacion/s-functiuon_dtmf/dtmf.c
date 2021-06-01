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
#include <dtmf.h>
#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
**      MODULE PREPROCESSOR CONSTANTS
******************************************************************************/


/******************************************************************************
**      MODULE MACROS
******************************************************************************/
#define DTMF_ENV_FRAME_SIZE     (32)  // 1ms
#define DTMF_DET_LEVEL          (0.002)
#define DTMF_CH_SNR_RATE        (2.5)

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

/******************************************************************************
**      MODULE VARIABLE DEFINITIONS
******************************************************************************/

/*---------------------------------------------------------------------------*/
/* VARABLES DECTOR DTMF */
/*---------------------------------------------------------------------------*/
/* Se�ales de salida para cada filtro */
double gDtmfTones[7] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};

int32_t gFramePos = 0;
double gTonesAmplitud[7] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
double gTonesAmpAux[7] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};

/*---------------------------------------------------------------------------*/
/* VARABLES BPF */
/*---------------------------------------------------------------------------*/

bqState_t BPF0 = {
                      -1.903126979607119,  // a1
                      0.976711340720306, // a2
                       0.988355670360153 , //b0
                      0, //b1
                      0.988355670360153,  //b2

                      {0 ,0 ,0}, //Inputs buffer
                      {0,0,0} //Outputs buffer
                    };

bqState_t BPF1 = {
                       -1.887029833673787,  // a1
                      0.976711340720306, // a2

                       0.988355670360153 , //b0
                      0, //b1
                      0.988355670360153,  //b2

                      {0 ,0 ,0}, //Inputs buffer
                      {0,0,0} //Outputs buffer
                    };

bqState_t BPF2 = {
                       -1.867099603225501,  // a1
                       0.976711340720306, // a2

                       0.988355670360153 , //b0
                      0, //b1
                     0.988355670360153,  //b2

                      {0 ,0 ,0}, //Inputs buffer
                      {0,0,0} //Outputs buffer
                    };

bqState_t BPF3 = {
                      -1.829076081417365,  // a1
                      0.961481451595328, // a2

                       0.980740725797664 , //b0
                      0, //b1
                     0.980740725797664,  //b2

                      {0 ,0 ,0}, //Inputs buffer
                      {0,0,0} //Outputs buffer
                    };

bqState_t BPF4 = {
                     -1.744534596215547,  // a1
                     0.961481451595328, // a2

                       0.980740725797664  , //b0
                      0, //b1
                    0.980740725797664,  //b2

                      {0 ,0 ,0}, //Inputs buffer
                      {0,0,0} //Outputs buffer
                    };

bqState_t BPF5 = {
                     -1.697664805622379,  // a1
                      0.961481451595328, // a2

                       0.980740725797664  , //b0
                      0, //b1
                    0.980740725797664,  //b2

                      {0 ,0 ,0}, //Inputs buffer
                      {0,0,0} //Outputs buffer
                    };

bqState_t BPF6 = {
                     -1.640688189104886,  // a1
                    0.961481451595328, // a2

                        0.980740725797664   , //b0
                      0, //b1
                   0.980740725797664 ,  //b2

                      {0 ,0 ,0}, //Inputs buffer
                      {0,0,0} //Outputs buffer
                    };



/******************************************************************************
**      PRIVATE FUNCTION DECLARATIONS (PROTOTYPES)
******************************************************************************/
void envelopeDetector(double *tonesInputs);
int32_t dtmfDetection(double *tonesInputs);
static double filterBiquad(bqState_t *filterNState, double filterInput);

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
            - filterNState->bqA1*filterNState->bqOutput[1]
            - filterNState->bqA2*filterNState->bqOutput[2];

  filterNState->bqOutput[0] = y;
  return y;


}
/***************************************************************************//**
*   \brief
*
*   \param  input :
*
*   \return Void.
*******************************************************************************/
extern  int32_t decodeDtmf(double input1, int32_t *output1)
{
  gDtmfTones[0] = filterBiquad(&BPF0,input1);
  gDtmfTones[1] = filterBiquad(&BPF1,input1);
  gDtmfTones[2] = filterBiquad(&BPF2,input1);
  gDtmfTones[3] = filterBiquad(&BPF3,input1);
  gDtmfTones[4] = filterBiquad(&BPF4,input1);
  gDtmfTones[5] = filterBiquad(&BPF5,input1);
  gDtmfTones[6] = filterBiquad(&BPF6,input1);

  dtmfDetection(gDtmfTones);
}


/******************************************************************************
*   \brief Funci�n que actualiza el estado de los leds para indicar s�mbolo
*           detectado en base a reconocer DTFM.
*           Al retornar de esta funci�n, los led se actualizan con el �ltimo
*           s�mbolo detectado.

*   \param *tonesInputs : puntero a arreglo de canales filtrados
*
*   \return Void
******************************************************************************/


int32_t dtmfDetection(double *tonesInputs)
{
    double levelAux;
	int32_t dtmfSymbol = 0;
    int32_t dtmfRow = 0;
    int32_t dtmfCol = 0;
    /*-----------------------------------------------------------------------*/
    /* Actualizaci�n de amplitudes */
    envelopeDetector(tonesInputs);

    /* Promedio de canales */
    levelAux = 0.143 * ( gTonesAmplitud[0] +
            gTonesAmplitud[1] +
            gTonesAmplitud[2] +
            gTonesAmplitud[3] +
            gTonesAmplitud[4] +
            gTonesAmplitud[5] +
            gTonesAmplitud[6] );
    /*-----------------------------------------------------------------------*/
    /* Detecci�n de canal bajo */
    do
    {
        /* �Ser� fila 1? */
        levelAux = gTonesAmplitud[0] / (gTonesAmplitud[1] + gTonesAmplitud[2] +gTonesAmplitud[3]);
        if (levelAux > DTMF_CH_SNR_RATE)
        {
            dtmfRow = 1;
            break;
        }
        /* �Ser� fila 2? */
        levelAux = gTonesAmplitud[1] / (gTonesAmplitud[0] + gTonesAmplitud[2] +gTonesAmplitud[3]);
        if (levelAux > DTMF_CH_SNR_RATE)
        {
            dtmfRow = 2;
            break;
        }
        /* �Ser� fila 3? */
        levelAux = gTonesAmplitud[2] / (gTonesAmplitud[1] + gTonesAmplitud[0] +gTonesAmplitud[3]);
        if (levelAux > DTMF_CH_SNR_RATE)
        {
            dtmfRow = 3;
            break;
        }
        /* �Ser� fila 4? */
        levelAux = gTonesAmplitud[3] / (gTonesAmplitud[1] + gTonesAmplitud[2] +gTonesAmplitud[0]);
        if (levelAux > DTMF_CH_SNR_RATE)
        {
            dtmfRow = 4;
            break;
        }

    } while(0);

    /*-----------------------------------------------------------------------*/
    /* Detecci�n de canal alto */
    do
    {
        /* �Ser� columna 1? */
        levelAux = gTonesAmplitud[4] / (gTonesAmplitud[5] + gTonesAmplitud[6]);
        if (levelAux > DTMF_CH_SNR_RATE)
        {
            dtmfCol = 1;
            break;
        }
        /* �Ser� columna 2? */
        levelAux = gTonesAmplitud[5] / (gTonesAmplitud[4] + gTonesAmplitud[6]);
        if (levelAux > DTMF_CH_SNR_RATE)
        {
            dtmfCol = 2;
            break;
        }
        /* �Ser� columna 3? */
        levelAux = gTonesAmplitud[6] / (gTonesAmplitud[4] + gTonesAmplitud[5]);
        if (levelAux > DTMF_CH_SNR_RATE)
        {
            dtmfCol = 3;
            break;
        }

    } while(0);

    /*-----------------------------------------------------------------------*/
    /* Decodificaci�n de n�mero de s�mbolo */
    if ( ( dtmfRow >= 1 ) && (dtmfCol >= 1) )
	{
        dtmfSymbol = dtmfCol + 3*(dtmfRow - 1);
	}
    else
	{
        dtmfSymbol = 0;
	}

	return (dtmfSymbol);
}

/******************************************************************************
*   \brief Esta funci�n permite detectar de forma sencilla la envolvente
*           de los tonos filtrados.
*           Una vez se retorna de la funci�n quedan actualizados los valores
*           de la variable 'gTonesAmplitud'.

*   \param *tonesInputs : puntero a arreglo de canales filtrados
*
*   \return Void
******************************************************************************/
void envelopeDetector(double *tonesInputs)
{
    int32_t idxTones;

    if( fabs( tonesInputs[0] ) > gTonesAmpAux[0])
        gTonesAmpAux[0] = fabs( tonesInputs[0] );
    if( fabs( tonesInputs[1] ) > gTonesAmpAux[1])
        gTonesAmpAux[1] = fabs( tonesInputs[1] );
    if( fabs( tonesInputs[2] ) > gTonesAmpAux[2])
        gTonesAmpAux[2] = fabs( tonesInputs[2] );
    if( fabs( tonesInputs[3] ) > gTonesAmpAux[3])
        gTonesAmpAux[3] = fabs( tonesInputs[3] );
    if( fabs( tonesInputs[4] ) > gTonesAmpAux[4])
        gTonesAmpAux[4] = fabs( tonesInputs[4] );
    if( fabs( tonesInputs[5] ) > gTonesAmpAux[5])
        gTonesAmpAux[5] = fabs( tonesInputs[5] );
    if( fabs( tonesInputs[6] ) > gTonesAmpAux[6])
        gTonesAmpAux[6] = fabs( tonesInputs[6] );

    gFramePos++;
    if ( gFramePos > DTMF_ENV_FRAME_SIZE )
    {
        gFramePos = 0;

        for (idxTones = 0; idxTones < 7; idxTones++)
        {
            gTonesAmplitud[idxTones] = 0.5 * (gTonesAmpAux[idxTones] + gTonesAmplitud[idxTones]);
            gTonesAmpAux[idxTones] = 0.0;
        }

    }

}

/******************************************************************************
**      END OF SOURCE FILE
******************************************************************************/
