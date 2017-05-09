
(* NUMERIC CALCULATION OF POSITION ALL AXES *)
FUNCTION_BLOCK DetectionPositionAxis
	
		// Calculate a constants
		InternalPos.TransConstant[0] := (InternalPos.MaxPosSens[0]-InternalPos.MinPosSens[0])/(InternalPos.MaxPosHum[0]-InternalPos.MinPosHum[0]);
		InternalPos.TransConstant[1] := (InternalPos.MaxPosSens[1]-InternalPos.MinPosSens[1])/(InternalPos.MaxPosHum[1]-InternalPos.MinPosHum[1]);
		InternalPos.TransConstant[2] := (InternalPos.MaxPosSens[2]-InternalPos.MinPosSens[2])/(InternalPos.MaxPosHum[2]-InternalPos.MinPosHum[2]);
		InternalPos.TransConstant[3] := (InternalPos.MaxPosSens[3]-InternalPos.MinPosSens[3])/(InternalPos.MaxPosHum[3]-InternalPos.MinPosHum[3]);
			
	// Check the status of Reflex sensors if they work well (TRUE = figure block the balon; FALSE = figure open the way)
	FOR InternalPos.Index[1] := 0 TO 3 DO
				
		InternalPos.DR_ReflexSensStatus_0.ReflexSensStatusRS[InternalPos.Index[1]] := ReflexSensStatus[InternalPos.Index[1]];
	END_FOR;
	
	// Calling FB DetRot_ModulOK_0
	InternalPos.DR_ReflexSensStatus_0();
			
	// Calculation state compute an atual value of distance or set the max/min value       
	FOR InternalPos.Index[0] := 0 TO 3 DO
				
		// Set the External ModulOK value for case disfunction of
		ExternalReflexSensStatus[InternalPos.Index[0]] := InternalPos.DR_ReflexSensStatus_0.ExternalReflexSensStatusRS[InternalPos.Index[0]];
				
		// Optical sensor work well and values are in range and diference is over the minimal limit (compute a position by equation)
		IF (ErrorOptSens[InternalPos.Index[0]] = FALSE) AND ((ActPosSens[InternalPos.Index[0]] < InternalPos.MaxPosSens[InternalPos.Index[0]]) AND (ABS(ActPosSens[InternalPos.Index[0]] - InternalPos.CurrentPosition[InternalPos.Index[0]]) > InternalPos.MaxAccDiff[0])) AND ((ActPosSens[InternalPos.Index[0]] > InternalPos.MinPosSens[InternalPos.Index[0]]) AND (ABS(ActPosSens[InternalPos.Index[0]] - InternalPos.CurrentPosition[InternalPos.Index[0]]) > InternalPos.MaxAccDiff[0])) THEN
			ActPosHumAxis[InternalPos.Index[0]] := InternalPos.RefPosHum[InternalPos.Index[0]] + ((ActPosSens[InternalPos.Index[0]] - InternalPos.RefPosSens[InternalPos.Index[0]]) / InternalPos.TransConstant[InternalPos.Index[0]]);
			InternalPos.CurrentPosition[InternalPos.Index[0]] := ActPosHumAxis[InternalPos.Index[0]]; // Last detected value is safed as previous value for case Error mode of sensor
					
		// Optical sensor work well and values are in range and diference is in the minimal limit (set the previous value of position)
		ELSIF (ErrorOptSens[InternalPos.Index[0]] = FALSE) AND ((ActPosSens[InternalPos.Index[0]] < InternalPos.MaxPosSens[InternalPos.Index[0]]) AND (ABS(ActPosSens[InternalPos.Index[0]] - InternalPos.CurrentPosition[InternalPos.Index[0]]) < InternalPos.MaxAccDiff[0])) AND ((ActPosSens[InternalPos.Index[0]] > InternalPos.MinPosSens[InternalPos.Index[0]]) AND (ABS(ActPosSens[InternalPos.Index[0]] - InternalPos.CurrentPosition[InternalPos.Index[0]]) < InternalPos.MaxAccDiff[0])) THEN
			ActPosHumAxis[InternalPos.Index[0]]	:= InternalPos.CurrentPosition[InternalPos.Index[0]]; // Previous value of position
						
		// Optical sensor doesn't work well but values are in range
		ELSIF (ErrorOptSens[InternalPos.Index[0]] = TRUE) AND (ActPosSens[InternalPos.Index[0]] < InternalPos.MaxPosSens[InternalPos.Index[0]]) AND (ActPosSens[InternalPos.Index[0]] > InternalPos.MinPosSens[InternalPos.Index[0]]) THEN
			ActPosHumAxis[InternalPos.Index[0]] := 	InternalPos.CurrentPosition[InternalPos.Index[0]]; // Previous value of position
					
		// Optical sensor doesn't work well but values are over the maximum range
		ELSIF (ErrorOptSens[InternalPos.Index[0]] = TRUE) AND ((ActPosSens[InternalPos.Index[0]] > 500) OR (ActPosSens[InternalPos.Index[0]] < 8000))THEN
			ActPosHumAxis[InternalPos.Index[0]] := 	InternalPos.CurrentPosition[InternalPos.Index[0]]; // Previous value of position
							
		// Check if the Optical sensors are switched on (if not, sensored values are in range <-100 ; +100> _ the minimum limit sets InternalPos.MinAccDiff)
		ELSIF (ActPosSens[InternalPos.Index[0]] < InternalPos.MinAccDiff) THEN
			ActPosHumAxis[InternalPos.Index[0]] := 	InternalPos.RefPosHum[InternalPos.Index[0]]; // Due to a optical sensor fail set referent value of position by previous value of position
				
		// Check if the Reflex sensors doesn't block the ball (if does, the sensing of position is not required _ just a momentary status)
		ELSIF (ExternalReflexSensStatus[InternalPos.Index[0]] = FALSE) THEN
					ActPosHumAxis[InternalPos.Index[0]] := 	InternalPos.CurrentPosition[InternalPos.Index[0]]; // Due to a reflex sensor fail reset the actual value of position to the referent position
							
			// Actual human position is set as a last 
		ELSE
			ActPosHumAxis[InternalPos.Index[0]] := InternalPos.RefPosHum[InternalPos.Index[0]]; // Set referent position in all other cases as default
		END_IF
		
	END_FOR;
                		
	// Compute the positions all figures of opponent (by calling the function: DetPos_Figure)
	FOR InternalPos.Index[2] := 0 TO 3 DO
				
		// Set the input values into the function block
		InternalPos.DP_Figure_0.ActPosHumAxisDP[InternalPos.Index[2]] := ActPosHumAxis[InternalPos.Index[2]];
				
	END_FOR;
				
	// Call the function block
	InternalPos.DP_Figure_0();
	FOR InternalPos.Index[3] := 0 TO 10 DO
		
		// Call the output values of position all figures
 		ActPosHumFig[InternalPos.Index[3]] := InternalPos.DP_Figure_0.ActPosHumFigDP[InternalPos.Index[3]];
			
	END_FOR; 
	
