module mac_64in (out, a, b);

parameter bw = 8;
parameter bw_psum = 2*bw+6;
parameter pr = 64; // parallel factor: number of inputs = 64

output signed [bw_psum-1:0] out;
input signed  [pr*bw-1:0] a;
input signed  [pr*bw-1:0] b;


wire	signed	[2*bw-1:0]	product0	;
wire	signed	[2*bw-1:0]	product1	;
wire	signed	[2*bw-1:0]	product2	;
wire	signed	[2*bw-1:0]	product3	;
wire	signed	[2*bw-1:0]	product4	;
wire	signed	[2*bw-1:0]	product5	;
wire	signed	[2*bw-1:0]	product6	;
wire	signed	[2*bw-1:0]	product7	;
wire	signed	[2*bw-1:0]	product8	;
wire	signed	[2*bw-1:0]	product9	;
wire	signed	[2*bw-1:0]	product10	;
wire	signed	[2*bw-1:0]	product11	;
wire	signed	[2*bw-1:0]	product12	;
wire	signed	[2*bw-1:0]	product13	;
wire	signed	[2*bw-1:0]	product14	;
wire	signed	[2*bw-1:0]	product15	;
wire	signed	[2*bw-1:0]	product16	;
wire	signed	[2*bw-1:0]	product17	;
wire	signed	[2*bw-1:0]	product18	;
wire	signed	[2*bw-1:0]	product19	;
wire	signed	[2*bw-1:0]	product20	;
wire	signed	[2*bw-1:0]	product21	;
wire	signed	[2*bw-1:0]	product22	;
wire	signed	[2*bw-1:0]	product23	;
wire	signed	[2*bw-1:0]	product24	;
wire	signed	[2*bw-1:0]	product25	;
wire	signed	[2*bw-1:0]	product26	;
wire	signed	[2*bw-1:0]	product27	;
wire	signed	[2*bw-1:0]	product28	;
wire	signed	[2*bw-1:0]	product29	;
wire	signed	[2*bw-1:0]	product30	;
wire	signed	[2*bw-1:0]	product31	;
wire	signed	[2*bw-1:0]	product32	;
wire	signed	[2*bw-1:0]	product33	;
wire	signed	[2*bw-1:0]	product34	;
wire	signed	[2*bw-1:0]	product35	;
wire	signed	[2*bw-1:0]	product36	;
wire	signed	[2*bw-1:0]	product37	;
wire	signed	[2*bw-1:0]	product38	;
wire	signed	[2*bw-1:0]	product39	;
wire	signed	[2*bw-1:0]	product40	;
wire	signed	[2*bw-1:0]	product41	;
wire	signed	[2*bw-1:0]	product42	;
wire	signed	[2*bw-1:0]	product43	;
wire	signed	[2*bw-1:0]	product44	;
wire	signed	[2*bw-1:0]	product45	;
wire	signed	[2*bw-1:0]	product46	;
wire	signed	[2*bw-1:0]	product47	;
wire	signed	[2*bw-1:0]	product48	;
wire	signed	[2*bw-1:0]	product49	;
wire	signed	[2*bw-1:0]	product50	;
wire	signed	[2*bw-1:0]	product51	;
wire	signed	[2*bw-1:0]	product52	;
wire	signed	[2*bw-1:0]	product53	;
wire	signed	[2*bw-1:0]	product54	;
wire	signed	[2*bw-1:0]	product55	;
wire	signed	[2*bw-1:0]	product56	;
wire	signed	[2*bw-1:0]	product57	;
wire	signed	[2*bw-1:0]	product58	;
wire	signed	[2*bw-1:0]	product59	;
wire	signed	[2*bw-1:0]	product60	;
wire	signed	[2*bw-1:0]	product61	;
wire	signed	[2*bw-1:0]	product62	;
wire	signed	[2*bw-1:0]	product63	;

