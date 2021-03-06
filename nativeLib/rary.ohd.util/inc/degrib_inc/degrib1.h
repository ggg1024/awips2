#ifndef DEGRIB1_H
#define DEGRIB1_H

#include <stdio.h>
#include "degrib_inc/type.h"
#include "degrib_inc/meta.h"
#include "degrib_inc/degrib2.h"
#include "degrib_inc/inventory.h"

typedef struct {
	char *name, *comment, *unit;
   unit_convert convert;
} GRIB1ParmTable;

typedef struct {
   char *name, *comment, *unit;
   char f_twoPart;
} GRIB1SurfTable;


int GRIB1_Inventory (FILE *fp, long int gribLen, inventoryType * inv);

int ReadGrib1Record (FILE * fp, sChar f_unit, double **Grib_Data,
                     long int *grib_DataLen, grib_MetaData * meta,
                     IS_dataType * IS, long int sect0[SECT0LEN_WORD],
                     long int gribLen, double majEarth, double minEarth);
#endif
