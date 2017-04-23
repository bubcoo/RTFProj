
(* NUMERIC CALCULATION OF POSITION ALL AXES *)
FUNCTION_BLOCK DetectionPositionAxis
	
	// Init part of program set the basic values & constants
	IF Enable <> TRUE THEN
		// Reset output variables
		InternalPos.Index[0] := 0;
		InternalPos.Index[1] := 0;
		// Referent positions
		ActPosHum[0] := RefPosHum[0];
		ActPosHum[1] := RefPosHum[1];
		ActPosHum[2] := RefPosHum[2];
		ActPosHum[3] := RefPosHum[3];
		// Declined an ErrorStatus
		ErrorStatus := FALSE;
        
		// Calculate a constants
		TransConst[0] := (MaxPosSens[0]-MinPosSens[0])/(MaxPosHum[0]-MinPosHum[0]);
		TransConst[1] := (MaxPosSens[1]-MinPosSens[1])/(MaxPosHum[1]-MinPosHum[1]);
		TransConst[2] := (MaxPosSens[2]-MinPosSens[2])/(MaxPosHum[2]-MinPosHum[2]);
		TransConst[3] := (MaxPosSens[3]-MinPosSens[3])/(MaxPosHum[3]-MinPosHum[3]);
		
		// Go to Initialization case
		InternalPos.State := PosInitial;
	END_IF	
	
	CASE InternalPos.State OF
		PosInitial:
			// Initialization state checking enable status
			IF Enable = TRUE THEN
				Internal.State := PosEnabled;
			ELSE
				Internal.State := PosInitial;
			END_IF
		
		PosEnabled:
			// Enabled state switching task due to en error of sensor
			// Set the Error Status
			ErrorStatus := DetPos_Error(ErrorOptSens,ModulOK);
        
			IF ErrorStatus = TRUE THEN
				Internal.State := PosSensError;
			ELSE
				Internal.State := PosCalcPos;
			END_IF
		
		PosCalcPos:
			// Calculation state compute an atual value of distance or set the max/min value       
			FOR InternalPos.Index[0] := 0 TO 3 DO
				// Sensor work well and value is in range
				IF ErrorOptSens[InternalPos.Index[0]] = FALSE AND (ActPosSens[InternalPos.Index[0]] < MaxPosSens[InternalPos.Index[0]] OR ActPosSens[InternalPos.Index[0]] > MinPosSens[InternalPos.Index[0]]) THEN
					ActPosHumAxis[InternalPos.Index[0]] := RefPosHum[InternalPos.Index[0]]+((ActPosSens[InternalPos.Index[0]]-RefPosSens[InternalPos.Index[0]])/TransConst[InternalPos.Index[0]]);
					Internal.CurrentPosition[Internal.index[0]]:= ActPosHumAxis[InternalPos.Index[0]]; //Last detected value is safed for case Error status at the range of values
					// Sensor work with error, but value is in range
				ELSIF ErrorOptSens[InternalPos.Index[0]] = TRUE AND (ActPosSens[InternalPos.Index[0]] < MaxPosSens[InternalPos.Index[0]] OR ActPosSens[InternalPos.Index[0]] > MinPosSens[InternalPos.Index[0]]) THEN
					ActPosHumAxis[InternalPos.Index[0]] := Internal.CurrentPosition[Internal.index[0]]; // Last detected value
					// Sensor work with error and value is higher than maximum value of the range
				ELSIF ErrorOptSens[InternalPos.Index[0]] = TRUE AND ActPosSens[InternalPos.Index[0]] > MaxPosSens[InternalPos.Index[0]] THEN
					ActPosHumAxis[InternalPos.Index[0]] := MaxPosSens[InternalPos.Index[0]];
					// Sensor work with error and value is lower than minimum value of the range
				ELSIF ErrorOptSens[InternalPos.Index[0]] = TRUE AND ActPosSens[InternalPos.Index[0]] < MinPosSens[InternalPos.Index[0]] THEN
					ActPosHumAxis[InternalPos.Index[0]] := MinPosSens[InternalPos.Index[0]] ;
					// Actual human position is set as a last 
				ELSE
					ActPosHumAxis[InternalPos.Index[0]] := Internal.CurrentPosition[Internal.index[0]]; // Last detected value in all other cases
				END_IF
                
			END_FOR
		
			// Compute the positions all figures of opponent (by calling the function: DetPos_Figure)
			// ActPosHumFig := DetPos_Figure(ActPosHumFig,ActPosHumAxis); !!!?!!?!?!?! Is that clear?!!?!?!?
			
			// Set the Error Status
			ErrorStatus := DetPos_Error(ErrorOptSens,ModulOK);
			
			// Checking the Error Status
			IF ErrorStatus = TRUE THEN
				InternalPos.State := PosSensError;
			ELSE
				InternalPos.State := PosCalcPos;
			END_IF
	
		PosSensError:
			// ERROR STATE
			ErrorStatus := DetPos_Error(ErrorOptSens,ModulOK);
        
			IF ErrorStatus = TRUE THEN
				FOR InternalPos.Index[1] := 0 TO 3 DO
					IF ModulOK[InternalPos.Index[1]] = FALSE THEN
						ActPosHumAxis[InternalPos.Index[1]] := RefPosHum[InternalPos.Index[1]];
					ELSE
						Internal.CurrentPosition[Internal.index[1]] := RefPosHum[InternalPos.Index[1]];
					END_IF       
				END_FOR
                
				InternalPos.State := PosCalcPos;
			ELSE
				InternalPos.State := PosEnabled;
			END_IF
	END_CASE
	
END_FUNCTION_BLOCK

FUNCTION DetPos_Error
    
	FOR i1 := 0 TO 3 DO
		IF DetPosErrorOptSens[i1] = FALSE THEN
			DetPosModulOK[i1] := TRUE;
		ELSE
			DetPosModulOK[i1] := FALSE;
		END_IF    
	END_FOR
        
	FOR i2 := 0 TO 3 DO
		IF DetPosModulOK[i2] = FALSE THEN
			DetPosErrorOptSens := TRUE;
			RETURN;
		ELSE
			DetPosErrorOptSens := FALSE;
		END_IF       
	END_FOR
 
END_FUNCTION

FUNCTION DetPos_Figure
    

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
 
END_FUNCTION