wire signed [(2*bw+4)-1:0] psum_tree0;
wire signed [(2*bw+4)-1:0] psum_tree1;
wire signed [(2*bw+4)-1:0] psum_tree2;
wire signed [(2*bw+4)-1:0] psum_tree3;

genvar i;


assign	product0	=	{{(bw){a[bw*	1	-1]}},	a[bw*	1	-1:bw*	0	]}	*	{{(bw){b[bw*	1	-1]}},	b[bw*	1	-1:	bw*	0	]};
assign	product1	=	{{(bw){a[bw*	2	-1]}},	a[bw*	2	-1:bw*	1	]}	*	{{(bw){b[bw*	2	-1]}},	b[bw*	2	-1:	bw*	1	]};
assign	product2	=	{{(bw){a[bw*	3	-1]}},	a[bw*	3	-1:bw*	2	]}	*	{{(bw){b[bw*	3	-1]}},	b[bw*	3	-1:	bw*	2	]};
assign	product3	=	{{(bw){a[bw*	4	-1]}},	a[bw*	4	-1:bw*	3	]}	*	{{(bw){b[bw*	4	-1]}},	b[bw*	4	-1:	bw*	3	]};
assign	product4	=	{{(bw){a[bw*	5	-1]}},	a[bw*	5	-1:bw*	4	]}	*	{{(bw){b[bw*	5	-1]}},	b[bw*	5	-1:	bw*	4	]};
assign	product5	=	{{(bw){a[bw*	6	-1]}},	a[bw*	6	-1:bw*	5	]}	*	{{(bw){b[bw*	6	-1]}},	b[bw*	6	-1:	bw*	5	]};
assign	product6	=	{{(bw){a[bw*	7	-1]}},	a[bw*	7	-1:bw*	6	]}	*	{{(bw){b[bw*	7	-1]}},	b[bw*	7	-1:	bw*	6	]};
assign	product7	=	{{(bw){a[bw*	8	-1]}},	a[bw*	8	-1:bw*	7	]}	*	{{(bw){b[bw*	8	-1]}},	b[bw*	8	-1:	bw*	7	]};
assign	product8	=	{{(bw){a[bw*	9	-1]}},	a[bw*	9	-1:bw*	8	]}	*	{{(bw){b[bw*	9	-1]}},	b[bw*	9	-1:	bw*	8	]};
assign	product9	=	{{(bw){a[bw*	10	-1]}},	a[bw*	10	-1:bw*	9	]}	*	{{(bw){b[bw*	10	-1]}},	b[bw*	10	-1:	bw*	9	]};
assign	product10	=	{{(bw){a[bw*	11	-1]}},	a[bw*	11	-1:bw*	10	]}	*	{{(bw){b[bw*	11	-1]}},	b[bw*	11	-1:	bw*	10	]};
assign	product11	=	{{(bw){a[bw*	12	-1]}},	a[bw*	12	-1:bw*	11	]}	*	{{(bw){b[bw*	12	-1]}},	b[bw*	12	-1:	bw*	11	]};
assign	product12	=	{{(bw){a[bw*	13	-1]}},	a[bw*	13	-1:bw*	12	]}	*	{{(bw){b[bw*	13	-1]}},	b[bw*	13	-1:	bw*	12	]};
assign	product13	=	{{(bw){a[bw*	14	-1]}},	a[bw*	14	-1:bw*	13	]}	*	{{(bw){b[bw*	14	-1]}},	b[bw*	14	-1:	bw*	13	]};
assign	product14	=	{{(bw){a[bw*	15	-1]}},	a[bw*	15	-1:bw*	14	]}	*	{{(bw){b[bw*	15	-1]}},	b[bw*	15	-1:	bw*	14	]};
assign	product15	=	{{(bw){a[bw*	16	-1]}},	a[bw*	16	-1:bw*	15	]}	*	{{(bw){b[bw*	16	-1]}},	b[bw*	16	-1:	bw*	15	]};
assign	product16	=	{{(bw){a[bw*	17	-1]}},	a[bw*	17	-1:bw*	16	]}	*	{{(bw){b[bw*	17	-1]}},	b[bw*	17	-1:	bw*	16	]};
assign	product17	=	{{(bw){a[bw*	18	-1]}},	a[bw*	18	-1:bw*	17	]}	*	{{(bw){b[bw*	18	-1]}},	b[bw*	18	-1:	bw*	17	]};
assign	product18	=	{{(bw){a[bw*	19	-1]}},	a[bw*	19	-1:bw*	18	]}	*	{{(bw){b[bw*	19	-1]}},	b[bw*	19	-1:	bw*	18	]};
assign	product19	=	{{(bw){a[bw*	20	-1]}},	a[bw*	20	-1:bw*	19	]}	*	{{(bw){b[bw*	20	-1]}},	b[bw*	20	-1:	bw*	19	]};
assign	product20	=	{{(bw){a[bw*	21	-1]}},	a[bw*	21	-1:bw*	20	]}	*	{{(bw){b[bw*	21	-1]}},	b[bw*	21	-1:	bw*	20	]};
assign	product21	=	{{(bw){a[bw*	22	-1]}},	a[bw*	22	-1:bw*	21	]}	*	{{(bw){b[bw*	22	-1]}},	b[bw*	22	-1:	bw*	21	]};
assign	product22	=	{{(bw){a[bw*	23	-1]}},	a[bw*	23	-1:bw*	22	]}	*	{{(bw){b[bw*	23	-1]}},	b[bw*	23	-1:	bw*	22	]};
assign	product23	=	{{(bw){a[bw*	24	-1]}},	a[bw*	24	-1:bw*	23	]}	*	{{(bw){b[bw*	24	-1]}},	b[bw*	24	-1:	bw*	23	]};
assign	product24	=	{{(bw){a[bw*	25	-1]}},	a[bw*	25	-1:bw*	24	]}	*	{{(bw){b[bw*	25	-1]}},	b[bw*	25	-1:	bw*	24	]};
assign	product25	=	{{(bw){a[bw*	26	-1]}},	a[bw*	26	-1:bw*	25	]}	*	{{(bw){b[bw*	26	-1]}},	b[bw*	26	-1:	bw*	25	]};
assign	product26	=	{{(bw){a[bw*	27	-1]}},	a[bw*	27	-1:bw*	26	]}	*	{{(bw){b[bw*	27	-1]}},	b[bw*	27	-1:	bw*	26	]};
assign	product27	=	{{(bw){a[bw*	28	-1]}},	a[bw*	28	-1:bw*	27	]}	*	{{(bw){b[bw*	28	-1]}},	b[bw*	28	-1:	bw*	27	]};
assign	product28	=	{{(bw){a[bw*	29	-1]}},	a[bw*	29	-1:bw*	28	]}	*	{{(bw){b[bw*	29	-1]}},	b[bw*	29	-1:	bw*	28	]};
assign	product29	=	{{(bw){a[bw*	30	-1]}},	a[bw*	30	-1:bw*	29	]}	*	{{(bw){b[bw*	30	-1]}},	b[bw*	30	-1:	bw*	29	]};
assign	product30	=	{{(bw){a[bw*	31	-1]}},	a[bw*	31	-1:bw*	30	]}	*	{{(bw){b[bw*	31	-1]}},	b[bw*	31	-1:	bw*	30	]};
assign	product31	=	{{(bw){a[bw*	32	-1]}},	a[bw*	32	-1:bw*	31	]}	*	{{(bw){b[bw*	32	-1]}},	b[bw*	32	-1:	bw*	31	]};
assign	product32	=	{{(bw){a[bw*	33	-1]}},	a[bw*	33	-1:bw*	32	]}	*	{{(bw){b[bw*	33	-1]}},	b[bw*	33	-1:	bw*	32	]};
assign	product33	=	{{(bw){a[bw*	34	-1]}},	a[bw*	34	-1:bw*	33	]}	*	{{(bw){b[bw*	34	-1]}},	b[bw*	34	-1:	bw*	33	]};
assign	product34	=	{{(bw){a[bw*	35	-1]}},	a[bw*	35	-1:bw*	34	]}	*	{{(bw){b[bw*	35	-1]}},	b[bw*	35	-1:	bw*	34	]};
assign	product35	=	{{(bw){a[bw*	36	-1]}},	a[bw*	36	-1:bw*	35	]}	*	{{(bw){b[bw*	36	-1]}},	b[bw*	36	-1:	bw*	35	]};
assign	product36	=	{{(bw){a[bw*	37	-1]}},	a[bw*	37	-1:bw*	36	]}	*	{{(bw){b[bw*	37	-1]}},	b[bw*	37	-1:	bw*	36	]};
assign	product37	=	{{(bw){a[bw*	38	-1]}},	a[bw*	38	-1:bw*	37	]}	*	{{(bw){b[bw*	38	-1]}},	b[bw*	38	-1:	bw*	37	]};
assign	product38	=	{{(bw){a[bw*	39	-1]}},	a[bw*	39	-1:bw*	38	]}	*	{{(bw){b[bw*	39	-1]}},	b[bw*	39	-1:	bw*	38	]};
assign	product39	=	{{(bw){a[bw*	40	-1]}},	a[bw*	40	-1:bw*	39	]}	*	{{(bw){b[bw*	40	-1]}},	b[bw*	40	-1:	bw*	39	]};
assign	product40	=	{{(bw){a[bw*	41	-1]}},	a[bw*	41	-1:bw*	40	]}	*	{{(bw){b[bw*	41	-1]}},	b[bw*	41	-1:	bw*	40	]};
assign	product41	=	{{(bw){a[bw*	42	-1]}},	a[bw*	42	-1:bw*	41	]}	*	{{(bw){b[bw*	42	-1]}},	b[bw*	42	-1:	bw*	41	]};
assign	product42	=	{{(bw){a[bw*	43	-1]}},	a[bw*	43	-1:bw*	42	]}	*	{{(bw){b[bw*	43	-1]}},	b[bw*	43	-1:	bw*	42	]};
assign	product43	=	{{(bw){a[bw*	44	-1]}},	a[bw*	44	-1:bw*	43	]}	*	{{(bw){b[bw*	44	-1]}},	b[bw*	44	-1:	bw*	43	]};
assign	product44	=	{{(bw){a[bw*	45	-1]}},	a[bw*	45	-1:bw*	44	]}	*	{{(bw){b[bw*	45	-1]}},	b[bw*	45	-1:	bw*	44	]};
assign	product45	=	{{(bw){a[bw*	46	-1]}},	a[bw*	46	-1:bw*	45	]}	*	{{(bw){b[bw*	46	-1]}},	b[bw*	46	-1:	bw*	45	]};
assign	product46	=	{{(bw){a[bw*	47	-1]}},	a[bw*	47	-1:bw*	46	]}	*	{{(bw){b[bw*	47	-1]}},	b[bw*	47	-1:	bw*	46	]};
assign	product47	=	{{(bw){a[bw*	48	-1]}},	a[bw*	48	-1:bw*	47	]}	*	{{(bw){b[bw*	48	-1]}},	b[bw*	48	-1:	bw*	47	]};
assign	product48	=	{{(bw){a[bw*	49	-1]}},	a[bw*	49	-1:bw*	48	]}	*	{{(bw){b[bw*	49	-1]}},	b[bw*	49	-1:	bw*	48	]};
assign	product49	=	{{(bw){a[bw*	50	-1]}},	a[bw*	50	-1:bw*	49	]}	*	{{(bw){b[bw*	50	-1]}},	b[bw*	50	-1:	bw*	49	]};
assign	product50	=	{{(bw){a[bw*	51	-1]}},	a[bw*	51	-1:bw*	50	]}	*	{{(bw){b[bw*	51	-1]}},	b[bw*	51	-1:	bw*	50	]};
assign	product51	=	{{(bw){a[bw*	52	-1]}},	a[bw*	52	-1:bw*	51	]}	*	{{(bw){b[bw*	52	-1]}},	b[bw*	52	-1:	bw*	51	]};
assign	product52	=	{{(bw){a[bw*	53	-1]}},	a[bw*	53	-1:bw*	52	]}	*	{{(bw){b[bw*	53	-1]}},	b[bw*	53	-1:	bw*	52	]};
assign	product53	=	{{(bw){a[bw*	54	-1]}},	a[bw*	54	-1:bw*	53	]}	*	{{(bw){b[bw*	54	-1]}},	b[bw*	54	-1:	bw*	53	]};
assign	product54	=	{{(bw){a[bw*	55	-1]}},	a[bw*	55	-1:bw*	54	]}	*	{{(bw){b[bw*	55	-1]}},	b[bw*	55	-1:	bw*	54	]};
assign	product55	=	{{(bw){a[bw*	56	-1]}},	a[bw*	56	-1:bw*	55	]}	*	{{(bw){b[bw*	56	-1]}},	b[bw*	56	-1:	bw*	55	]};
assign	product56	=	{{(bw){a[bw*	57	-1]}},	a[bw*	57	-1:bw*	56	]}	*	{{(bw){b[bw*	57	-1]}},	b[bw*	57	-1:	bw*	56	]};
assign	product57	=	{{(bw){a[bw*	58	-1]}},	a[bw*	58	-1:bw*	57	]}	*	{{(bw){b[bw*	58	-1]}},	b[bw*	58	-1:	bw*	57	]};
assign	product58	=	{{(bw){a[bw*	59	-1]}},	a[bw*	59	-1:bw*	58	]}	*	{{(bw){b[bw*	59	-1]}},	b[bw*	59	-1:	bw*	58	]};
assign	product59	=	{{(bw){a[bw*	60	-1]}},	a[bw*	60	-1:bw*	59	]}	*	{{(bw){b[bw*	60	-1]}},	b[bw*	60	-1:	bw*	59	]};
assign	product60	=	{{(bw){a[bw*	61	-1]}},	a[bw*	61	-1:bw*	60	]}	*	{{(bw){b[bw*	61	-1]}},	b[bw*	61	-1:	bw*	60	]};
assign	product61	=	{{(bw){a[bw*	62	-1]}},	a[bw*	62	-1:bw*	61	]}	*	{{(bw){b[bw*	62	-1]}},	b[bw*	62	-1:	bw*	61	]};
assign	product62	=	{{(bw){a[bw*	63	-1]}},	a[bw*	63	-1:bw*	62	]}	*	{{(bw){b[bw*	63	-1]}},	b[bw*	63	-1:	bw*	62	]};
assign	product63	=	{{(bw){a[bw*	64	-1]}},	a[bw*	64	-1:bw*	63	]}	*	{{(bw){b[bw*	64	-1]}},	b[bw*	64	-1:	bw*	63	]};


