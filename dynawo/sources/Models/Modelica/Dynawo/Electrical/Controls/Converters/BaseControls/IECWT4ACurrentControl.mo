within Dynawo.Electrical.Controls.Converters.BaseControls;

model IECWT4ACurrentControl

  import Modelica;
  import Dynawo.Types;
  import Dynawo.Connectors;
  import Dynawo.Electrical.SystemBase;

  /*Nominal Parameters*/
  parameter Types.ApparentPowerModule SNom "Nominal converter apparent power in MVA";

  /*Electrical Parameters*/
  parameter Types.PerUnit Res "Electrical System resistance in p.u (base UNom, SNom)" annotation(
    Dialog(group = "group", tab = "Electrical"));
  parameter Types.PerUnit Xes "Electrical System inductance in p.u (base UNom, SNom)" annotation(
    Dialog(group = "group", tab = "Electrical"));
  parameter Types.PerUnit Ges "Electrical System shunt conductance in p.u (Ubase, Sbase)" annotation(
    Dialog(group = "group", tab = "Electrical"));
  parameter Types.PerUnit Bes "Electrical System shunt susceptance in p.u (Ubase, Sbase)" annotation(
    Dialog(group = "group", tab = "Electrical"));
  parameter Types.PerUnit Rfilter "Converter filter resistance in p.u (base UNom, SNom)" annotation(
    Dialog(group = "group", tab = "Electrical"));
  parameter Types.PerUnit Lfilter "Converter filter inductance in p.u (base UNom, SNom)" annotation(
    Dialog(group = "group", tab = "Electrical"));
  parameter Types.PerUnit Cfilter "Converter filter capacitance in p.u (base UNom, SNom)" annotation(
    Dialog(group = "group", tab = "Electrical"));

  /*CurrentControl*/
  parameter Types.PerUnit Kpc "Proportional gain of the current loop";
  parameter Types.PerUnit Kic "Integral gain of the current loop";

  /*Operational Parameters*/
  parameter Types.VoltageModulePu U0Pu "Start value of voltage amplitude at plant terminal (PCC) in p.u (base UNom)" annotation(
  Dialog(group = "group", tab = "Operating point"));
  parameter Types.Angle UPhase0 "Start value of voltage angle at plan terminal (PCC) in radians" annotation(
  Dialog(group = "group", tab = "Operating point"));
  parameter Types.ActivePowerPu P0Pu "Start value of active power at PCC in p.u (base SnRef) (receptor convention)" annotation(
  Dialog(group = "group", tab = "Operating point"));
  parameter Types.ReactivePowerPu Q0Pu "Start value of reactive power at PCC in p.u (base SnRef) (receptor convention)" annotation(
  Dialog(group = "group", tab = "Operating point"));

  /*Parameters for internal initialization*/
  final parameter Types.ComplexPerUnit u0Pu = ComplexMath.fromPolar(U0Pu, UPhase0) "Start value of the complex voltage at plant terminal (PCC) in p.u (base UNom)";
  final parameter Types.ComplexPerUnit i0Pu = ComplexMath.conj(Complex(P0Pu, Q0Pu) / u0Pu) "Start value of the complex current at plant terminal (PCC) in p.u (base UNom, SnRef) (receptor convention)";

  final parameter Types.PerUnit UGsRe0Pu = u0Pu.re - Res * (i0Pu.re* SystemBase.SnRef / SNom) + Xes * (i0Pu.im* SystemBase.SnRef / SNom) "Starting value of the real component of the voltage at the converter's terminals (generator system) in p.u (base UNom)" annotation(
 Dialog(group = "group", tab = "Operating point"));
  final parameter Types.PerUnit UGsIm0Pu = u0Pu.im - Res * (i0Pu.im* SystemBase.SnRef / SNom) - Xes * (i0Pu.re* SystemBase.SnRef / SNom) "Real component of the voltage at the converter's terminals (generator system) in p.u (base UNom)"annotation(
 Dialog(group = "group", tab = "Operating point"));

  final parameter Types.PerUnit IGsRe0Pu = (-i0Pu.re * SystemBase.SnRef / SNom) + (u0Pu.re * Ges - u0Pu.im*Bes) "Initial value of the real component of the current at the generator system module (converter) terminal in p.u (Ubase, SNom) in generator convention" annotation(
    Dialog(group = "group", tab = "Operating point"));
  final parameter Types.PerUnit IGsIm0Pu = (-i0Pu.im * SystemBase.SnRef / SNom )+ (u0Pu.re * Bes + u0Pu.im * Ges) "Initial value of the imaginary component of the current at the generator system module (converter) terminal in p.u (Ubase, SNom) in generator convention" annotation(
    Dialog(group = "group", tab = "Operating point"));

  final parameter Types.PerUnit UGsp0Pu = UGsRe0Pu * cos(UPhase0) + UGsIm0Pu * sin(UPhase0) "Start value of the d-axis voltage at the converter terminal (filter) in p.u (base UNom)";
  final parameter Types.PerUnit UGsq0Pu = -UGsRe0Pu * sin(UPhase0) + UGsIm0Pu * cos(UPhase0) "Start value of the q-axis voltage at the converter terminal (filter) in p.u (base UNom)";

  final parameter Types.PerUnit IGsp0Pu = IGsRe0Pu * cos(UPhase0) + IGsIm0Pu * sin(UPhase0) "Start value of the d-axis current injected at the PCC in p.u (base UNom, SNom) (generator convention)";
  final parameter Types.PerUnit IGsq0Pu = -IGsRe0Pu * sin(UPhase0) + IGsIm0Pu * cos(UPhase0) "Start value of the q-axis current injected at the PCC in p.u (base UNom, SNom) (generator convention)";

  final parameter Types.PerUnit IpCmd0Pu = IGsp0Pu - SystemBase.omegaRef0Pu * Cfilter * UGsp0Pu "Start value of the d-axis current injected at the PCC in p.u (base UNom, SNom) (generator convention)";
  final parameter Types.PerUnit IqCmd0Pu = IGsq0Pu + SystemBase.omegaRef0Pu * Cfilter * UGsq0Pu "Start value of the q-axis current injected at the PCC in p.u (base UNom, SNom) (generator convention)";

  final parameter Types.PerUnit UpCmd0Pu = UGsp0Pu + Rfilter * IpCmd0Pu - SystemBase.omegaRef0Pu * Lfilter *IqCmd0Pu "Start value of the d-axis voltage at the converter terminal (filter) in p.u (base UNom)";
  final parameter Types.PerUnit UqCmd0Pu = UGsq0Pu + Rfilter * IqCmd0Pu + SystemBase.omegaRef0Pu * Lfilter * IpCmd0Pu "Start value of the q-axis voltage at the converter terminal (filter) in p.u (base UNom)";

  /*Inputs*/
  Modelica.Blocks.Interfaces.RealInput omegaPu(start = SystemBase.omegaRef0Pu) "Converter's frequency" annotation(
 Placement(visible = true, transformation(origin = {-160, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-151, -91}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput ipCmdPu(start = IpCmd0Pu) "d-axis current in the converter" annotation(
 Placement(visible = true, transformation(origin = {-159, 52}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {40, 150}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput iqCmdPu(start = IqCmd0Pu) "q-axis current in the converter" annotation(
 Placement(visible = true, transformation(origin = {-160, -45}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {100, 150}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput uGspPu(start = UGsp0Pu) "d-axis voltage at the converter's capacitor in p.u (base UNom)" annotation(
 Placement(visible = true, transformation(origin = {80, 159}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {-100, 150}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput uGsqPu(start = UGsq0Pu) "q-axis voltage at the converter's capacitor in p.u (base UNom)" annotation(
 Placement(visible = true, transformation(origin = {80, -160}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {-39, 150}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput ipCmdRefPu(start = IpCmd0Pu) "d-axis current reference in the converter" annotation(
 Placement(visible = true, transformation(origin = {-159, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-150, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iqCmdRefPu(start = IqCmd0Pu) "q-axis current reference in the converter" annotation(
 Placement(visible = true, transformation(origin = {-160, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-150, -1}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  /*Outputs*/
  Modelica.Blocks.Interfaces.RealOutput upCmdPu(start = UpCmd0Pu) "d-axis modulation voltage reference" annotation(
 Placement(visible = true, transformation(origin = {159, 91}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {150, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput uqCmdPu(start = UqCmd0Pu) "q-axis modulation voltage reference" annotation(
 Placement(visible = true, transformation(origin = {160, -86}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {150, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Blocks.Math.Gain gaind (k = Kpc) annotation(
 Placement(visible = true, transformation(origin = {-12, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integratord( k = Kic,y_start = Rfilter * IpCmd0Pu) annotation(
 Placement(visible = true, transformation(origin = {-12, 112}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedbackd annotation(
 Placement(visible = true, transformation(origin = {-62, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedbackq annotation(
 Placement(visible = true, transformation(origin = {-62, -80}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gainq(k = Kpc) annotation(
 Placement(visible = true, transformation(origin = {-12, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integratorq(k = Kic, y_start = Rfilter * IqCmd0Pu) annotation(
 Placement(visible = true, transformation(origin = {-12, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
 Placement(visible = true, transformation(origin = {-48, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
 Placement(visible = true, transformation(origin = {-48, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain GainLfd (k=Lfilter) annotation(
 Placement(visible = true, transformation(origin = {-12, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain GainLfq (k=Lfilter) annotation(
 Placement(visible = true, transformation(origin = {-12, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addd1 annotation(
 Placement(visible = true, transformation(origin = {34, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addq1 annotation(
 Placement(visible = true, transformation(origin = {34, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedbackLwq annotation(
 Placement(visible = true, transformation(origin = {70, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add feedbackLwd annotation(
 Placement(visible = true, transformation(origin = {74, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addd2 annotation(
 Placement(visible = true, transformation(origin = {112, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add addq2 annotation(
 Placement(visible = true, transformation(origin = {114, -86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation

 connect(integratord.u, feedbackd.y) annotation(
    Line(points = {{-24, 112}, {-54, 112}, {-54, 80}, {-53, 80}}, color = {0, 0, 127}));
 connect(gainq.u, feedbackq.y) annotation(
 Line(points = {{-24, -80}, {-53, -80}}, color = {0, 0, 127}));
 connect(product.u2, omegaPu) annotation(
    Line(points = {{-60, 16}, {-122, 16}, {-122, 0}, {-160, 0}}, color = {0, 0, 127}));
 connect(product1.u1, omegaPu) annotation(
    Line(points = {{-60, -12}, {-122, -12}, {-122, 0}, {-160, 0}}, color = {0, 0, 127}));
 connect(integratorq.u, feedbackq.y) annotation(
 Line(points = {{-24, -110}, {-53, -110}, {-53, -80}}, color = {0, 0, 127}));
 connect(GainLfd.u, product.y) annotation(
 Line(points = {{-24, 22}, {-37, 22}}, color = {0, 0, 127}));
 connect(GainLfq.u, product1.y) annotation(
 Line(points = {{-24, -18}, {-37, -18}}, color = {0, 0, 127}));
 connect(addd1.u2, gaind.y) annotation(
 Line(points = {{22, 80}, {0, 80}, {0, 80}, {0, 80}}, color = {0, 0, 127}));
 connect(addd1.u1, integratord.y) annotation(
 Line(points = {{22, 92}, {20, 92}, {20, 112}, {0, 112}, {0, 112}}, color = {0, 0, 127}));
 connect(addq1.u1, gainq.y) annotation(
 Line(points = {{22, -80}, {0, -80}, {0, -80}, {0, -80}}, color = {0, 0, 127}));
 connect(addq1.u2, integratorq.y) annotation(
 Line(points = {{22, -92}, {20, -92}, {20, -110}, {0, -110}, {0, -110}}, color = {0, 0, 127}));
 connect(feedbackLwq.u1, addd1.y) annotation(
 Line(points = {{62, 86}, {46, 86}, {46, 86}, {46, 86}}, color = {0, 0, 127}));
 connect(feedbackLwq.u2, GainLfq.y) annotation(
 Line(points = {{70, 78}, {70, 78}, {70, -18}, {0, -18}, {0, -18}}, color = {0, 0, 127}));
 connect(feedbackLwd.u2, addq1.y) annotation(
 Line(points = {{62, -86}, {44, -86}, {44, -86}, {46, -86}}, color = {0, 0, 127}));
 connect(feedbackLwd.u1, GainLfd.y) annotation(
 Line(points = {{62, -74}, {60, -74}, {60, 22}, {0, 22}, {0, 22}}, color = {0, 0, 127}));
 connect(addd2.u2, feedbackLwq.y) annotation(
 Line(points = {{100, 86}, {80, 86}, {80, 86}, {80, 86}}, color = {0, 0, 127}));
 connect(addq2.u1, feedbackLwd.y) annotation(
 Line(points = {{102, -80}, {86, -80}, {86, -80}, {86, -80}}, color = {0, 0, 127}));
 connect(ipCmdRefPu, feedbackd.u1) annotation(
    Line(points = {{-159, 80}, {-72, 80}, {-72, 80}, {-70, 80}}, color = {0, 0, 127}));
 connect(ipCmdPu, feedbackd.u2) annotation(
    Line(points = {{-159, 52}, {-62, 52}, {-62, 72}, {-62, 72}}, color = {0, 0, 127}));
 connect(iqCmdPu, feedbackq.u2) annotation(
    Line(points = {{-160, -45}, {-61, -45}, {-61, -72}, {-62, -72}}, color = {0, 0, 127}));
 connect(iqCmdRefPu, feedbackq.u1) annotation(
    Line(points = {{-160, -80}, {-72, -80}, {-72, -80}, {-70, -80}}, color = {0, 0, 127}));
 connect(feedbackd.y, gaind.u) annotation(
    Line(points = {{-53, 80}, {-24, 80}, {-24, 80}, {-24, 80}}, color = {0, 0, 127}));
 connect(ipCmdPu, product.u1) annotation(
    Line(points = {{-159, 52}, {-94, 52}, {-94, 28}, {-60, 28}, {-60, 28}}, color = {0, 0, 127}));
 connect(iqCmdPu, product1.u2) annotation(
    Line(points = {{-160, -45}, {-94, -45}, {-94, -23}, {-60, -23}, {-60, -24}}, color = {0, 0, 127}));
 connect(uGspPu, addd2.u1) annotation(
    Line(points = {{80, 159}, {79, 159}, {79, 97}, {100, 97}, {100, 98}}, color = {0, 0, 127}));
 connect(uGsqPu, addq2.u2) annotation(
    Line(points = {{80, -160}, {79, -160}, {79, -92}, {102, -92}, {102, -92}}, color = {0, 0, 127}));
 connect(addd2.y, upCmdPu) annotation(
    Line(points = {{123, 92}, {145, 92}, {145, 91}, {159, 91}}, color = {0, 0, 127}));
 connect(addq2.y, uqCmdPu) annotation(
    Line(points = {{125, -86}, {146, -86}, {146, -86}, {160, -86}}, color = {0, 0, 127}));

annotation(
 Icon(coordinateSystem(grid = {1, 1}, extent = {{-140, -140}, {140, 140}}, initialScale = 0.1), graphics = {Rectangle(origin = {-0.5, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-139.5, 140}, {140.5, -140}}), Text(origin = {26.5, 7}, extent = {{-149.5, 138}, {97.5, -72}}, textString = "Current"),  Text(origin = {-22.5, -22}, extent = {{-53.5, 30}, {97.5, -72}}, textString = "Loop")}),
 preferredView = "diagram",
 Diagram(coordinateSystem(grid = {1, 1}, extent = {{-140, -140}, {140, 140}})));


end IECWT4ACurrentControl;
