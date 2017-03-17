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
    <NcDataObject Name="gmcipvar" Source="ACP10_ETXEN.ACP10_R.GmcIpUserConfig.gmcipvar.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipfun" Source="ACP10_ETXEN.ACP10_R.GmcIpUserConfig.gmcipfun.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipfub" Source="ACP10_ETXEN.ACP10_R.GmcIpUserConfig.gmcipfub.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipubr" Source="ACP10_ETXEN.ACP10_R.GmcIpUserConfig.gmcipubr.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipusm" Source="ACP10_ETXEN.ACP10_R.GmcIpUserConfig.gmcipusm.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipui" Source="ACP10_ETXEN.ACP10_R.GmcIpUserConfig.gmcipui.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipus" Source="ACP10_ETXEN.ACP10_R.GmcIpUserConfig.gmcipus.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipuc" Source="ACP10_ETXEN.ACP10_R.GmcIpUserConfig.gmcipuc.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipsys" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmcipsys.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmciplbr" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmciplbr.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipcbr" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmcipcbr.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmciplsm" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmciplsm.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipcsm" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmcipcsm.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipcfg" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmcipcfg.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipiec" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmcipiec.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmciplog" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmciplog.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipesm" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmcipesm.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipmxd" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmcipmxd.dob" Memory="UserROM" Language="Cnc" />
    <NcDataObject Name="gmcipmx" Source="ACP10_ETXEN.ACP10_R.GmcIpConfig.gmcipmx.dob" Memory="UserROM" Language="Cnc" />
  </NcDataObjects>
  <Binaries>
    <BinaryObject Name="mvLoader" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="TCData" Source="" Memory="SystemROM" Language="Binary" />
    <BinaryObject Name="udbdef" Source="" Memory="UserROM" Language="Binary" />
    <BinaryObject Name="iomap" Source="" Memory="UserROM" Language="Binary" />
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
    <LibraryObject Name="Acp10man" Source="Libraries.Acp10man.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10par" Source="Libraries.Acp10par.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="NcGlobal" Source="Libraries.NcGlobal.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10_MC" Source="Libraries.Acp10_MC.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="sys_lib" Source="Libraries.sys_lib.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="brsystem" Source="Libraries.brsystem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="GmcArncGrp" Source="Libraries.GmcArncGrp.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Arnc0man" Source="Libraries.Arnc0man.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="GmcManager" Source="Libraries.GmcManager.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Acp10sim" Source="Libraries.Acp10sim.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArProf" Source="Libraries.AsArProf.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsArLog" Source="Libraries.AsArLog.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="astime" Source="Libraries.astime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="DataObj" Source="Libraries.DataObj.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="AsMem" Source="Libraries.AsMem.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="FileIO" Source="Libraries.FileIO.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Camera" Source="Libraries.LB_Camera.Camera.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="asstring" Source="Libraries.asstring.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="runtime" Source="Libraries.runtime.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="GmcGrpAPI" Source="Libraries.GmcGrpAPI.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="powerlnk" Source="" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="Bar_Light" Source="Libraries.LB_Camera.Bar_Light.lby" Memory="UserROM" Language="ANSIC" Debugging="true" />
    <LibraryObject Name="MTTypes" Source="Libraries.MTTypes.lby" Memory="UserROM" Language="Binary" Debugging="true" />
    <LibraryObject Name="MTBasics" Source="Libraries.MTBasics.lby" Memory="UserROM" Language="Binary" Debugging="true" />
  </Libraries>
</SwConfiguration>