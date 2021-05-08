% Instanciación del objeto
def = legacy_code('initialize');
% Nombre de la s-function
def.SFunctionName = 'retardo_lineal';
% Protiotipo de la función
% Notar es información para Matlab, y el solo acepta nombres de entrada u1,
% u2, etc, y salida y1
% Usar el nombre de la función en C que implementó
def.OutputFcnSpec = 'double y1 = retardo_lineal(double u1)';
% Archivo de cabecera
def.HeaderFiles = {'template.h'};
% Archivo fuente en C
def.SourceFiles = {'template.c'};
% Compilación para la s-function
legacy_code('sfcn_cmex_generate', def)
legacy_code('compile', def)
