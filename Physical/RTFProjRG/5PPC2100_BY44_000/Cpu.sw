<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio Version=4.2.8.54 SP?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="cam_sens_s" Source="Real_Game.Technology.cam_sens_sd_s.prg" Memory="UserROM" Language="ANSIC" Debugging="true" Disabled="true" />
    <Task Name="table_foot" Source="Real_Game.Technology.table_football.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
  </TaskClass>
  <TaskClass Name="Cyclic#2" />
  <TaskClass Name="Cyclic#3" />
  <TaskClass Name="Cyclic#4" />
  <TaskClass Name="Cyclic#5" />
  <TaskClass Name="Cyclic#6" />
  <TaskClass Name="Cyclic#7" />
  <TaskClass Name="Cyclic#8" />
  <DataObjects>
    <DataObject Name="assl1" Source="" Memory="UserROM" Language="Binary" />
    <DataObject Name="Arnc0sys" Source="" Memory="UserROM" Language="Binary" />
    <DataObject Name="Acp10sys" Source="" Memory="UserROM" Language="Binary" />
  </DataObjects>
  <NcDataObjects>
    <NcDataObject Name="acp10etxen" Source="ACP10_ETXEN.acp10etxen.dob" Memory="UserROM" Language="Ett" />
    <NcDataObject Name="rotaryDFa" Source="rotaryDFobj.rotaryDFa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="rotaryDFi" Source="rotaryDFobj.rotaryDFi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="rotaryGKa" Source="rotaryGKobj.rotaryGKa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="rotaryGKi" Source="rotaryGKobj.rotaryGKi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="linearDFa" Source="linearDFobj.linearDFa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="linearDFi" Source="linearDFobj.linearDFi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="linearGKa" Source="linearGKobj.linearGKa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="linearGKi" Source="linearGKobj.linearGKi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="rotaryFWa" Source="rotaryFWobj.rotaryFWa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="rotaryFWi" Source="rotaryFWobj.rotaryFWi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="rotaryMDa" Source="rotaryMDobj.rotaryMDa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="rotaryMDi" Source="rotaryMDobj.rotaryMDi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="linearFWa" Source="linearFWobj.linearFWa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="linearFWi" Source="linearFWobj.linearFWi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="linearMDa" Source="linearMDobj.linearMDa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="linearMDi" Source="linearMDobj.linearMDi.dob" Memory="UserROM" Language="Ax" />
  </NcDataObjects>
  <Binaries>
    <BinaryObject Name="arsvcreg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="mvLoader" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Linear" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="OpcUaMap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Config" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TC" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_1" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Rotary" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Acp10map" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="acp10cfg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Arnc0map" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="arnc0cfg" Source="" Memory="UserROM" Language="Binary" />
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
    <LibraryObject Name="Acp10_MC" Source="Libraries.Acp10_MC.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10man" Source="Libraries.Acp10man.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="NcGlobal" Source="Libraries.NcGlobal.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10par" Source="Libraries.Acp10par.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="powerlnk" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="areventlog" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>