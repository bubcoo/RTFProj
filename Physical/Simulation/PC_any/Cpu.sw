<?xml version="1.0" encoding="utf-8"?>
<?AutomationStudio Version=4.2.7.54 SP?>
<SwConfiguration CpuAddress="SL1" xmlns="http://br-automation.co.at/AS/SwConfiguration">
  <TaskClass Name="Cyclic#1">
    <Task Name="simulation" Source="Simulation.Technology.simulation.prg" Memory="UserROM" Language="ANSIC" Debugging="true" Disabled="true" />
    <Task Name="sim_cam_se" Source="Simulation.Technology.sim_cam_sens_sd_s.prg" Memory="UserROM" Language="ANSIC" Debugging="true" />
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
    <NcDataObject Name="acp10etxen" Source="ACP10_ETXEN.acp10etxen.dob" Memory="UserROM" Language="Ett" />
    <NcDataObject Name="dfRotaryBa" Source="Simulation.Motion.Rotary.dfRotaryBobj.dfRotaryBa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="dfRotaryBi" Source="Simulation.Motion.Rotary.dfRotaryBobj.dfRotaryBi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="gkRotaryAa" Source="Simulation.Motion.Rotary.gkRotaryAobj.gkRotaryAa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="gkRotaryAi" Source="Simulation.Motion.Rotary.gkRotaryAobj.gkRotaryAi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="dfLinearBa" Source="Simulation.Motion.Linear.dfLinearBobj.dfLinearBa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="dfLinearBi" Source="Simulation.Motion.Linear.dfLinearBobj.dfLinearBi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="gkLinearAa" Source="Simulation.Motion.Linear.gkLinearAobj.gkLinearAa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="gkLinearAi" Source="Simulation.Motion.Linear.gkLinearAobj.gkLinearAi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="fwRotaryDa" Source="Simulation.Motion.Rotary.fwRotaryDobj.fwRotaryDa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="fwRotaryDi" Source="Simulation.Motion.Rotary.fwRotaryDobj.fwRotaryDi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="mdRotaryCa" Source="Simulation.Motion.Rotary.mdRotaryCobj.mdRotaryCa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="mdRotaryCi" Source="Simulation.Motion.Rotary.mdRotaryCobj.mdRotaryCi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="fwLinearDa" Source="Simulation.Motion.Linear.fwLinearDobj.fwLinearDa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="fwLinearDi" Source="Simulation.Motion.Linear.fwLinearDobj.fwLinearDi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="mdLinearCa" Source="Simulation.Motion.Linear.mdLinearCobj.mdLinearCa.dob" Memory="UserROM" Language="Apt" />
    <NcDataObject Name="mdLinearCi" Source="Simulation.Motion.Linear.mdLinearCobj.mdLinearCi.dob" Memory="UserROM" Language="Ax" />
    <NcDataObject Name="gmcipvar1" Source="ACP10_ETXEN.GmcIpUserConfig.gmcipvar.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipfun1" Source="ACP10_ETXEN.GmcIpUserConfig.gmcipfun.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipfub1" Source="ACP10_ETXEN.GmcIpUserConfig.gmcipfub.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipubr1" Source="ACP10_ETXEN.GmcIpUserConfig.gmcipubr.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipusm1" Source="ACP10_ETXEN.GmcIpUserConfig.gmcipusm.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipui1" Source="ACP10_ETXEN.GmcIpUserConfig.gmcipui.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipus1" Source="ACP10_ETXEN.GmcIpUserConfig.gmcipus.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipuc1" Source="ACP10_ETXEN.GmcIpUserConfig.gmcipuc.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipsys1" Source="ACP10_ETXEN.GmcIpConfig.gmcipsys.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmciplbr1" Source="ACP10_ETXEN.GmcIpConfig.gmciplbr.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipcbr1" Source="ACP10_ETXEN.GmcIpConfig.gmcipcbr.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmciplsm1" Source="ACP10_ETXEN.GmcIpConfig.gmciplsm.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipcsm1" Source="ACP10_ETXEN.GmcIpConfig.gmcipcsm.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipcfg1" Source="ACP10_ETXEN.GmcIpConfig.gmcipcfg.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipiec1" Source="ACP10_ETXEN.GmcIpConfig.gmcipiec.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmciplog1" Source="ACP10_ETXEN.GmcIpConfig.gmciplog.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipesm1" Source="ACP10_ETXEN.GmcIpConfig.gmcipesm.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipmxd1" Source="ACP10_ETXEN.GmcIpConfig.gmcipmxd.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipmx1" Source="ACP10_ETXEN.GmcIpConfig.gmcipmx.dob" Memory="UserROM" Language="Cnc" />
  </NcDataObjects>
  <Binaries>
    <BinaryObject Name="arsvcreg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="mvLoader" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="acp10cfg" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Acp10map" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="ashwd" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="arconfig" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="asfw" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="sysconf" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="Linear" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Rotary" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config_1" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Config" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Role" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="User" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="Core" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="History" Source="" Memory="UserROM" Language="Binary" />
  </Binaries>
  <Libraries>
    <LibraryObject Name="AsIecCon" Source="Libraries.AsIecCon.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpCom" Source="Libraries.MpCom.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAlarmX" Source="Libraries.MpAlarmX.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Runtime" Source="Libraries.Runtime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpWebXs" Source="Libraries.MpWebXs.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArSdm" Source="Libraries.AsArSdm.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="rp_funcx1" Source="Libraries.rp_library.rp_funcx1.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="AsWStr" Source="Libraries.AsWStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="asstring" Source="Libraries.asstring.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10man" Source="Libraries.Acp10man.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10par" Source="Libraries.Acp10par.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="NcGlobal" Source="Libraries.NcGlobal.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Arnc0man" Source="Libraries.Arnc0man.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="DataObj" Source="Libraries.DataObj.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArLog" Source="Libraries.AsArLog.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArProf" Source="Libraries.AsArProf.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsMem" Source="Libraries.AsMem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="brsystem" Source="Libraries.brsystem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10sim" Source="Libraries.Acp10sim.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MpAxis" Source="Libraries.MpAxis.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10_MC" Source="Libraries.Acp10_MC.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="powerlnk" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="areventlog" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsBrStr" Source="Libraries.AsBrStr.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="IecCheck" Source="Libraries.IecCheck.lby" Memory="UserROM" Language="IEC" Debugging="true" />
    <LibraryObject Name="AsSafety" Source="Libraries.AsSafety.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsXml" Source="Libraries.AsXml.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="standard" Source="Libraries.standard.lby" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>