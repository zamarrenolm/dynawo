within Dynawo.Examples.Nordic;

model TestCase

  extends Network.DynamicModel_fixedTfos;
  extends Icons.Example;
  
  import Modelica.ComplexMath;
  import Dynawo.Electrical.Events.NodeFault;
  import Dynawo.Electrical.Events.Event.SingleBooleanEvent;
  import Dynawo.Electrical.SystemBase;
  import Dynawo.Types;
  
  NodeFault nodeFault(RPu = 2 * 20 / 400 ^ 2 * SystemBase.SnRef, XPu = 2 * 20 / 400 ^ 2 * SystemBase.SnRef, tBegin = 1, tEnd = 1.1);
  SingleBooleanEvent Disconnection(stateEvent1 = true, tEvent = 1.1);
  
  Types.VoltageModulePu Check_UPu_bus_1041;
  Types.VoltageModulePu Check_UPu_bus_1042;
  Types.VoltageModulePu Check_UPu_bus_4012;
  Types.VoltageModulePu Check_UPu_bus_4062;
  
equation

  Check_UPu_bus_1041 = ComplexMath.'abs'(bus_1041.terminal.V);
  Check_UPu_bus_1042 = ComplexMath.'abs'(bus_1042.terminal.V);
  Check_UPu_bus_4012 = ComplexMath.'abs'(bus_4012.terminal.V);
  Check_UPu_bus_4062 = ComplexMath.'abs'(bus_4062.terminal.V);
  connect(nodeFault.terminal, bus_4032.terminal);
  connect(Disconnection.state1, line_4032_4044.switchOffSignal1);
  
  annotation(
    experiment(StartTime = 0, StopTime = 7, Tolerance = 0.0001, Interval = 0.001),
    __OpenModelica_commandLineOptions = " --daemode",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", noEquidistantTimeGrid = "()", s = "ida"));
end TestCase;
