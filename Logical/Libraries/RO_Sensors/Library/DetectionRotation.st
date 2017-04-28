
(* LOGIC PREDICTION OF ROTATION ALL AXES *)
FUNCTION_BLOCK DetectionRotation

	
	// Set the value of index
	InternalRot.IndexR[0] := 0;
		
	// Checking the status of reflex sensor 
	FOR InternalRot.IndexR[0] := 0 TO 3 DO
	
		// Reflex sensor works & Modul set TRUE to output
		IF (ModulRotOK[InternalRot.IndexR[0]] = TRUE) AND (ErrorReflSens[InternalRot.IndexR[0]] = FALSE) THEN
			ActReflRotOP[InternalRot.IndexR[0]] := ModulRotOK[InternalRot.IndexR[0]];
		
		// Reflex sensor works but Modul set FALSE to output	
		ELSIF (ModulRotOK[InternalRot.IndexR[0]] = FALSE) AND (ErrorReflSens[InternalRot.IndexR[0]] = FALSE) THEN
				ActReflRotOP[InternalRot.IndexR[0]] := ModulRotOK[InternalRot.IndexR[0]];
		
			// Reflex sensor doesn't works 	
		ELSIF (ErrorReflSens[InternalRot.IndexR[0]] = TRUE) THEN
			ActReflRotOP[InternalRot.IndexR[0]] := FALSE;
		
		// 	Set the status of Actual position of Rotation by the ModulOK status
		ELSE
			ActReflRotOP[InternalRot.IndexR[0]] := ModulRotOK[InternalRot.IndexR[0]];
		END_IF       
	END_FOR
	

END_FUNCTION_BLOCK
