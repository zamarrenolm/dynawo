within Dynawo.Examples.Nordic.Components.ControlledGen;

model ControlledGenFrameNordic
  // Imports
  import Modelica.SIunits;
  import Modelica.ComplexMath;
  import Modelica.Blocks;
  import Dynawo.AdditionalIcons;
  import Dynawo.Electrical.SystemBase;
  import Dynawo.Electrical.Machines;
  import Dynawo.Types;
  import Dynawo.Connectors;
  import Dynawo.Examples.Nordic.Components.ControlledGen.Util;
  import Dynawo.Examples.Nordic.Components.ControlledGen.Util.ControlledGenFrameParams;
  parameter Util.ControlledGenFrameParams.genFramePreset gen;
  extends AdditionalIcons.Machine;
  // Blocks
  Util.InitialisedSynchronousGenerator generatorSynchronous(DPu = 1, ExcitationPu = Machines.OmegaRef.BaseClasses.GeneratorSynchronousParameters.ExcitationPuType.NominalStatorVoltageNoLoad, H = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.H], P0Pu = P0Pu, PNomAlt = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.PNom], PNomTurb = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.PNom], Q0Pu = Q0Pu, RTfPu = 0, RaPu = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.RaPu], SNom = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.SNom], SnTfo = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.SNom], Tpd0 = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.Tpd0], Tppd0 = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.Tppd0], Tppq0 = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.Tppq0], Tpq0 = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.Tpq0], U0Pu = U0Pu, UBaseHV = 15, UBaseLV = 15, UNom = 15, UNomHV = 15, UNomLV = 15, UPhase0 = UPhase0, XTfPu = 0, XdPu = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.XdPu], XlPu = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.XlPu], XpdPu = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.XpdPu], XppdPu = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.XppdPu], XppqPu = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.XppqPu], XpqPu = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.XpqPu], XqPu = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.XqPu], md = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.md], mq = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.mq], nd = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.nd], nq = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.nq], threeWindings = ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.isHydroPowerPlant]) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  // four windings
  Util.ExciterAvrPssOelNordic exciterAvrPssOelNordic(G = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.G], IfLimPu = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.ifLimPu], Kp = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.Kp], L1 = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.L1], L2 = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.L2], T1 = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.T1], T2 = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.T2], Ta = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.Ta], Tb = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.Tb], Tw = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.Tw], f = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.f], r = ControlledGenFrameParams.exAvPsOeParamValues[gen, ControlledGenFrameParams.exAvPsOeParams.r]) annotation(
    Placement(visible = true, transformation(origin = {-80, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Util.GovernorNordic governorNordic(sigma = ControlledGenFrameParams.govParamValues[gen]) annotation(
    Placement(visible = true, transformation(origin = {-80, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Connectors.ACPower terminal annotation(
    Placement(visible = true, transformation(origin = {1, 101}, extent = {{-23, -23}, {23, 23}}, rotation = 0), iconTransformation(origin = {0, 3.55271e-15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Different bases for PGenPu
  Blocks.Math.Gain BaseConvChangeSnRef2PNom(k = SystemBase.SnRef / PNom_BaseChange) annotation(
    Placement(visible = true, transformation(origin = {-130, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Real PNom_BaseChange = if not ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.PNom] == 0 then ControlledGenFrameParams.genParamValues[gen, ControlledGenFrameParams.genParams.PNom] else 1;
  parameter Types.ActivePowerPu P0Pu;
  parameter Types.ReactivePowerPu Q0Pu;
  parameter Types.VoltageModulePu U0Pu;
  parameter Types.Angle UPhase0;
initial algorithm
  governorNordic.Pm0Pu := generatorSynchronous.Pm0Pu;
  exciterAvrPssOelNordic.Efd0Pu := generatorSynchronous.Efd0Pu;
  exciterAvrPssOelNordic.UStator0Pu := generatorSynchronous.UStator0Pu;
  exciterAvrPssOelNordic.If0Pu := generatorSynchronous.If0Pu;
initial equation
  der(generatorSynchronous.lambdafPu) = 0;
  der(generatorSynchronous.lambdaDPu) = 0;
  der(generatorSynchronous.lambdaQ1Pu) = 0;
  der(generatorSynchronous.lambdaQ2Pu) = 0;
  der(generatorSynchronous.theta) = 0;
  der(generatorSynchronous.omegaPu.value) = 0;
equation
// Connections
  connect(generatorSynchronous.terminal, terminal) annotation(
    Line);
  connect(generatorSynchronous.ifPu, exciterAvrPssOelNordic.ifPu);
  connect(generatorSynchronous.UStatorPu.value, exciterAvrPssOelNordic.UStatorPu);
  connect(generatorSynchronous.omegaPu.value, exciterAvrPssOelNordic.omegaPu);
  connect(generatorSynchronous.efdPu.value, exciterAvrPssOelNordic.efdPu);
  connect(generatorSynchronous.omegaPu.value, governorNordic.omegaPu);
  connect(generatorSynchronous.PGenPu, BaseConvChangeSnRef2PNom.u);
  /*generatorSynchronous.ifPu = exciterAvrPssOelNordic.ifPu;
  generatorSynchronous.UStatorPu.value = exciterAvrPssOelNordic.UStatorPu;
  generatorSynchronous.omegaPu.value = exciterAvrPssOelNordic.omegaPu;
  generatorSynchronous.efdPu.value = exciterAvrPssOelNordic.efdPu;
  generatorSynchronous.omegaPu.value = governorNordic.omegaPu;
  generatorSynchronous.PGenPu = BaseConvChangeSnRef2PNom.u;*/
  connect(generatorSynchronous.PmPu, governorNordic.PmPuPin);  
  connect(BaseConvChangeSnRef2PNom.y, governorNordic.PGenPuPNom) annotation(
    Line(points = {{-118, -52}, {-104, -52}, {-104, -52}, {-104, -52}}, color = {0, 0, 127}));
//SwitchOff Signals and additional equations
  generatorSynchronous.switchOffSignal1.value = false;
  generatorSynchronous.switchOffSignal2.value = false;
  generatorSynchronous.switchOffSignal3.value = false;
  generatorSynchronous.omegaRefPu.value = SystemBase.omegaRef0Pu;

annotation(
    Documentation(info = "<html><head></head><body>The controlled generator frame functions as the regulated synchronous generator of the Nordic Test System.<div>It consists of a either a 3 or 4 windings synchronous generator, which models hydro-power or thermal plants respectively.</div><div>The regulating elements comprise overexcitation limitation, automatic voltage regulation, power system stabilisation and speed control.<br>The implementation utilises a generator preset, which automatically sets the parameters of all elements to those of the corresponding chosen generator.</div><div>To add another configuration, append a new line to \"genFrameParamValues\", \"govParamValues\" and \"exAvPsOeParamValues\"&nbsp;in Util/ControlledGenFrameParams and append a fitting name in the \"genFramePreset\" enumeration.</div>
</body></html>"));
end ControlledGenFrameNordic;
