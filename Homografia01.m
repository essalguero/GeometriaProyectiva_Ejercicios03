clear all;
close all;

AnchoImagen = 10;
AltoImagen = 7.5;

PuntoD_X = 4.59;
PuntoD_Y = 3.1;

PuntoE_X = 5.97;
PuntoE_Y = 2.93;

PuntoF_X = 5.99;
PuntoF_Y = 4.35;

PuntoG_X = 4.58;
PuntoG_Y = 4.26;



%PuntoD_X = 2.15461;
%PuntoD_Y = 3.4221;
%
%PuntoE_X = 2.53777;
%PuntoE_Y = 3.36846;
%
%PuntoF_X = 2.52244;
%PuntoF_Y = 4.12711;
%
%PuntoG_X = 2.14695;
%PuntoG_Y = 4.08879;


%PuntoD_X = 2.70826;
%PuntoD_Y = 3.3271;
%
%PuntoE_X = 3.23533;
%PuntoE_Y = 3.26628;
%
%PuntoF_X = 3.23533;
%PuntoF_Y = 4.15015;
%
%PuntoG_X = 2.69609;
%PuntoG_Y = 4.12988;




img = CargarImagen("./FachadaLQ.jpg");
imshow(img)

filas = rows(img)
columnas = columns(img)

relacionEjeX = columnas / AnchoImagen;
relacionEjeY = filas / AltoImagen;



resultImage = zeros(filas, columnas);

ColumnaPuntoD = relacionEjeX * PuntoD_X
FilaPuntoD = filas - (relacionEjeY  * PuntoD_Y)

ColumnaPuntoE = relacionEjeX * PuntoE_X
FilaPuntoE = filas - (relacionEjeY  * PuntoE_Y)

ColumnaPuntoF = relacionEjeX * PuntoF_X
FilaPuntoF = filas - (relacionEjeY  * PuntoF_Y)

ColumnaPuntoG = relacionEjeX * PuntoG_X
FilaPuntoG = filas - (relacionEjeY  * PuntoG_Y)



AjustePuntoE_Fila = FilaPuntoD
AjustePuntoE_Columna = ColumnaPuntoE

AjustePuntoF_Fila = FilaPuntoG
AjustePuntoF_Columna = ColumnaPuntoF

%AjustePuntoF_Fila = FilaPuntoG
%AjustePuntoF_Columna = ColumnaPuntoE
%
%AjustePuntoG_Fila = FilaPuntoG
%AjustePuntoG_Columna = ColumnaPuntoD

MatrizOriginal = [round(FilaPuntoD),round(ColumnaPuntoD);
round(FilaPuntoE),round(ColumnaPuntoE);round(FilaPuntoF),round(ColumnaPuntoF);
round(FilaPuntoG),round(ColumnaPuntoG)]


MatrizReferencias = [round(FilaPuntoD),round(ColumnaPuntoD);
round(AjustePuntoE_Fila),round(AjustePuntoE_Columna);
round(AjustePuntoF_Fila),round(AjustePuntoF_Columna);
round(FilaPuntoG),round(ColumnaPuntoG)]

%MatrizReferencias = [FilaPuntoD,ColumnaPuntoD;
%AjustePuntoE_Fila, AjustePuntoE_Columna;
%AjustePuntoF_Fila, AjustePuntoF_Columna;
%AjustePuntoG_Fila, AjustePuntoG_Columna]


MHomografia = GenerarHomografia(MatrizOriginal, MatrizReferencias)


for i = [1:filas]
  for j = [1:columnas]

    result = MHomografia * [i, j, 1]';
    result = result / result(3);
    
%    if !(result(1) < 1 || result(1) > filas) && !(result(2) < 1 || result(2) > columnas)
%      resultImage(round(result(1)), round(result(2) + 75)) = img(i, j);
%      %resultImage(i, j) = img(round(result(1)), round(result(2)));
%    endif

    if !(result(1) < 1 || result(1) > filas) && ...
      !(result(2) < 1 || result(2) > columnas)
      resultImage(round(result(1)), round(result(2) + 75)) = img(i, j);
    endif
  end
end

imshow(uint8(resultImage));

rows(resultImage)
columns(resultImage)
