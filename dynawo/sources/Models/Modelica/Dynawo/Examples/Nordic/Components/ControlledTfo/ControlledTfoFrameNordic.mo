within Dynawo.Examples.Nordic.Components.ControlledTfo;

model ControlledTfoFrameNordic

  import Modelica.SIunits;
  import Dynawo.AdditionalIcons;
  import Dynawo.Electrical;
  import Dynawo.Types;
  import Dynawo.Connectors;
  import Dynawo.Examples.Nordic.Components.ControlledTfo.Util;

  extends AdditionalIcons.Transformer;

  parameter Util.ControlledTfoParamRecord.tfoPreset tfo;

  Electrical.Controls.Transformers.TapChanger tapChanger(
    
  U0=U10Pu, UDeadBand=0.01, UTarget = 1, increaseTapToIncreaseValue=false, locked0=false, regulating0=true,
    state0 = Electrical.Controls.Transformers.BaseClasses.TapChangerPhaseShifterParams.State.Standard,
    t1st=Util.ControlledTfoParamRecord.tfoParamValues[tfo, Util.ControlledTfoParamRecord.tfoParams.t1st],
    tNext=Util.ControlledTfoParamRecord.tfoParamValues[tfo, Util.ControlledTfoParamRecord.tfoParams.tNext],tap0(fixed=false), tapMax = Util.ControlledTfoParamRecord.NbTap - 1,tapMin = 0
  ) annotation(
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Util.InitialisedTransformerVariableTap tfoVariableTap(
    SNom=Util.ControlledTfoParamRecord.tfoParamValues[tfo, Util.ControlledTfoParamRecord.tfoParams.SNom],
    X=Util.ControlledTfoParamRecord.tfoParamValues[tfo, Util.ControlledTfoParamRecord.tfoParams.X],
    Uc20Pu=Util.ControlledTfoParamRecord.tfoParamValues[tfo, Util.ControlledTfoParamRecord.tfoParams.Uc20Pu],
    G=0, B=0, R=0,
    P10Pu=P10Pu, Q10Pu=Q10Pu, U10Pu=U10Pu, U1Phase0=U1Phase0
  ) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Connectors.ACPower terminal1 annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Connectors.ACPower terminal2 annotation(
    Placement(visible = true, transformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {98, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Types.PerUnit P10Pu;
  parameter Types.PerUnit Q10Pu;
  parameter Types.VoltageModulePu U10Pu;
  parameter Types.Angle U1Phase0;

initial algorithm
  tapChanger.tap0 := tfoVariableTap.Tap0;

equation
  connect(tfoVariableTap.terminal1, terminal1) annotation(
    Line(points = {{-10, 0}, {-100, 0}, {-100, 0}, {-100, 0}}, color = {0, 0, 255}));
  connect(tfoVariableTap.terminal2, terminal2) annotation(
    Line(points = {{10, 0}, {98, 0}, {98, 0}, {98, 0}}, color = {0, 0, 255}));
  connect(tapChanger.tap, tfoVariableTap.tap);
  connect(tfoVariableTap.U1Pu, tapChanger.UMonitored);
  tapChanger.switchOffSignal1.value = false;
  tapChanger.switchOffSignal2.value = false;
  tfoVariableTap.switchOffSignal1.value = false;
  tfoVariableTap.switchOffSignal2.value = false;
  tapChanger.locked = false;

annotation(
    Icon(graphics = {Rectangle(lineThickness = 0.75, extent = {{-100, 100}, {100, -100}})}),
    Documentation(info = "<html><head></head><body>The controlled tfo frame represents the regulated transformer of the Nordic Test System.<div>It consists of a variable tap transformer and an on-load tap changer with 33 positions, keeping the transformer ratios in the interval [0.88, 1.20] and the distribution voltage in the deadband [0.99, 1.01].</div><div><div style=\"font-size: 12px;\">The implementation utilises a transformer preset, which automatically sets the parameters of all elements to those of the corresponding chosen generator.</div><div style=\"font-size: 12px;\">To add another configuration, append a new line to \"tfoParamValues\" in Util/ControlledTfoParamRecord and append a fitting name in the \"tfoPreset\" enumeration.</div></div></body></html>"));
end ControlledTfoFrameNordic;
