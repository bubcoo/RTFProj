<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio Version=4.2.8.54 SP?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="cam_sens_s" Source="Real_Game.Technology.cam_sens_sd_s.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4" />
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <DataObjects>
    <DataObject Name="Acp10sys" Source="" Memory="UserROM" Language="Binary" />
    <DataObject Name="Arnc0sys" Source="" Memory="UserROM" Language="Binary" />
  </DataObjects>
  <NcDataObjects>
    <NcDataObject Name="gkRotaryDa" Source="Real_Game.Motion_RG.gkRotaryDobj.gkRotaryDa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="gkRotaryDi" Source="Real_Game.Motion_RG.gkRotaryDobj.gkRotaryDi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="gkRotaryGa" Source="Real_Game.Motion_RG.gkRotaryGobj.gkRotaryGa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="gkRotaryGi" Source="Real_Game.Motion_RG.gkRotaryGobj.gkRotaryGi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="gkLinearDa" Source="Real_Game.Motion_RG.gkLinearDobj.gkLinearDa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="gkLinearDi" Source="Real_Game.Motion_RG.gkLinearDobj.gkLinearDi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="gkLinearGa" Source="Real_Game.Motion_RG.gkLinearGobj.gkLinearGa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="gkLinearGi" Source="Real_Game.Motion_RG.gkLinearGobj.gkLinearGi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="gkRotaryFa" Source="Real_Game.Motion_RG.gkRotaryFobj.gkRotaryFa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="gkRotaryFi" Source="Real_Game.Motion_RG.gkRotaryFobj.gkRotaryFi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="gkRotaryMa" Source="Real_Game.Motion_RG.gkRotaryMobj.gkRotaryMa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="gkRotaryMi" Source="Real_Game.Motion_RG.gkRotaryMobj.gkRotaryMi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="gkLinearFa" Source="Real_Game.Motion_RG.gkLinearFobj.gkLinearFa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="gkLinearFi" Source="Real_Game.Motion_RG.gkLinearFobj.gkLinearFi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="gkLinearMa" Source="Real_Game.Motion_RG.gkLinearMobj.gkLinearMa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="gkLinearMi" Source="Real_Game.Motion_RG.gkLinearMobj.gkLinearMi.dob" Memory="UserROM" Language="Ax" />
  </NcDataObjects>
  <Binaries>
    <BinaryObject Name="mvLoader" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="OpcUaMap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="TC" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arnc0cfg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Arnc0map" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Acp10map" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="acp10cfg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arsvcreg" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="operator" Source="Libraries.operator.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsIecCon" Source="Libraries.AsIecCon.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArSdm" Source="Libraries.AsArSdm.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsWStr" Source="Libraries.AsWStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asstring" Source="Libraries.asstring.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="DataObj" Source="Libraries.DataObj.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArLog" Source="Libraries.AsArLog.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArProf" Source="Libraries.AsArProf.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsMem" Source="Libraries.AsMem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="brsystem" Source="Libraries.brsystem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="rp_funcx1" Source="Libraries.rp_library.rp_funcx1.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="Camera" Source="Libraries.LB_Camera.Camera.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="Bar_Light" Source="Libraries.LB_Camera.Bar_Light.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="ro_sensors" Source="Libraries.RO_Sensors.ro_sensors.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="GoalKeeper" Source="Libraries.RO_LB_ScoreDetection.GoalKeeper.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="AsBrStr" Source="Libraries.AsBrStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="IecCheck" Source="Libraries.IecCheck.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="MTTypes" Source="Libraries.MTTypes.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpCom" Source="Libraries.MpCom.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAlarmX" Source="Libraries.MpAlarmX.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MTBasics" Source="Libraries.MTBasics.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsSafety" Source="Libraries.AsSafety.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsXml" Source="Libraries.AsXml.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAxis" Source="Libraries.MpAxis.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="GmcManager" Source="Libraries.GmcManager.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="GmcGrpAPI" Source="Libraries.GmcGrpAPI.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10_MC" Source="Libraries.Acp10_MC.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10man" Source="Libraries.Acp10man.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="NcGlobal" Source="Libraries.NcGlobal.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10par" Source="Libraries.Acp10par.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="powerlnk" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="GmcArncGrp" Source="Libraries.GmcArncGrp.lby" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>