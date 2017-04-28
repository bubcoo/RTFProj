
(* NUMERIC CALCULATION OF POSITION ALL AXES *)
FUNCTION_BLOCK DetectionPositionAxis
	
	// Init part of program set the basic values & constants
		
		// Reset output variables
		InternalPos.Index[0] := 0;
		InternalPos.Index[1] := 0;
		InternalPos.Index[2] := 0;
		InternalPos.Index[3] := 0;
		InternalPos.Index[4] := 0;
		
		// Referent positions
		ActPosHumAxis[0] := RefPosHum[0];
		ActPosHumAxis[1] := RefPosHum[1];
		ActPosHumAxis[2] := RefPosHum[2];
		ActPosHumAxis[3] := RefPosHum[3];
		
		// Previous position
		InternalPos.CurrentPosition[0] := RefPosHum[0];
		InternalPos.CurrentPosition[1] := RefPosHum[1];
		InternalPos.CurrentPosition[2] := RefPosHum[2];
		InternalPos.CurrentPosition[3] := RefPosHum[3];
		
		// Calculate a constants
		TransConst[0] := (MaxPosSens[0]-MinPosSens[0])/(MaxPosHum[0]-MinPosHum[0]);
		TransConst[1] := (MaxPosSens[1]-MinPosSens[1])/(MaxPosHum[1]-MinPosHum[1]);
		TransConst[2] := (MaxPosSens[2]-MinPosSens[2])/(MaxPosHum[2]-MinPosHum[2]);
		TransConst[3] := (MaxPosSens[3]-MinPosSens[3])/(MaxPosHum[3]-MinPosHum[3]);
			
		// Status of Reflex sensors (set in position of blocking the ball)
		ModulOK[0] := TRUE;
		ModulOK[1] := TRUE;
		ModulOK[2] := TRUE;
		ModulOK[3] := TRUE;

	// Check the status of Reflex sensors if they work well (TRUE = figure block the balon; FALSE = figure open the way)
	FOR InternalPos.Index[1] := 0 TO 3 DO
				
		InternalPos.DetRot_ModulOK_0.ModulRotOK[InternalPos.Index[1]] := ModulOK[InternalPos.Index[1]];
		InternalPos.DetRot_ModulOK_0();
		ExternalModulOK[InternalPos.Index[1]] := InternalPos.DetRot_ModulOK_0.ExternalModulRotOK[InternalPos.Index[1]];
				
	END_FOR;
			
	// Calculation state compute an atual value of distance or set the max/min value       
	FOR InternalPos.Index[0] := 0 TO 3 DO
				
		// Optical sensor work well and values are in range and diference is over the minimal limit (compute a position by equation)
		IF (ErrorOptSens[InternalPos.Index[0]] = FALSE) AND ((ActPosSens[InternalPos.Index[0]] < MaxPosSens[InternalPos.Index[0]]) AND (ABS(ActPosSens[InternalPos.Index[0]] - InternalPos.CurrentPosition[InternalPos.Index[0]]) > InternalPos.MaxAccDiff[0])) AND ((ActPosSens[InternalPos.Index[0]] > MinPosSens[InternalPos.Index[0]]) AND (ABS(ActPosSens[InternalPos.Index[0]] - InternalPos.CurrentPosition[InternalPos.Index[0]]) > InternalPos.MaxAccDiff[0])) THEN
			ActPosHumAxis[InternalPos.Index[0]] := RefPosHum[InternalPos.Index[0]] + ((ActPosSens[InternalPos.Index[0]] - RefPosSens[InternalPos.Index[0]]) / TransConst[InternalPos.Index[0]]);
			InternalPos.CurrentPosition[InternalPos.Index[0]]:= ActPosHumAxis[InternalPos.Index[0]]; // Last detected value is safed as previous value for case Error mode of sensor
					
		// Optical sensor work well and values are in range and diference is in the minimal limit (set the previous value of position)
		ELSIF (ErrorOptSens[InternalPos.Index[0]] = FALSE) AND ((ActPosSens[InternalPos.Index[0]] < MaxPosSens[InternalPos.Index[0]]) AND (ABS(ActPosSens[InternalPos.Index[0]] - InternalPos.CurrentPosition[InternalPos.Index[0]]) < InternalPos.MaxAccDiff[0])) AND ((ActPosSens[InternalPos.Index[0]] > MinPosSens[InternalPos.Index[0]]) AND (ABS(ActPosSens[InternalPos.Index[0]] - InternalPos.CurrentPosition[InternalPos.Index[0]]) < InternalPos.MaxAccDiff[0])) THEN
			ActPosHumAxis[InternalPos.Index[0]]	:= InternalPos.CurrentPosition[InternalPos.Index[0]]; // Previous value of position
						
		// Optical sensor doesn't work well but values are in range
		ELSIF (ErrorOptSens[InternalPos.Index[0]] = TRUE) AND (ActPosSens[InternalPos.Index[0]] < MaxPosSens[InternalPos.Index[0]]) AND (ActPosSens[InternalPos.Index[0]] > MinPosSens[InternalPos.Index[0]]) THEN
			ActPosHumAxis[InternalPos.Index[0]] := 	InternalPos.CurrentPosition[InternalPos.Index[0]]; // Previous value of position
					
		// Optical sensor doesn't work well but values are over the maximum range
		ELSIF (ErrorOptSens[InternalPos.Index[0]] = TRUE) AND (ActPosSens[InternalPos.Index[0]] > MaxPosSens[InternalPos.Index[0]]) THEN
			ActPosHumAxis[InternalPos.Index[0]] := 	MaxPosSens[InternalPos.Index[0]]; // Maximum value of the range
				
		// Optical sensor doesn't work well but values are less than the minimum range
		ELSIF (ErrorOptSens[InternalPos.Index[0]] = TRUE) AND (ActPosSens[InternalPos.Index[0]] < MinPosSens[InternalPos.Index[0]]) AND (ActPosSens[InternalPos.Index[0]] > InternalPos.MinAccDiff ) THEN
			ActPosHumAxis[InternalPos.Index[0]] := 	MinPosSens[InternalPos.Index[0]]; // Minimum value of the range
						
		// Check if the Optical sensors are switched on (if not, sensored values are in range <-5 ; +5> _ the minimum limit sets InternalPos.MinAccDiff)
		ELSIF (ActPosSens[InternalPos.Index[0]] < InternalPos.MinAccDiff) THEN
			ActPosHumAxis[InternalPos.Index[0]] := 	RefPosHum[InternalPos.Index[0]]; // Due to a optical sensor fail reset the actual value of position to the referent position
				
		// Check if the Reflex sensors doesn't block the ball (if does, the sensing of position is not required _ just a momentary status)
		ELSIF (ExternalModulOK[InternalPos.Index[0]] = FALSE) THEN
					ActPosHumAxis[InternalPos.Index[0]] := 	InternalPos.CurrentPosition[InternalPos.Index[0]]; // Due to a reflex sensor fail reset the actual value of position to the referent position
							
			// Actual human position is set as a last 
		ELSE
			ActPosHumAxis[InternalPos.Index[0]] := InternalPos.CurrentPosition[InternalPos.Index[0]]; // Last detected value in all other cases
		END_IF
                		
	(*// Compute the positions all figures of opponent (by calling the function: DetPos_Figure)
	FOR InternalPos.Index[2] := 0 TO 3 DO
				
		// Set the input values into the function block
		InternalPos.DetPos_Figure0.ActPosHumAxisDP[InternalPos.Index[2]] := ActPosHumAxis[InternalPos.Index[2]];
				
		// Call the function block
		InternalPos.DetPos_Figure0();
	END_FOR;
				
	FOR InternalPos.Index[3] := 0 TO 10 DO
		
		// Call the output values of position all figures
		InternalPos.DetPos_Figure0.ActPosHumFigDP[InternalPos.Index[3]] := ActPosHumFig[InternalPos.Index[3]]*)
	END_FOR;
	
