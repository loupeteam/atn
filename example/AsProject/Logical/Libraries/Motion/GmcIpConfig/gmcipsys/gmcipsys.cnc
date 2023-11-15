<?xml version="1.0" encoding="UTF-8"?>
<?ARNC0 Version="5.12.2"?>
<LANGS defaultLangId="1" defaultDataLangId="3">

  <!-- Command queue configuration -->
  <CMDQUEUE BufferSize="15" />

  <!-- Memory configuration -->
  <MEM ReserveMB="5" LimitPercent="80%" />

  <!-- Execution configuration -->
  <EXEC InstrBurstBG="200" CycleBurstBG="0" Stack="16384" MinorStack="2048" EStack="1024" />

  <!-- Loader configuration -->
  <LOAD ReadLineBurstMax="100" ReadLineBurstMin="20"
        ParseLineBurstMax="10" ParseLineBurstMin="2"
        RuntimeIOBlocking="No" />

  <!-- Quiet startup: disable info messages -->
  <DISABLE_MSG>
    15238 <!-- INFO: "Interpreter lib initialized" -->
    15336 <!-- INFO: "Loading interpreter configuration module" -->
    15337 <!-- INFO: "Loading interpreter configuration file" -->
    15666 <!-- INFO: "Precompiling language templates" -->
    15784 <!-- INFO: "Log file scan complete ...file counts..." -->
    15864 <!-- WARNING: "File unloaded" -->
    15740 <!-- INFO: "Interpreter initialized" -->
  </DISABLE_MSG>

  <!-- Languages configuration -->
  <LANG langId="1" langName="B&amp;R GCode" langModule="ailgcode">
    <LANGCONFIG Name="gmciplbr" />
    <LANGCONFIG Name="gmcipcbr" />
    <LANGCONFIG Name="gmcipubr" />
    <FILEEXT Name=".cnc" />
    <FILEEXT Name=".prg" />
    <MAINSEARCHPATH Name="$" FileDevice="CNC_PrgDir" />
    <MAINSEARCHPATH Name="$" DataObject="Yes" />
    <INCLUDEPATH Name="$" FileDevice="CNC_PrgDir" />
    <INCLUDEPATH Name="$" DataObject="Yes" />
  </LANG>
  <LANG langId="2" langName="Alternative Language 1 GCode" langModule="ailgcode">
    <LANGCONFIG Name="gmciplsm" />
    <LANGCONFIG Name="gmcipcbr" />
    <LANGCONFIG Name="gmcipcsm" />
    <LANGCONFIG Name="gmcipusm" />
    <FILEPREFIX>_N_</FILEPREFIX>
    <FILEEXT>.MPF</FILEEXT>
    <FILEEXT>_MPF</FILEEXT>
    <FILEEXT>.SPF</FILEEXT>
    <FILEEXT>_SPF</FILEEXT>
    <MAINSEARCHPATH FileDevice="CNC_PrgDir">\$</MAINSEARCHPATH>
    <MAINSEARCHPATH FileDevice="CNC_PrgDir">\_N_MPF_DIR\$</MAINSEARCHPATH>
    <MAINSEARCHPATH FileDevice="CNC_PrgDir">\_N_SPF_DIR\$</MAINSEARCHPATH>
    <MAINSEARCHPATH DataObject="1">$</MAINSEARCHPATH>
    <INCLUDEPATH FileDevice="CNC_PrgDir">\$</INCLUDEPATH>
    <INCLUDEPATH FileDevice="CNC_PrgDir">\_N_SPF_DIR\$</INCLUDEPATH>
    <INCLUDEPATH FileDevice="CNC_PrgDir">\_N_MPF_DIR\$</INCLUDEPATH>
    <INCLUDEPATH DataObject="1">$</INCLUDEPATH>
  </LANG>
  <LANG langId="3" langName="IEC-ST" langModule="ailgcode">
    <LANGCONFIG Name="gmcipiec" />
    <LANGCONFIG Name="gmcipmx" RequireFnIgnore="MXConvertOrient" />
    <LANGCONFIG Name="gmcipui" IfNotExist="Warn" />
    <FILEEXT Name=".typ" DeclScope="IP_GLOBAL" />
    <FILEEXT Name=".var" DeclScope="IP_GLOBAL" />
    <FILEEXT Name=".fun" DeclScope="IP_GLOBAL" />
    <FILEEXT Name=".iec" DeclScope="IP_LOCAL" />
    <FILEEXT Name=".st"  DeclScope="IP_LOCAL" />
    <FILEEXT Name="_iec" DeclScope="IP_LOCAL" />
    <MAINSEARCHPATH FileDevice="IEC_PrgDir">\$</MAINSEARCHPATH>
    <MAINSEARCHPATH FileDevice="CNC_PrgDir">\$</MAINSEARCHPATH>
    <MAINSEARCHPATH Name="\TYP\$" FileDevice="CNC_PrgDir" DataObject="No" />
    <INCLUDEPATH FileDevice="IEC_PrgDir">\$</INCLUDEPATH>
    <INCLUDEPATH FileDevice="CNC_PrgDir">\$</INCLUDEPATH>
    <INCLUDEPATH Name="\TYP\$" FileDevice="CNC_PrgDir" DataObject="No" />
  </LANG>

  <!-- Include user system configuration  file for overriding settings above -->
  <XML_INCLUDE Name="gmcipus" IfNotExist="Warn"/>
</LANGS>