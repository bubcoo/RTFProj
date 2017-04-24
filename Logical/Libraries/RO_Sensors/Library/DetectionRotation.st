
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
		
		ModulRotOK[0] := TRUE;
		ModulRotOK[1] := TRUE;
		ModulRotOK[2] := TRUE;
		ModulRotOK[3] := TRUE;
		        
		// Go to Initialization case
		InternalRot.StateR := RotInitial;
	END_IF	
	
	CASE InternalRot.StateR OF
		RotInitial:
			// Initialization state checking enable status
			IF Enable = TRUE THEN
				InternalRot.StateR := RotWatchPos;
			ELSE
				InternalRot.StateR := RotInitial;
			END_IF
		
		RotWatchPos:
			// Checking the status of reflex sensor 
			FOR InternalRot.IndexR[0] := 0 TO 3 DO
				IF ModulRotOK[InternalRot.IndexR[0]] = TRUE THEN
					ActReflRotOP[InternalRot.IndexR[0]] := ActReflRotIP[InternalRot.IndexR[0]];
					ExternalModulRotOK[InternalRot.IndexR[0]] := ModulRotOK[InternalRot.IndexR[0]];
				ELSIF Enable <> TRUE THEN
					InternalRot.StateR := RotInitial;
				ELSE
					ActReflRotOP[InternalRot.IndexR[0]] := TRUE;
				END_IF       
			END_FOR
		
		
	END_CASE

END_FUNCTION_BLOCK
