/* Generated Code (IMPORT) */
/* Source File: MotorDeath.xls */
/* Source Path: /folders/myshortcuts/myfolder */
/* Code generated on: 11/11/16, 9:52 AM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/folders/myshortcuts/myfolder/MotorDeath.xls';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLS
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);
options nocenter nodate pageno=1 ls=76 ps=45 nolabel;
proc print data=work.import;
run;
data all;
set work.import;
run;

******************************************************
*1,2Compute the descriptive statistics  and correlation *
******************************************************;
proc corr data =all;
var Deaths Drivers People Mileage Maxtemp Fuel;
title "Descriptive Statistics and Correlation";
run;
*************************************************
*3.Matrix Scatterplot of Deaths and five variables*
*************************************************;
proc sgscatter data = all;
Matrix Deaths Drivers People Mileage Maxtemp Fuel / diagonal=(histogram normal);
run;
*************************************************
*4.Fit the full model (including the 5 predictor variables) to the data.*
*************************************************;
*************************************************
*5. Summarize the model fitting for the full model *
*************************************************;
Proc reg data = all outest = out1;
model Deaths = Drivers People Mileage Maxtemp Fuel / P R Influence;
output out=out2 p=predict r=residual student=student;
run;
proc plot data=out2;
plot residual*predict='*'/vref=0;
plot student*predict='*'/vref=0 vref=2 vref=-2;
run;
ods graphics on;
proc reg data=all;
model Deaths = Drivers People Mileage Maxtemp Fuel / Partial;
run;
ods graphics off;