END_FUNCTION_BLOCK


		(* NUMERIC CALCULATION OF POSITION ALL AXES *)
FUNCTION_BLOCK DetPos_Figure
			
	// Set the value at position of Goalman Axis by the Actual Position of Axis with Displacement of Axis
	IF ActPosHumAxisDP[0] < MaxPosHumDP[0] AND ActPosHumAxisDP[0] > MinPosHumDP[0] THEN
		ActPosHumFigDP[0] := ActPosHumAxisDP[0]+DispAxisDP[0];
	ELSIF ActPosHumAxisDP[0] > MaxPosHumDP[0] THEN
		ActPosHumFigDP[0] := MaxPosHumDP[0];
	ELSIF ActPosHumAxisDP[0] < MinPosHumDP[0] THEN
		ActPosHumFigDP[0] := MinPosHumDP[0];
	ELSE
		ActPosHumFigDP[0] := ActPosHumAxisDP[0] + DispAxisDP[0];
	END_IF
				
	FOR i1 := 1 TO 2 DO
		// Set the value at position of Defender Axis by the Actual Position of Axis with Displacement of Axis
		IF ActPosHumAxisDP[1] < MaxPosHumDP[1] AND ActPosHumAxisDP[1] > MinPosHumDP[1] THEN
			ActPosHumFigDP[i1] := ActPosHumAxisDP[1]+ DispAxisDP[i1];
		ELSIF ActPosHumAxisDP[1] > MaxPosHumDP[1] THEN
			ActPosHumFigDP[i1] := MaxPosHumDP[1] + DispAxisDP[i1];
		ELSIF ActPosHumAxisDP[1] < MinPosHumDP[1] THEN
			ActPosHumFigDP[i1] := MinPosHumDP[1] + DispAxisDP[i1];
		ELSE
			ActPosHumFigDP[i1] := ActPosHumAxisDP[1] + DispAxisDP[i1];
		END_IF

	END_FOR;
	
	FOR i2 := 3 TO 7 DO
		// Set the value at position of Middle Defender Axis by the Actual Position of Axis with Displacement of Axis
		IF ActPosHumAxisDP[2] < MaxPosHumDP[2] AND ActPosHumAxisDP[2] > MinPosHumDP[2] THEN
			ActPosHumFigDP[i2] := ActPosHumAxisDP[2]+ DispAxisDP[i2];
		ELSIF ActPosHumAxisDP[2] > MaxPosHumDP[2] THEN
			ActPosHumFigDP[i2] := MaxPosHumDP[2] + DispAxisDP[i2];
		ELSIF ActPosHumAxisDP[2] < MinPosHumDP[2] THEN
			ActPosHumFigDP[i2] := MinPosHumDP[2] + DispAxisDP[i2];
		ELSE
			ActPosHumFigDP[i2] := ActPosHumAxisDP[2] + DispAxisDP[i2];
		END_IF

	END_FOR; 
	
	FOR i3 := 8 TO 10 DO
		// Set the value at position of Forward Axis by the Actual Position of Axis with Displacement of Axis
		IF ActPosHumAxisDP[3] < MaxPosHumDP[3] AND ActPosHumAxisDP[3] > MinPosHumDP[3] THEN
			ActPosHumFigDP[i3] := ActPosHumAxisDP[3]+ DispAxisDP[i3];
		ELSIF ActPosHumAxisDP[3] > MaxPosHumDP[3] THEN
			ActPosHumFigDP[i3] := MaxPosHumDP[3] + DispAxisDP[i3];
		ELSIF ActPosHumAxisDP[3] < MinPosHumDP[3] THEN
			ActPosHumFigDP[i3] := MinPosHumDP[3] + DispAxisDP[i3];
		ELSE
			ActPosHumFigDP[i3] := ActPosHumAxisDP[3] + DispAxisDP[i3];
		END_IF

	END_FOR; 
	
END_FUNCTION_BLOCK 

