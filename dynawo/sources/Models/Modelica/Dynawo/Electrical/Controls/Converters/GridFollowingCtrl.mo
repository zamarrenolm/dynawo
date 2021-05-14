within Dynawo.Electrical.Controls.Converters;

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

model GridFollowingCtrl "Grid Forming Control with Droop Control"

  import Modelica;
  import Dynawo;
  import Dynawo.Types;
  import Dynawo.Connectors;
  import Dynawo.Electrical.SystemBase;

  parameter Types.PerUnit tauQref "";
  parameter Types.PerUnit tauPref "";    parameter Types.PerUnit Kpc "Proportional gain of the current loop";
  parameter Types.PerUnit Kic "Integral gain of the current loop";
  parameter Types.PerUnit Lfilter "Filter inductance in p.u (base UNom, SNom)";
  parameter Types.PerUnit Rfilter "Filter resistance in p.u (base UNom, SNom)";
  parameter Types.PerUnit Cfilter "Filter capacitance in p.u (base UNom, SNom)";
  parameter Types.PerUnit KpPll "Proportional gain of the PLL";
  parameter Types.PerUnit KiPll "Integral gain of the PLL";
  parameter Types.PerUnit Idmax "";
  parameter Types.PerUnit Idmin "";
  parameter Types.PerUnit Iqmax "";
  parameter Types.PerUnit Iqmin "";
  parameter Types.PerUnit Kpdc "Proportional gain of the dc voltage control";
  Modelica.Blocks.Interfaces.RealInput omegaRefPu (start = SystemBase.omegaRef0Pu) "grid frequency in p.u" annotation(
    Placement(visible = true, transformation(origin = {72, 57}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = {90,-105}, extent = {{-5, -5}, {5, 5}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput udFilterPu (start = UdFilter0Pu) "d-axis voltage at the converter's capacitor in p.u (base UNom)" annotation(
    Placement(visible = true, transformation(origin = {-58, -31}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = {87, 105}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput uqFilterPu (start = 0) "q-axis voltage at the converter's capacitor in p.u (base UNom)" annotation(
    Placement(visible = true, transformation(origin = {-58, -17}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = {-93, 105}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput idConvPu (start = IdConv0Pu) "d-axis current created by the converter in p.u (base UNom, SNom) (generator convention)" annotation(
    Placement(visible = true, transformation(origin = {-58, -1}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = { 30, 105}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput iqConvPu (start = IqConv0Pu) "q-axis current created by the converter in p.u (base UNom, SNom) (generator convention)" annotation(
    Placement(visible = true, transformation(origin = {-58, -6}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = { -33, 105}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput PRefPu (start = PRef0Pu) "active power reference at the converter's capacitor in p.u (base SNom)" annotation(
    Placement(visible = true, transformation(origin = {-58, 53}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = { -105, 100}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput QRefPu (start = QRef0Pu) "reactive power reference at the converter's capacitor in p.u (base SNom)" annotation(
    Placement(visible = true, transformation(origin = {-93, 18}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = { -105, 60}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput IdcSourceRefPu (start = IdcSourceRef0Pu) "reference DC Current generated by the DC current source in p.u (base UNom, SNom)" annotation(
    Placement(visible = true, transformation(origin = {-58, -38}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = {-105, -60}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput UdcSourceRefPu (start = UdcSource0Pu) "reference DC voltage on the DC side in p.u (base UNom, SNom)" annotation(
    Placement(visible = true, transformation(origin = {-58, -46}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = { -105, -100}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput UdcSourcePu (start = UdcSource0Pu) "DC voltage on the DC side in p.u (base UNom, SNom)" annotation(
    Placement(visible = true, transformation(origin = {-58, -54}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = { 0, 105}, extent = {{-5, -5}, {5, 5}}, rotation = -90)));

  Modelica.Blocks.Interfaces.RealInput UFilterRefPu (start = UdFilter0Pu) "reference voltage at the converter's capacitor in p.u (base UNom)" annotation(
    Placement(visible = true, transformation(origin = {-71, 38}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = { -105, 0}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput theta (start = Theta0) "Phase shift between the converter's rotating frame and the grid rotating frame" annotation(
    Placement(visible = true, transformation(origin = {126, 27}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = {105, 90}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput udConvRefPu (start = UdConv0Pu) "reference d-axis modulated voltage created by the converter in p.u (base UNom)" annotation(
    Placement(visible = true, transformation(origin = {173, 53}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = {105, 40}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput uqConvRefPu (start = UqConv0Pu) "reference q-axis modulated voltage created by the converter in p.u (base UNom)" annotation(
    Placement(visible = true, transformation(origin = {173, 35}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = {105, -40}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput IdcSourcePu (start = IdcSource0Pu) "DC Current generated by the DC current source in p.u (base UNom, SNom)" annotation(
    Placement(visible = true, transformation(origin = {67, -46}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = {105, 0}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omegaPu (start = 0) "Converter's frequency" annotation(
    Placement(visible = true, transformation(origin = {120, 48}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = {105, -90}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput UdcSourceRefOutPu (start = UdcSource0Pu) "reference DC voltage on the DC side in p.u (base UNom, SNom)" annotation(
    Placement(visible = true, transformation(origin = {-4, -51}, extent = {{-3, -3}, {3, 3}}, rotation = 0), iconTransformation(origin = {105, -70}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));

  Dynawo.Electrical.Controls.Converters.BaseControls.CurrentLoop currentLoop(Kic = Kic, Kpc = Kpc, Lfilter = Lfilter, Rfilter = Rfilter, UdConv0Pu = UdConv0Pu, UqConv0Pu = UqConv0Pu, UdFilter0Pu = UdFilter0Pu, IdConv0Pu=IdConv0Pu, IqConv0Pu=IqConv0Pu)  annotation(
    Placement(visible = true, transformation(origin = {153, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Dynawo.Electrical.Controls.Converters.BaseControls.DCVoltageControl dCVoltageControl(Kpdc = Kpdc, IdcSource0Pu = IdcSource0Pu, IdcSourceRef0Pu = IdcSourceRef0Pu, UdcSource0Pu = UdcSource0Pu)  annotation(
    Placement(visible = true, transformation(origin = {45, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = tauPref, y_start = PRef0Pu)  annotation(
    Placement(visible = true, transformation(origin = {-35, 54}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T = tauQref, y_start = QRef0Pu) annotation(
    Placement(visible = true, transformation(origin = {-59, 18}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Division division annotation(
    Placement(visible = true, transformation(origin = {-3, 51}, extent = {{-5, -5}, {5, 5}}, rotation = 0)));
  Modelica.Blocks.Math.Division division1 annotation(
    Placement(visible = true, transformation(origin = {1, 17}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter annotation(
    Placement(visible = true, transformation(origin = {23, 51}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant0(k = Idmax)  annotation(
    Placement(visible = true, transformation(origin = {-2, 73}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = Idmin) annotation(
    Placement(visible = true, transformation(origin = {-2, 35}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter1 annotation(
    Placement(visible = true, transformation(origin = {48, 17}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant2(k = Iqmin) annotation(
    Placement(visible = true, transformation(origin = {20, 8}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant3(k = Iqmax) annotation(
    Placement(visible = true, transformation(origin = {21, 30}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Continuous.PI PLL(T = 1 / KiPll, k = KpPll)  annotation(
    Placement(visible = true, transformation(origin = {65.5, 40.5}, extent = {{-5.5, -5.5}, {5.5, 5.5}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator integrator(k = Dynawo.Electrical.SystemBase.omegaNom, y_start = Theta0)  annotation(
    Placement(visible = true, transformation(origin = {95, 27}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {94.5, 44.5}, extent = {{-5.5, -5.5}, {5.5, 5.5}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 0)  annotation(
    Placement(visible = true, transformation(origin = {-45.5, 37.5}, extent = {{-5.5, -5.5}, {5.5, 5.5}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {-20.5, 20.5}, extent = {{-5.5, -5.5}, {5.5, 5.5}}, rotation = 0)));
protected

  parameter Types.PerUnit IdPcc0Pu;
  parameter Types.PerUnit IqPcc0Pu;
  parameter Types.PerUnit UdFilter0Pu;
  parameter Types.PerUnit IdConv0Pu;
  parameter Types.PerUnit IqConv0Pu;
  parameter Types.PerUnit UdConv0Pu;
  parameter Types.PerUnit UqConv0Pu;
  parameter Types.Angle Theta0;
  parameter Types.PerUnit PRef0Pu;
  parameter Types.PerUnit QRef0Pu;
  parameter Types.PerUnit IdcSourceRef0Pu;
  parameter Types.PerUnit IdcSource0Pu;
  parameter Types.PerUnit UdcSource0Pu;
equation
  connect(udFilterPu, currentLoop.udFilterPu) annotation(
    Line(points = {{-58, -31}, {145, -31}, {145, 33}}, color = {0, 0, 127}));
  connect(uqFilterPu, currentLoop.uqFilterPu) annotation(
    Line(points = {{-58, -17}, {149, -17}, {149, 33}}, color = {0, 0, 127}));
  connect(idConvPu, currentLoop.idConvPu) annotation(
    Line(points = {{-58, -1}, {157, -1}, {157, 33}}, color = {0, 0, 127}));
  connect(iqConvPu, currentLoop.iqConvPu) annotation(
    Line(points = {{-58, -6}, {161, -6}, {161, 33}}, color = {0, 0, 127}));
  connect(UdcSourceRefPu, dCVoltageControl.UdcSourceRefPu) annotation(
    Line(points = {{-58, -46}, {34, -46}}, color = {0, 0, 127}));
  connect(IdcSourceRefPu, dCVoltageControl.IdcSourceRefPu) annotation(
    Line(points = {{-58, -38}, {34, -38}}, color = {0, 0, 127}));
  connect(UdcSourcePu, dCVoltageControl.UdcSourcePu) annotation(
    Line(points = {{-58, -54}, {34, -54}}, color = {0, 0, 127}));
  connect(currentLoop.udConvRefPu, udConvRefPu) annotation(
    Line(points = {{164, 53}, {173, 53}}, color = {0, 0, 127}));
  connect(currentLoop.uqConvRefPu, uqConvRefPu) annotation(
    Line(points = {{164, 35}, {173, 35}}, color = {0, 0, 127}));
  connect(dCVoltageControl.IdcSourcePu, IdcSourcePu) annotation(
    Line(points = {{56, -46}, {67, -46}}, color = {0, 0, 127}));
  connect(UdcSourceRefPu, UdcSourceRefOutPu) annotation(
    Line(points = {{-58, -46}, {-25, -46}, {-25, -51}, {-4, -51}}, color = {0, 0, 127}));
  connect(PRefPu, firstOrder.u) annotation(
    Line(points = {{-58, 53}, {-50.5, 53}, {-50.5, 54}, {-43, 54}}, color = {0, 0, 127}));
  connect(QRefPu, firstOrder1.u) annotation(
    Line(points = {{-93, 18}, {-67, 18}}, color = {0, 0, 127}));
  connect(variableLimiter.y, currentLoop.idConvRefPu) annotation(
    Line(points = {{30, 51}, {85.5, 51}, {85.5, 53}, {142, 53}}, color = {0, 0, 127}));
  connect(constant0.y, variableLimiter.limit1) annotation(
    Line(points = {{5, 73}, {11, 73}, {11, 56}, {16, 56}}, color = {0, 0, 127}));
  connect(constant1.y, variableLimiter.limit2) annotation(
    Line(points = {{5, 35}, {8, 35}, {8, 46}, {16, 46}}, color = {0, 0, 127}));
  connect(division.y, variableLimiter.u) annotation(
    Line(points = {{3, 51}, {16, 51}}, color = {0, 0, 127}));
  connect(division1.y, variableLimiter1.u) annotation(
    Line(points = {{9, 17}, {41, 17}}, color = {0, 0, 127}));
  connect(variableLimiter1.limit2, constant2.y) annotation(
    Line(points = {{41, 12}, {27, 12}, {27, 8}}, color = {0, 0, 127}));
  connect(constant3.y, variableLimiter1.limit1) annotation(
    Line(points = {{28, 30}, {33, 30}, {33, 22}, {41, 22}}, color = {0, 0, 127}));
  connect(variableLimiter1.y, currentLoop.iqConvRefPu) annotation(
    Line(points = {{55, 17}, {143, 17}, {143, 35.5}, {142, 35.5}, {142, 35}}, color = {0, 0, 127}));
  connect(integrator.u, PLL.y) annotation(
    Line(points = {{88, 27}, {72, 27}, {72, 40.5}}, color = {0, 0, 127}));
  connect(uqFilterPu, PLL.u) annotation(
    Line(points = {{-58, -17}, {59, -17}, {59, 40.5}}, color = {0, 0, 127}));
  connect(integrator.y, theta) annotation(
    Line(points = {{102, 27}, {126, 27}}, color = {0, 0, 127}));
  connect(add.y, currentLoop.omegaPu) annotation(
    Line(points = {{101, 45}, {142, 45}, {142, 44}, {142, 44}}, color = {0, 0, 127}));
  connect(add.y, omegaPu) annotation(
    Line(points = {{101, 45}, {118, 45}, {118, 48}, {120, 48}}, color = {0, 0, 127}));
  connect(PLL.y, add.u2) annotation(
    Line(points = {{72, 41}, {87, 41}, {87, 41}, {88, 41}}, color = {0, 0, 127}));
  connect(firstOrder.y, division.u1) annotation(
    Line(points = {{-27, 54}, {-9, 54}}, color = {0, 0, 127}));
  connect(udFilterPu, division1.u2) annotation(
    Line(points = {{-58, -31}, {-11, -31}, {-11, 13}, {-7, 13}, {-7, 13}}, color = {0, 0, 127}));
  connect(udFilterPu, division.u2) annotation(
    Line(points = {{-58, -31}, {-11, -31}, {-11, 48}, {-9, 48}}, color = {0, 0, 127}));
  connect(UFilterRefPu, gain.u) annotation(
    Line(points = {{-71, 38}, {-52, 38}}, color = {0, 0, 127}));
  connect(add1.y, division1.u1) annotation(
    Line(points = {{-14, 21}, {-8, 21}, {-8, 21}, {-7, 21}}, color = {0, 0, 127}));
  connect(firstOrder1.y, add1.u2) annotation(
    Line(points = {{-51, 18}, {-28, 18}, {-28, 17}, {-27, 17}}, color = {0, 0, 127}));
  connect(gain.y, add1.u1) annotation(
    Line(points = {{-39, 38}, {-34, 38}, {-34, 24}, {-27, 24}, {-27, 24}}, color = {0, 0, 127}));
  connect(omegaRefPu, add.u1) annotation(
    Line(points = {{72, 57}, {79, 57}, {79, 47}, {88, 47}, {88, 48}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(grid = {1, 1}, extent = {{-55, -60}, {64, 60}})),
    preferredView = "diagram",
    Icon(coordinateSystem(grid = {1, 1})));

end GridFollowingCtrl;