assign psum_tree0 = 
                {{(4){product0[2*bw-1]}},product0	}
	+	{{(4){ product1 [2*bw-1]}}, product1	}
	+	{{(4){product2[2*bw-1]}},product2	}
	+	{{(4){product3[2*bw-1]}},product3	}
	+	{{(4){product4[2*bw-1]}},product4	}
	+	{{(4){product5[2*bw-1]}},product5	}
	+	{{(4){product6[2*bw-1]}},product6	}
	+	{{(4){product7[2*bw-1]}},product7	}
	+	{{(4){product8[2*bw-1]}},product8	}
	+	{{(4){product9[2*bw-1]}},product9	}
	+	{{(4){product10[2*bw-1]}},product10	}
	+	{{(4){product11[2*bw-1]}},product11	}
	+	{{(4){product12[2*bw-1]}},product12	}
	+	{{(4){product13[2*bw-1]}},product13	}
	+	{{(4){product14[2*bw-1]}},product14	}
	+	{{(4){product15[2*bw-1]}},product15	};


assign psum_tree1 =  
	{{(4){	product16	[2*bw-1]}},	product16	}
+	{{(4){	product17	[2*bw-1]}},	product17	}
+	{{(4){	product18	[2*bw-1]}},	product18	}
+	{{(4){	product19	[2*bw-1]}},	product19	}
+	{{(4){	product20	[2*bw-1]}},	product20	}
+	{{(4){	product21	[2*bw-1]}},	product21	}
+	{{(4){	product22	[2*bw-1]}},	product22	}
+	{{(4){	product23	[2*bw-1]}},	product23	}
+	{{(4){	product24	[2*bw-1]}},	product24	}
+	{{(4){	product25	[2*bw-1]}},	product25	}
+	{{(4){	product26	[2*bw-1]}},	product26	}
+	{{(4){	product27	[2*bw-1]}},	product27	}
+	{{(4){	product28	[2*bw-1]}},	product28	}
+	{{(4){	product29	[2*bw-1]}},	product29	}
+	{{(4){	product30	[2*bw-1]}},	product30	}
+	{{(4){	product31	[2*bw-1]}},	product31	};



assign psum_tree2 =  
	{{(4){	product32	[2*bw-1]}},	product32	}
+	{{(4){	product33	[2*bw-1]}},	product33	}
+	{{(4){	product34	[2*bw-1]}},	product34	}
+	{{(4){	product35	[2*bw-1]}},	product35	}
+	{{(4){	product36	[2*bw-1]}},	product36	}
+	{{(4){	product37	[2*bw-1]}},	product37	}
+	{{(4){	product38	[2*bw-1]}},	product38	}
+	{{(4){	product39	[2*bw-1]}},	product39	}
+	{{(4){	product40	[2*bw-1]}},	product40	}
+	{{(4){	product41	[2*bw-1]}},	product41	}
+	{{(4){	product42	[2*bw-1]}},	product42	}
+	{{(4){	product43	[2*bw-1]}},	product43	}
+	{{(4){	product44	[2*bw-1]}},	product44	}
+	{{(4){	product45	[2*bw-1]}},	product45	}
+	{{(4){	product46	[2*bw-1]}},	product46	}
+	{{(4){	product47	[2*bw-1]}},	product47	};



assign psum_tree3 =  
	{{(4){	product48	[2*bw-1]}},	product48	}
+	{{(4){	product49	[2*bw-1]}},	product49	}
+	{{(4){	product50	[2*bw-1]}},	product50	}
+	{{(4){	product51	[2*bw-1]}},	product51	}
+	{{(4){	product52	[2*bw-1]}},	product52	}
+	{{(4){	product53	[2*bw-1]}},	product53	}
+	{{(4){	product54	[2*bw-1]}},	product54	}
+	{{(4){	product55	[2*bw-1]}},	product55	}
+	{{(4){	product56	[2*bw-1]}},	product56	}
+	{{(4){	product57	[2*bw-1]}},	product57	}
+	{{(4){	product58	[2*bw-1]}},	product58	}
+	{{(4){	product59	[2*bw-1]}},	product59	}
+	{{(4){	product60	[2*bw-1]}},	product60	}
+	{{(4){	product61	[2*bw-1]}},	product61	}
+	{{(4){	product62	[2*bw-1]}},	product62	}
+	{{(4){	product63	[2*bw-1]}},	product63	};

assign out = 
  {{(2){psum_tree0[2*bw+3]}}, psum_tree0} 
+ {{(2){psum_tree1[2*bw+3]}}, psum_tree1} 
+ {{(2){psum_tree2[2*bw+3]}}, psum_tree2} 
+ {{(2){psum_tree3[2*bw+3]}}, psum_tree3}; 


endmodule
