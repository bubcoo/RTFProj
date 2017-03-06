FUNCTION_BLOCK FB_DetectionPosition

    IF Enable <> TRUE THEN
        // reset output variables
        Internal.index[0] := 0;
        Internal.index[1] := 0;
        
        Actual_Positions[0] := 0;
        Actual_Positions[1] := 0;
        Actual_Positions[2] := 0;
        Actual_Positions[3] := 0;
        
        ModulOk[0] := FALSE;
        ModulOk[1] := FALSE;
        ModulOk[2] := FALSE;
        ModulOk[3] := FALSE;
        
        Error := FALSE;
        
        // go to initialization state
        Internal.state := OS_INITIALIZATION;
    END_IF
    
    CASE Internal.state OF
        OS_INITIALIZATION:
            // INITIALIZATION STATE
            IF Enable = TRUE THEN
                Internal.state := OS_ENABLED;
            ELSE
                Internal.state := OS_INITIALIZATION;
            END_IF
        
        OS_ENABLED:
            // ENABLED STATE
            Error := err_modDetect(Detection_Error,ModulOk);
        
            IF Error = TRUE THEN
                Internal.state := OS_ERROR;
            ELSE
                Internal.state := OS_CALCULATION;
            END_IF
        
        OS_CALCULATION:
            // CALCULATION STATE       
            FOR Internal.index[0] := 0 TO 3 DO
                IF Distance_Error[Internal.index[0]] = FALSE AND Internal.auxiliary_pos[Internal.index[0]] <> -9999 THEN
                    Internal.auxiliary_pos[Internal.index[0]] := 0;
                    Actual_Positions[Internal.index[0]]       := Positions_FromTheSensors[Internal.index[0]];
                ELSIF Distance_Error[Internal.index[0]] = TRUE AND Internal.auxiliary_pos[Internal.index[0]] <> -9999 THEN
                    Internal.auxiliary_pos[Internal.index[0]] := 0;
                    Actual_Positions[Internal.index[0]]       := -1000;
                ELSE
                    Actual_Positions[Internal.index[0]]       := Internal.auxiliary_pos[Internal.index[0]];
                    Internal.auxiliary_pos[Internal.index[0]] := 0;
                END_IF
                
            END_FOR
        
            Error := err_modDetect(Detection_Error,ModulOk);
            
            IF Error = TRUE THEN
                Internal.state := OS_ERROR;
            ELSE
                Internal.state := OS_CALCULATION;
            END_IF
        OS_ERROR:
            // ERROR STATE
            Error := err_modDetect(Detection_Error,ModulOk);
        
            IF Error = TRUE THEN
                FOR Internal.index[1] := 0 TO 3 DO
                    IF ModulOk[Internal.index[1]] = FALSE THEN
                        Internal.auxiliary_pos[Internal.index[1]] := -9999;
                    ELSE
                        Internal.auxiliary_pos[Internal.index[1]] := 0;
                    END_IF       
                END_FOR
                
                Internal.state := OS_CALCULATION;
            ELSE
                Internal.state := OS_CALCULATION;
            END_IF
    END_CASE
     
END_FUNCTION_BLOCK

FUNCTION err_modDetect
    
    FOR i1 := 0 TO 3 DO
        IF detect_err[i1] = FALSE THEN
            modul_ok[i1] := TRUE;
        ELSE
            modul_ok[i1] := FALSE;
        END_IF    
    END_FOR
        
    FOR i2 := 0 TO 3 DO
        IF modul_ok[i2] = FALSE THEN
            err_modDetect := TRUE;
            RETURN;
        ELSE
            err_modDetect := FALSE;
        END_IF       
    END_FOR
 
END_FUNCTION
