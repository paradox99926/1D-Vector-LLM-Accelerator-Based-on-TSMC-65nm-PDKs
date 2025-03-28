# Assign pins
setPinAssignMode -pinEditInBatch true

# Assign D pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection counterclockwise	\
	-side Bottom				\
	-layer 4				\
	-spreadType center			\
	-spacing 4				\
	-pin {{D[*]}}

# Assign Q pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection clockwise		\
	-side Top				\
	-layer 4				\
	-spreadType center			\
	-spacing 4				\
	-pin {{Q[*]}}

# Assign other pins
editPin -fixedPin True				\
	-fixOverlap True			\
	-unit MICRON				\
	-spreadDirection counterclockwise	\
	-side Left				\
	-layer 3				\
	-spreadType center			\
	-spacing 4				\
	-pin {{A[*]} CEN CLK WEN}

