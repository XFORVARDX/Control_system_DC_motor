
	.DEF _ugol1=R4
	.DEF _ugol2=R6
	.DEF _flag=R8
_3:
	.DB  0x1,0x0
_12:
	.DB  0x80,0xC0
	.DEF __lcd_x=R11
	.DEF __lcd_y=R10
	.DEF __lcd_maxx=R13
_tbl10_G3:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G3:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0
_206:
	.DW  0x00

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x08
	.DW  _3*2

	.DW  0x02
	.DW  __base_y_G2
	.DW  _12*2

	.DW  0x02
	.DW  _p_S56
	.DW  _206*2

	.DW  0
_0xD4: