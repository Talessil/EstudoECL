//EXPORT DO ARQUIVO (DEFINIDO COMO O CONJUNTO DE DADOS) PARA OUTRAS DEFINIÇÕES EXISTENTES NO MESMO MÓDULO

IMPORT Matriculas;
EXPORT File_Matricula := DATASET('~thor::matriculas',Matriculas.Layout_Matricula,CSV(heading(1),separator('|'),quote('')));
