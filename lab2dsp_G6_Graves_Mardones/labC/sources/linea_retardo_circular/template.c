/***************************************************************************//**
* \file     Funciones que deben impementar los alumnos
*
* \brief    Plantilla para crear funci�n en C para una sFunction de Matlab
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
#define n (20000)

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
*   \brief Implementaci�n de linea de retardo mediante buffer lineal
*
*   \param  input : Arreglo de datos de la se�al
*	\param  n     : Muestras del Retardo
*
*   \return Void.
*******************************************************************************/
double retardo_circular(double input) {



	static double buffer[n]; //Crea buffer tamaño n
	static  int idx = n-1;  //inicialica el "puntero" idx en la ultima posicion

//Bloque para inicializar el buffer con ceros
	static int flag = 1;

	if (flag == 1) {
		for (int i = 0; i < n; i++) {
			buffer[i] = 0;
		}
		flag = 0;
	}
//Fin inicializacion del Buffer

	double output = buffer[idx]; //Lee dato del Buffer
	buffer[idx] = input;  //Actualiza el dato en posicion idx
	idx = ((idx+1)%n); //Actualiza posicion idx


	return (output);
}

/******************************************************************************
**      END OF SOURCE FILE
******************************************************************************/
