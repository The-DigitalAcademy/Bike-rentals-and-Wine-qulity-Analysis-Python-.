 /* Generated Code (IMPORT) */
/* Source File: day.csv */
/* Source Path: /home/u62791211/Bicycle Rental dataset */
/* Code generated on: 1/16/23, 9:48 AM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u62791211/Bicycle Rental dataset/day.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; 
RUN;


%web_open_table(WORK.IMPORT);

/*checking null values*/
proc means data=work.import nmiss n; 
run;

proc means data=work.import;
run;

/*proc freq data=work.import;
run;*/

/*taking out the date column
data cleaned;
set WORK.IMPORT;
drop dteday;
run;
*/

options obs=2000;
proc print data=IMPORT;
run;

ods noproctitle;
ods graphics / imagemap=on;

proc corr data=WORK.IMPORT pearson nosimple noprob 
		plots=scatter(ellipse=prediction alpha=0.05 nvar=6 nwith=6);
	var instant dteday weekday workingday weathersit temp;
	with cnt;
run;

ods noproctitle;
ods graphics / imagemap=on;
proc corr data=WORK.IMPORT pearson nosimple noprob 
		plots=scatter(ellipse=prediction alpha=0.05 nvar=4 nwith=4);
	var atemp hum windspeed casual registered;
	with cnt;
run;

/*dropped columns with small correlation
data cleaned2;
set Work.cleaned;
drop instant season yr mnth holiday weekday workingday weathersit hum windspeed;
run;
*/


ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.IMPORT;
	title height=14pt "temp vs count";
	reg x=temp y=cnt / nomarkers;
	scatter x=temp y=cnt /;
	xaxis grid;
	yaxis grid;
run;

ods graphics / reset;
title;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.IMPORT;
	title height=14pt "atemp vs count";
	reg x=atemp y=cnt / nomarkers;
	scatter x=temp y=cnt /;
	xaxis grid;
	yaxis grid;
run;

ods graphics / reset;
title;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.IMPORT;
	title height=14pt "casual vs count";
	reg x=casual y=cnt / nomarkers;
	scatter x=temp y=cnt /;
	xaxis grid;
	yaxis grid;
run;

ods graphics / reset;
title;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.IMPORT;
	title height=14pt "registered vs count";
	reg x=registered y=cnt / nomarkers;
	scatter x=temp y=cnt /;
	xaxis grid;
	yaxis grid;
run;

ods graphics / reset;
title;

/*Box plots*/
ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.IMPORT;
	title height=14pt "Box plots of Registered";
	vbox registered / category=mnth;
	yaxis grid;
run;

ods graphics / reset;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.IMPORT;
	vbar workingday / group=mnth groupdisplay=cluster stat=percent;
	yaxis grid;
run;

ods graphics / reset;

ods graphics / reset width=6.4in height=4.8in imagemap;

proc sgplot data=WORK.IMPORT;
	title height=14pt "season vs count";
	vbar season / response=cnt group=season groupdisplay=cluster stat=percent;
	yaxis grid;
run;

ods graphics / reset;
title;

proc sgplot data=WORK.IMPORT;
    vbar season / response=cnt;
    xaxis label='Season';
    yaxis label='Count';
    title 'Bicycle Rentals by Season';
run;


