# Assign pins
setPinAssignMode -pinEditInBatch true

# Bottom edge
# Assign Core0 output pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection counterclockwise	\
	-side Bottom				\
	-layer 4				\
	-spreadType center			\
	-spacing 4				\
	-pin {out[0]   out[1]   out[2]   out[3]   out[4]   out[5]   out[6]   out[7]	\
		out[8]   out[9]   out[10]  out[11]  out[12]  out[13]  out[14]  out[15]  \
		out[16]  out[17]  out[18]  out[19]  out[20]  out[21]  out[22]  out[23]	\
		out[24]  out[25]  out[26]  out[27]  out[28]  out[29]  out[30]  out[31]	\
		out[32]  out[33]  out[34]  out[35]  out[36]  out[37]  out[38]  out[39]	\
		out[40]  out[41]  out[42]  out[43]  out[44]  out[45]  out[46]  out[47]	\
		out[48]  out[49]  out[50]  out[51]  out[52]  out[53]  out[54]  out[55]	\
		out[56]  out[57]  out[58]  out[59]  out[60]  out[61]  out[62]  out[63]  \
		out[64]  out[65]  out[66]  out[67]  out[68]  out[69]  out[70]  out[71]  \
		out[72]  out[73]  out[74]  out[75]  out[76]  out[77]  out[78]  out[79]	\
		out[80]  out[81]  out[82]  out[83]  out[84]  out[85]  out[86]  out[87]  \
		out[88]  out[89]  out[90]  out[91]  out[92]  out[93]  out[94]  out[95]  \
		out[96]  out[97]  out[98]  out[99]  out[100] out[101] out[102] out[103] \
		out[104] out[105] out[106] out[107] out[108] out[109] out[110] out[111] \
		out[112] out[113] out[114] out[115] out[116] out[117] out[118] out[119] \
		out[120] out[121] out[122] out[123] out[124] out[125] out[126] out[127] \
		out[128] out[129] out[130] out[131] out[132] out[133] out[134] out[135] \
		out[136] out[137] out[138] out[139] out[140] out[141] out[142] out[143] \
		out[144] out[145] out[146] out[147] out[148] out[149] out[150] out[151] \
		out[152] out[153] out[154] out[155] out[156] out[157] out[158] out[159]}

# Top edge
# Assign Core1 output pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection clockwise		\
	-side Top				\
	-layer 4				\
	-spreadType center			\
	-spacing 4				\
	-pin {out[319] out[318] out[317] out[316] out[315] out[314] out[313] out[312]	\
		out[311] out[310] out[309] out[308] out[307] out[306] out[305] out[304] \
		out[303] out[302] out[301] out[300] out[299] out[298] out[297] out[296] \
		out[295] out[294] out[293] out[292] out[291] out[290] out[289] out[288] \
		out[287] out[286] out[285] out[284] out[283] out[282] out[281] out[280] \
		out[279] out[278] out[277] out[276] out[275] out[274] out[273] out[272] \
		out[271] out[270] out[269] out[268] out[267] out[266] out[265] out[264] \
		out[263] out[262] out[261] out[260] out[259] out[258] out[257] out[256] \
		out[255] out[254] out[253] out[252] out[251] out[250] out[249] out[248] \
		out[247] out[246] out[245] out[244] out[243] out[242] out[241] out[240] \
		out[239] out[238] out[237] out[236] out[235] out[234] out[233] out[232] \
		out[231] out[230] out[229] out[228] out[227] out[226] out[225] out[224] \
		out[223] out[222] out[221] out[220] out[219] out[218] out[217] out[216] \
		out[215] out[214] out[213] out[212] out[211] out[210] out[209] out[208] \
		out[207] out[206] out[205] out[204] out[203] out[202] out[201] out[200] \
		out[199] out[198] out[197] out[196] out[195] out[194] out[193] out[192] \
		out[191] out[190] out[189] out[188] out[187] out[186] out[185] out[184] \
		out[183] out[182] out[181] out[180] out[179] out[178] out[177] out[176] \
		out[175] out[174] out[173] out[172] out[171] out[170] out[169] out[168] \
		out[167] out[166] out[165] out[164] out[163] out[162] out[161] out[160]}

# Left edge
# Assign input pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection counterclockwise	\
	-side Left				\
	-layer 3				\
	-spreadType center			\
	-spacing 4				\
	-pin {mem_in[127] mem_in[126] mem_in[125] mem_in[124] mem_in[123] mem_in[122] mem_in[121] mem_in[120]	\
		mem_in[119] mem_in[118] mem_in[117] mem_in[116] mem_in[115] mem_in[114] mem_in[113] mem_in[112]	\
		mem_in[111] mem_in[110] mem_in[109] mem_in[108] mem_in[107] mem_in[106] mem_in[105] mem_in[104] \
		mem_in[103] mem_in[102] mem_in[101] mem_in[100] mem_in[99]  mem_in[98]  mem_in[97] mem_in[96]	\
		mem_in[95]  mem_in[94]  mem_in[93]  mem_in[92]  mem_in[91]  mem_in[90]  mem_in[89] mem_in[88]	\
		mem_in[87]  mem_in[86]  mem_in[85]  mem_in[84]  mem_in[83]  mem_in[82]  mem_in[81] mem_in[80]	\
		mem_in[79]  mem_in[78]  mem_in[77]  mem_in[76]  mem_in[75]  mem_in[74]  mem_in[73] mem_in[72]	\
		mem_in[71]  mem_in[70]  mem_in[69]  mem_in[68]  mem_in[67]  mem_in[66]  mem_in[65] mem_in[64]	\
		clk reset	\
		mem_in[0]   mem_in[1]   mem_in[2]   mem_in[3]   mem_in[4]   mem_in[5]   mem_in[6]  mem_in[7] 	\
		mem_in[8]   mem_in[9]   mem_in[10]  mem_in[11]  mem_in[12]  mem_in[13]  mem_in[14] mem_in[15]	\
		mem_in[16]  mem_in[17]  mem_in[18]  mem_in[19]  mem_in[20]  mem_in[21]  mem_in[22] mem_in[23]	\
		mem_in[24]  mem_in[25]  mem_in[26]  mem_in[27]  mem_in[28]  mem_in[29]  mem_in[30] mem_in[31]	\
		mem_in[32]  mem_in[33]  mem_in[34]  mem_in[35]  mem_in[36]  mem_in[37]  mem_in[38] mem_in[39]	\
		mem_in[40]  mem_in[41]  mem_in[42]  mem_in[43]  mem_in[44]  mem_in[45]  mem_in[46] mem_in[47]	\
		mem_in[48]  mem_in[49]  mem_in[50]  mem_in[51]  mem_in[52]  mem_in[53]  mem_in[54] mem_in[55]	\
		mem_in[56]  mem_in[57]  mem_in[58]  mem_in[59]  mem_in[60]  mem_in[61]  mem_in[62] mem_in[63]}

# Right edge
# Assign inst pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection counterclockwise	\
	-side Right				\
	-layer 3				\
	-spreadType center			\
	-spacing 4				\
	-pin {{inst[*]}}

