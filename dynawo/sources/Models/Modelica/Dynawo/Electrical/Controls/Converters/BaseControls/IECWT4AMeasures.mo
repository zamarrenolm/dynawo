within Dynawo.Electrical.Controls.Converters.BaseControls;

/*
* Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
* See AUTHORS.txt
* All rights reserved.
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, you can obtain one at http://mozilla.org/MPL/2.0/.
* SPDX-License-Identifier: MPL-2.0
*
* This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
*/

model IECWT4AMeasures

  import Modelica;
  import Dynawo.Types;
  import Dynawo.Electrical.SystemBase;

  /*Nominal Parameters*/
  parameter Types.ApparentPowerModule SNom "Nominal converter apparent power in MVA";
  /* PLL parameters */
  parameter Types.Time Tpll "Time constant for PLL first order filter model in seconds";
  parameter Types.PerUnit Upll1 "Voltage below which the angle of the voltage is filtered/frozen in p.u (base UNom)";
  //parameter Types.PerUnit Upll2         "Voltage below which the angle of the voltage is frozen in p.u (base UNom)";
  /*Grid Measurement Parameters*/
  parameter Types.Time Tpfilt "Time constant in active power measurement filter" annotation(
    Dialog(group = "group", tab = "GridMeasurement"));
  parameter Types.Time Tqfilt "Time constant in reactive power measurement filter" annotation(
    Dialog(group = "group", tab = "GridMeasurement"));
  //parameter Types.Time Tifilt "Time constant in current measurement filter" annotation(Dialog(group = "group", tab = "GridMeasurement"));
  //parameter Types.PerUnit dphimax "Maximum rate of change of frequency" annotation(Dialog(group = "group", tab = "GridMeasurement"));
  parameter Types.Time Tufilt "Time constant in voltage measurement filter" annotation(
    Dialog(group = "group", tab = "GridMeasurement"));
  parameter Types.Time Tffilt "Time constant in frequency measurement filter" annotation(
    Dialog(group = "group", tab = "GridMeasurement"));
  /*Operational Parameters*/
  parameter Types.VoltageModulePu U0Pu "Start value of voltage amplitude at plant terminal (PCC) in p.u (base UNom)" annotation(Dialog(group = "group", tab = "Operating point"));
  parameter Types.Angle UPhase0  "Start value of voltage angle at plan terminal (PCC) in rad" annotation(Dialog(group = "group", tab = "Operating point"));
  parameter Types.ActivePowerPu P0Pu "Start value of active power at PCC in p.u (base SnRef) (receptor convention)" annotation(
    Dialog(group = "group", tab = "Operating point"));
  parameter Types.ReactivePowerPu Q0Pu "Start value of reactive power at PCC in p.u (base SnRef) (receptor convention)" annotation(
    Dialog(group = "group", tab = "Operating point"));
  final parameter Types.ComplexPerUnit u0Pu = ComplexMath.fromPolar(U0Pu, UPhase0) "Start value of the complex voltage at plant terminal (PCC) in p.u (base UNom)";
  final parameter Types.ComplexPerUnit i0Pu = ComplexMath.conj(Complex(P0Pu, Q0Pu) / u0Pu) "Start value of the complex current at plant terminal (PCC) in p.u (base UNom, SnRef)";
  /*Inputs*/
  Modelica.Blocks.Interfaces.RealInput iWtRePu(start = -i0Pu.re * SystemBase.SnRef / SNom) "WTT active current phasor in power system coordinates (Ubase)" annotation(
    Placement(visible = true, transformation(origin = {-110, 100}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {-110, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput iWtImPu(start = -i0Pu.im * SystemBase.SnRef / SNom)"WTT reactive current phasor in power system coordinates (Ubase)" annotation(
    Placement(visible = true, transformation(origin = {-110, 50}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation =0)));
  Modelica.Blocks.Interfaces.RealInput uWtRePu(start = u0Pu.re) "WTT active voltage phasor in power system coordinates (Ubase)" annotation(
    Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput uWtImPu(start = u0Pu.im) "WTT reactive voltage phasor in power system coordinates (Ubase)" annotation(
    Placement(visible = true, transformation(origin = {-110, -50}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {-110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput fsysPu(start = 1) "Global power system grid frequency applied for frequency measurements because angles are calculated in the corresponding stationary reference frame" annotation(
    Placement(visible = true, transformation(origin = {-110, -100}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {-110, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  /*Outputs*/
  Modelica.Blocks.Interfaces.RealOutput pWTCfiltPu(start = -P0Pu * SystemBase.SnRef / SNom) "Filtered WTT active power (Sbase)" annotation(
    Placement(visible = true, transformation(origin = {110, 100}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput qWTCfiltPu(start = -Q0Pu * SystemBase.SnRef / SNom) "Filtered WTT reactive power (Sbase)" annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {110, -82.5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput uWTCPu(start = U0Pu) "WTT voltage phasor in power system coordinates (Ubase)" annotation(
    Placement(visible = true, transformation(origin = {110, 17.5}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {110, 82.5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput uWTCfiltPu(start = U0Pu) "Filtered WTT voltage phasor in power system coordinates (Ubase)" annotation(
    Placement(visible = true, transformation(origin = {110, -17.5}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput theta(start = UPhase0) "Phase shift between the converter's rotating frame and the grid rotating frame in radians" annotation(
    Placement(visible = true, transformation(origin = {110, -50}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {110, -17.5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput ffiltPu(start = 1) "Filtered global power system grid frequency applied for frequency measurements because angles are calculated in the corresponding stationary reference frame" annotation(
    Placement(visible = true, transformation(origin = {110, -94.5}, extent = {{-10,-10}, {10,10}}, rotation = 0), iconTransformation(origin = {110, 17.5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  /*Other calculated variables*/
  Types.PerUnit PGenPu(start = -P0Pu) "Active power generated by the converter at the PCC in p.u (base UNom, SnRef) (generator convention)";
  Types.PerUnit QGenPu(start = -Q0Pu) "Reactive power generated by the converter at the PCC in p.u (base UNom, SnRef) (generator convention)";
  Types.PerUnit PGenPuBaseSNom(start = -P0Pu * (SystemBase.SnRef / SNom)) "Active power generated by the converter at the PCC in p.u (base UNom, SNom) (generator convention)";
  Types.PerUnit QGenPuBaseSNom(start = -Q0Pu * (SystemBase.SnRef / SNom)) "Reactive power generated by the converter at the PCC in p.u (base UNom, SNom) (generator convention) ";
  Types.PerUnit IWtPu(start = sqrt(P0Pu^2 + Q0Pu^2)* SystemBase.SnRef / (SNom * U0Pu)) "Module of the current at PCC in p.u (base UNom, SNom)";
  Types.PerUnit uWtPu(start = U0Pu) "Module of the voltage at PCC in p.u (base UNom, SNom)";
  /*Blocks*/
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T = Tpfilt, y_start = -P0Pu * SystemBase.SnRef / SNom) annotation(
    Placement(visible = true, transformation(origin = {60,100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T = Tqfilt, y_start = -Q0Pu * SystemBase.SnRef / SNom) annotation(
    Placement(visible = true, transformation(origin = {60, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder3(T = Tufilt, y_start = U0Pu) annotation(
    Placement(visible = true, transformation(origin = {60, 0.5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {10, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {8, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {58, -94.5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-40, 105}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product1 annotation(
    Placement(visible = true, transformation(origin = {-40, 77}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product2 annotation(
    Placement(visible = true, transformation(origin = {-40, 49}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product3 annotation(
    Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.RectangularToPolar rectangularToPolar1 annotation(
    Placement(visible = true, transformation(origin = {-40, -44}, extent = {{-10,-10}, {10,10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Derivative derivative(T = Tffilt, k = 1 / SystemBase.omegaNom, x_start = UPhase0, y_start = 0)  annotation(
    Placement(visible = true, transformation(origin = {2, -83.5}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // PLL
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(visible = true, transformation(origin = {82, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold = Upll1) annotation(
    Placement(visible = true, transformation(origin = {37, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = Tpll, k = 1, y_start = UPhase0) annotation(
    Placement(visible = true, transformation(origin = {38, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  /* Non filtered Module of the voltage and the injected current at PCC in p.u. (base UNom, SNom) */
  uWtPu = sqrt(uWtRePu ^ 2 + uWtImPu ^ 2);
  IWtPu= sqrt(iWtRePu ^ 2 + iWtImPu ^ 2);
  /* Injected power at PCC in nominal and system bases */
  PGenPuBaseSNom = uWtRePu * iWtRePu + uWtImPu* iWtImPu;
  QGenPuBaseSNom = uWtImPu * iWtRePu - uWtRePu * iWtImPu;
  PGenPu = PGenPuBaseSNom * SNom / SystemBase.SnRef;
  QGenPu = QGenPuBaseSNom * SNom / SystemBase.SnRef;
  connect(firstOrder1.y, qWTCfiltPu) annotation(
    Line(points = {{71, 60}, {110, 60}}, color = {0, 0, 127}));
  connect(add2.y, firstOrder1.u) annotation(
    Line(points = {{19, 60}, {48, 60}}, color = {0, 0, 127}));
  connect(add.y, ffiltPu) annotation(
    Line(points = {{69, -94.5}, {110, -94.5}}, color = {0, 0, 127}));
  connect(product2.y, add2.u1) annotation(
    Line(points = {{-29, 49}, {-16, 49}, {-16, 66}, {-4, 66}}, color = {0, 0, 127}));
  connect(iWtRePu, product.u1) annotation(
    Line(points = {{-110, 100}, {-88, 100}, {-88, 111}, {-52, 111}}, color = {0, 0, 127}));
  connect(uWtRePu, product.u2) annotation(
    Line(points = {{-110, 0}, {-80, 0}, {-80, 98}, {-52, 98}, {-52, 99}}, color = {0, 0, 127}));
  connect(iWtImPu, product1.u1) annotation(
    Line(points = {{-110, 50}, {-74, 50}, {-74, 83}, {-52, 83}}, color = {0, 0, 127}));
  connect(uWtImPu, product1.u2) annotation(
    Line(points = {{-110, -50}, {-68, -50}, {-68, 71}, {-52, 71}}, color = {0, 0, 127}));
  connect(uWtRePu, rectangularToPolar1.u_re) annotation(
    Line(points = {{-110, 0}, {-80, 0}, {-80, -38}, {-52, -38}}, color = {0, 0, 127}));
  connect(rectangularToPolar1.y_abs, firstOrder3.u) annotation(
    Line(points = {{-29, -38}, {14, -38}, {14, 0.5}, {48, 0.5}}, color = {0, 0, 127}));
  connect(firstOrder3.y, uWTCfiltPu) annotation(
    Line(points = {{71, 0.5}, {91, 0.5}, {91, -18}, {110, -18}}, color = {0, 0, 127}));
  connect(uWtImPu, rectangularToPolar1.u_im) annotation(
    Line(points = {{-110, -50}, {-52, -50}}, color = {0, 0, 127}));
  connect(rectangularToPolar1.y_arg, derivative.u) annotation(
    Line(points = {{-29, -50}, {-22, -50}, {-22, -81.75}, {-10, -81.75}, {-10, -83.5}}, color = {0, 0, 127}));
  connect(derivative.y, add.u1) annotation(
    Line(points = {{13, -83.5}, {30, -83.5}, {30, -88.5}, {46, -88.5}}, color = {0, 0, 127}));
  connect(fsysPu, add.u2) annotation(
    Line(points = {{-110, -100}, {46, -100}, {46, -100.5}}, color = {0, 0, 127}));
  connect(iWtRePu, product2.u1) annotation(
    Line(points = {{-110, 100}, {-88, 100}, {-88, 54}, {-52, 54}, {-52, 55}}, color = {0, 0, 127}));
  connect(uWtImPu, product2.u2) annotation(
    Line(points = {{-110, -50}, {-68, -50}, {-68, 42}, {-52, 42}, {-52, 43}}, color = {0, 0, 127}));
  connect(rectangularToPolar1.y_abs, uWTCPu) annotation(
    Line(points = {{-28, -38}, {14, -38}, {14, 18}, {110, 18}, {110, 18}}, color = {0, 0, 127}));
  connect(firstOrder2.y, pWTCfiltPu) annotation(
    Line(points = {{72, 100}, {104, 100}, {104, 100}, {110, 100}}, color = {0, 0, 127}));
  connect(add1.y, firstOrder2.u) annotation(
    Line(points = {{22, 100}, {46, 100}, {46, 100}, {48, 100}}, color = {0, 0, 127}));
  connect(product3.y, add2.u2) annotation(
    Line(points = {{-28, 20}, {-12, 20}, {-12, 52}, {-4, 52}, {-4, 54}}, color = {0, 0, 127}));
  connect(iWtImPu, product3.u1) annotation(
    Line(points = {{-110, 50}, {-92, 50}, {-92, 26}, {-52, 26}}, color = {0, 0, 127}));
  connect(uWtRePu, product3.u2) annotation(
    Line(points = {{-110, 0}, {-58, 0}, {-58, 14}, {-52, 14}, {-52, 14}}, color = {0, 0, 127}));
  connect(lessThreshold.y, switch1.u2) annotation(
    Line(points = {{48, -30}, {56, -30}, {56, -50}, {70, -50}, {70, -50}}, color = {255, 0, 255}));
  connect(rectangularToPolar1.y_abs, lessThreshold.u) annotation(
    Line(points = {{-28, -38}, {14, -38}, {14, -30}, {24, -30}, {24, -30}, {26, -30}}, color = {0, 0, 127}));
  connect(firstOrder.y, switch1.u1) annotation(
    Line(points = {{50, -60}, {60, -60}, {60, -42}, {70, -42}, {70, -42}}, color = {0, 0, 127}));
  connect(switch1.y, theta) annotation(
    Line(points = {{94, -50}, {104, -50}, {104, -50}, {110, -50}}, color = {0, 0, 127}));
  connect(rectangularToPolar1.y_arg, firstOrder.u) annotation(
    Line(points = {{-28, -50}, {18, -50}, {18, -60}, {26, -60}, {26, -60}}, color = {0, 0, 127}));
  connect(rectangularToPolar1.y_arg, switch1.u3) annotation(
    Line(points = {{-28, -50}, {18, -50}, {18, -76}, {64, -76}, {64, -58}, {70, -58}, {70, -58}}, color = {0, 0, 127}));
  connect(product.y, add1.u1) annotation(
    Line(points = {{-28, 106}, {-2, 106}, {-2, 106}, {-2, 106}}, color = {0, 0, 127}));
  connect(product1.y, add1.u2) annotation(
    Line(points = {{-28, 78}, {-18, 78}, {-18, 94}, {-2, 94}, {-2, 94}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-100, -120}, {100, 120}}, initialScale = 0.1)),
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}), Text(origin = {0, -25}, extent = {{-100, -20}, {100,20}}, textString = "Module"), Text(origin = {0,25}, extent = {{-100, -30}, {100, 30}}, textString = "Measurement")}));

end IECWT4AMeasures;
