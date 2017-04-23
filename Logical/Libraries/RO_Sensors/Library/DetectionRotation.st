
(* LOGIC PREDICTION OF ROTATION ALL AXES *)
FUNCTION_BLOCK DetectionRotation

	
		// Init part of program set the basic values & constants
	IF Enable <> TRUE THEN
		// Reset output variables
		InternalRot.IndexR[0] := 0;
		InternalRot.IndexR[1] := 0;
		// Referent positions
		ActReflRotOP[0] := FALSE;
		ActReflRotOP[1] := FALSE;
		ActReflRotOP[2] := FALSE;
		ActReflRotOP[3] := FALSE;
		// Declined an ErrorStatus
		ErrorStatus := FALSE;
        
		// Go to Initialization case
		InternalRot.StateR := RotInitial;
	END_IF	
	
	CASE InternalRot.StateR OF
		RotInitial:
			// Initialization state checking enable status
			IF Enable = TRUE THEN
				InternalRot.StateR := RotEnabled;
			ELSE
				InternalRot.StateR := RotInitial;
			END_IF
		
		RotEnabled:
			// Enabled state switching task due to en error of sensor
			// Set the Error Status
			ErrorStatusRot := DetRot_Error(ErrorReflSens,ModulRotOK);
        
			IF ErrorStatusRot = TRUE THEN
				InternalRot.StateR := RotSensError;
			ELSE
				InternalRot.StateR := RotWatchPos;
			END_IF
			
		RotWatchPos:
			// Checking the status of reflex sensor 
			FOR InternalRot.IndexR[0] := 0 TO 3 DO
				IF ModulRotOK[InternalRot.IndexR[0]] = TRUE THEN
					ActReflRotOP[InternalPos.Index[0]] := ActReflRotIP[InternalPos.Index[0]];
				ELSE
					ActReflRotOP[InternalPos.Index[0]] := FALSE;
				END_IF       
			END_FOR
           		
			// Set the Error Status
				ErrorStatusRot := DetRot_Error(ErrorReflSens,ModulRotOK);
			
			// Checking the Error Status
			IF ErrorStatusRot = TRUE THEN
				InternalRot.StateR := RotSensError;
			ELSE
				InternalRot.StateR := RotWatchPos;
			END_IF
	
		PosSensError:
			// ERROR STATE
			ErrorStatusRot := DetRot_Error(ErrorReflSens,ModulRotOK);
        
			IF ErrorStatusRot = TRUE THEN
				FOR InternalRot.IndexR[1] := 0 TO 3 DO
					IF ModulRotOK[InternalRot.IndexR[1]] = FALSE THEN
						ActReflRotOP[InternalRot.IndexR[1]] := FALSE;
					ELSE
						ActReflRotOP[InternalPos.Index[1]] := ActReflRotIP[InternalPos.Index[1]];
					END_IF       
				END_FOR
                
				InternalRot.StateR := RotWatchPos;
			ELSE
				InternalRot.StateR := RotEnabled;
			END_IF
	END_CASE

END_FUNCTION_BLOCK

FUNCTION DetRot_Error
    
			FOR i1 := 0 TO 3 DO
				IF DetRotErrorReflSens[i1] = FALSE THEN
					DetRotModulOK[i1] := TRUE;
				ELSE
					DetRotModulOK[i1] := FALSE;
				END_IF    
			END_FOR
        
			FOR i2 := 0 TO 3 DO
				IF DetRotModulOK[i2] = FALSE THEN
					DetRotErrorReflSens := TRUE;
					RETURN;
				ELSE
					DetRotErrorReflSens := FALSE;
				END_IF       
			END_FOR
			
 END_FUNCTION