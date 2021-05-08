/***************************************************************************//**
* \file     Funciones que deben impementar los alumnos
*
* \brief    Plantilla para crear función en C para una sFunction de Matlab
*
* \authors  Gonzalo Carrasco
*******************************************************************************/

/******************************************************************************
**      HEADER FILES
******************************************************************************/
#include <template.h>
#include <stdint.h>
#include <stdbool.h>

/******************************************************************************
**      MODULE PREPROCESSOR CONSTANTS
******************************************************************************/
#define n (10) 

/******************************************************************************
**      MODULE MACROS
******************************************************************************/


/******************************************************************************
**      MODULE DATATYPES
******************************************************************************/


/******************************************************************************
**      MODULE VARIABLE DEFINITIONS
******************************************************************************/


/******************************************************************************
**      PRIVATE FUNCTION DECLARATIONS (PROTOTYPES)
******************************************************************************/


/******************************************************************************
**      FUNCTION DEFINITIONS
******************************************************************************/

/***************************************************************************//**
*   \brief Implementación de linea de retardo mediante buffer lineal
*
*   \param  input : Arreglo de datos de la señal
*	\param  n     : Muestras del Retardo
*
*   \return Void.
*******************************************************************************/
double retardo_lineal(double input) {
	// Buffer lineal

	static double buffer[n]; //{actual, 1 retardo, 2 retardos...} 

	static bool flag = true;
	if (flag) {
		for (int i = 0; i < n; i++) {
			buffer[i] = 0;
		}
		flag = false;
	}

	double output = buffer[n - 1];

	for (int idx = n - 2; idx >= 1; idx--) {
		buffer[idx + 1] = buffer[idx];
	}
	buffer[0] = input;

	return output;
}



	/*static double* buffer = (double*)malloc( n * sizeof(double));


	static bool flag = true;

	if (flag) {
		for (int i = 0; i < n; i++) {
			*(buffer + i) = 0;
		}
		flag = false;
	}
	 

	double* idx = NULL;

	double output = &(buffer + (n - 1));

	for (int i = n-2; i >= 1; i--) {
		idx = buffer + i;
		*idx = *idx -1;	
	}

	*buffer = input;

	return output;
}*/


/*double funcion(double input)
{
	double output = 0.0;
	
	output = 2.5 * input;
	return output;
}*/



/******************************************************************************
**      END OF SOURCE FILE
******************************************************************************/
