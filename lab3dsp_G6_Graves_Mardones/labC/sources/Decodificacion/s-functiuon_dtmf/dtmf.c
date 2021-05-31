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
double gDtmfTones[7]] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};

int32_t gFramePos = 0;
double gTonesAmplitud[7] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
double gTonesAmpAux[7] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};

/*---------------------------------------------------------------------------*/
/* VARABLES BPF */
/*---------------------------------------------------------------------------*/


/******************************************************************************
**      PRIVATE FUNCTION DECLARATIONS (PROTOTYPES)
******************************************************************************/
void envelopeDetector(double *tonesInputs);
int32_t dtmfDetection(double *tonesInputs);


/******************************************************************************
**      FUNCTION DEFINITIONS
******************************************************************************/

/***************************************************************************//**
*   \brief 
*
*   \param  input : 
*
*   \return Void.
*******************************************************************************/
void decodeDtmf(double input1, int32_t *output1)
{

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