END_FUNCTION_BLOCK


		(* NUMERIC CALCULATION OF POSITION ALL AXES *)
FUNCTION_BLOCK DetPos_Figure
			
	// Set the value at position of Goalman Axis by the Actual Position of Axis with Displacement of Axis
	IF (ActPosHumAxisDP[0] < InternalPosFig.MaxPosHumDP[0]) AND (ActPosHumAxisDP[0] > InternalPosFig.MinPosHumDP[0]) THEN
		ActPosHumFigDP[0] := ActPosHumAxisDP[0] + InternalPosFig.DispAxisDP[0];
		InternalPosFig.CurrentPosition[0] := ActPosHumFigDP[0];
	// 	
	ELSIF ActPosHumAxisDP[0] > InternalPosFig.MaxPosHumDP[0] THEN
		ActPosHumFigDP[0] := InternalPosFig.MaxPosHumDP[0];
		
	//	
	ELSIF ActPosHumAxisDP[0] < InternalPosFig.MinPosHumDP[0] THEN
		ActPosHumFigDP[0] := InternalPosFig.MinPosHumDP[0];
		
	// 	
	ELSE
		ActPosHumFigDP[0] := ActPosHumAxisDP[0] + InternalPosFig.DispAxisDP[0];
	END_IF
				
	FOR InternalPosFig.Index[0] := 1 TO 2 DO
		// Set the value at position of Defender Axis by the Actual Position of Axis with Displacement of Axis
		IF (ActPosHumAxisDP[1] < InternalPosFig.MaxPosHumDP[1]) AND (ActPosHumAxisDP[1] > InternalPosFig.MinPosHumDP[1]) THEN
			ActPosHumFigDP[InternalPosFig.Index[0]] := ActPosHumAxisDP[1] + InternalPosFig.DispAxisDP[InternalPosFig.Index[0]];
			InternalPosFig.CurrentPosition[InternalPosFig.Index[0]] := ActPosHumFigDP[InternalPosFig.Index[0]];
		// 	
		ELSIF ActPosHumAxisDP[1] > InternalPosFig.MaxPosHumDP[1] THEN
			ActPosHumFigDP[InternalPosFig.Index[0]] := InternalPosFig.MaxPosHumDP[1] + InternalPosFig.DispAxisDP[InternalPosFig.Index[0]];
			
		// 	
		ELSIF ActPosHumAxisDP[1] < InternalPosFig.MinPosHumDP[1] THEN
			ActPosHumFigDP[InternalPosFig.Index[0]] := InternalPosFig.MinPosHumDP[1] + InternalPosFig.DispAxisDP[InternalPosFig.Index[0]];
			
		// 	
		ELSE
			ActPosHumFigDP[InternalPosFig.Index[0]] := 	InternalPosFig.CurrentPosition[InternalPosFig.Index[0]];
		END_IF

	END_FOR;
	
	FOR InternalPosFig.Index[1] := 3 TO 7 DO
		// Set the value at position of Middle Defender Axis by the Actual Position of Axis with Displacement of Axis
		IF (ActPosHumAxisDP[2] < InternalPosFig.MaxPosHumDP[2]) AND (ActPosHumAxisDP[2] > InternalPosFig.MinPosHumDP[2]) THEN
			ActPosHumFigDP[InternalPosFig.Index[1]] := ActPosHumAxisDP[2] + InternalPosFig.DispAxisDP[InternalPosFig.Index[1]];
			InternalPosFig.CurrentPosition[InternalPosFig.Index[1]] := ActPosHumFigDP[InternalPosFig.Index[1]];
		// 	
		ELSIF ActPosHumAxisDP[2] > InternalPosFig.MaxPosHumDP[2] THEN
			ActPosHumFigDP[InternalPosFig.Index[1]] := InternalPosFig.MaxPosHumDP[2] + InternalPosFig.DispAxisDP[InternalPosFig.Index[1]];
			
		// 	
		ELSIF ActPosHumAxisDP[2] < InternalPosFig.MinPosHumDP[2] THEN
			ActPosHumFigDP[InternalPosFig.Index[1]] := InternalPosFig.MinPosHumDP[2] + InternalPosFig.DispAxisDP[InternalPosFig.Index[1]];
		
		// 
		ELSE
			ActPosHumFigDP[InternalPosFig.Index[1]] := InternalPosFig.CurrentPosition[InternalPosFig.Index[1]];
		END_IF

	END_FOR; 
	
	FOR InternalPosFig.Index[2] := 8 TO 10 DO
		// Set the value at position of Forward Axis by the Actual Position of Axis with Displacement of Axis
		IF (ActPosHumAxisDP[3] < InternalPosFig.MaxPosHumDP[3]) AND (ActPosHumAxisDP[3] > InternalPosFig.MinPosHumDP[3]) THEN
			ActPosHumFigDP[InternalPosFig.Index[2]] := ActPosHumAxisDP[3]+ InternalPosFig.DispAxisDP[InternalPosFig.Index[2]];
			InternalPosFig.CurrentPosition[InternalPosFig.Index[2]] := ActPosHumFigDP[InternalPosFig.Index[2]];
		// 	
		ELSIF ActPosHumAxisDP[3] > InternalPosFig.MaxPosHumDP[3] THEN
			ActPosHumFigDP[InternalPosFig.Index[2]] := InternalPosFig.MaxPosHumDP[3] + InternalPosFig.DispAxisDP[InternalPosFig.Index[2]];
			
		// 	
		ELSIF ActPosHumAxisDP[3] < InternalPosFig.MinPosHumDP[3] THEN
			ActPosHumFigDP[InternalPosFig.Index[2]] := InternalPosFig.MinPosHumDP[3] + InternalPosFig.DispAxisDP[InternalPosFig.Index[2]];
		
		// 
		ELSE
			ActPosHumFigDP[InternalPosFig.Index[2]] := InternalPosFig.CurrentPosition[InternalPosFig.Index[2]];
		END_IF

	END_FOR; 
	
END_FUNCTION_BLOCK 

