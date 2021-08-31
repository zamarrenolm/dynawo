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

model IECWT4AControl "IEC Wind Turbine type 4A Control"
  import Modelica;
  import Dynawo;
  import Dynawo.Types;
  import Dynawo.Electrical.SystemBase;
  /*Constructive parameters*/
  parameter Types.ApparentPowerModule SNom "Nominal converter apparent power in MVA";
  /* PLL parameters */
  parameter Types.Time Tpll "Time constant for PLL first order filter model in seconds";
  parameter Types.PerUnit Upll1 "Voltage below which the angle of the voltage is filtered/frozen in p.u (base UNom)";
  //parameter Types.PerUnit Upll2         "Voltage below which the angle of the voltage is frozen in p.u (base UNom)";
  /*P control parameters*/
  parameter Types.Time TpOrdp4A "Time constant in power order lag in seconds" annotation(Dialog(group = "group", tab = "Pcontrol"));
  parameter Types.PerUnit DpMaxp4A "Maximum WT power ramp rate" annotation(Dialog(group = "group", tab = "Pcontrol"));
  parameter Types.Time TpWTRef4A "Time constant in reference power order lag in seconds" annotation(Dialog(group = "group", tab = "Pcontrol"));
  parameter Types.PerUnit DpRefMax4A "Maximum WT reference power ramp rate in p.u/s (base SNom) (generator convention)" annotation(Dialog(group = "group", tab = "Pcontrol"));
  parameter Types.PerUnit DpRefMin4A "Minimum WT reference power ramp rate in p.u/s (base SNom) (generator convention)" annotation(Dialog(group = "group", tab = "Pcontrol"));
  parameter Boolean MpUScale "Voltage scaling for power reference during voltage dip (0: no scaling, 1: u scaling)" annotation(Dialog(group = "group", tab = "Pcontrol"));
  parameter Types.PerUnit UpDip "Voltage dip threshold for P control in p.u (base UNom). Part of WT control, often different from converter thersholds" annotation(Dialog(group = "group", tab = "Pcontrol"));
  /*Q control parameters */
  parameter Types.Time Ts "Integration time step";
  parameter Types.PerUnit RDrop "Resistive component of voltage drop impedance in p.u (base SNom, UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit XDrop "Reactive component of voltage drop impedance in p.u (base SNom, UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit UMax "Maximum voltage in voltage PI controller integral term in p.u (base UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit UMin "Minimum voltage in voltage PI controller integral term in p.u (base UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit UqRise "Voltage threshold for OVRT detection in Q control in p.u (base UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit UqDip "Voltage threshold for UVRT detection in Q control in p.u (base UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit UdbOne "Voltage change dead band lower limit (typically negative) in p.u (base UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit UdbTwo "Voltage change dead band upper limit (typically positive) in p.u (base UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit IqMax "Maximum reactive current injection in p.u (base SNom, UNom) (generator convention)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit IqMin "Minimum reactive current injection in p.u (base SNom, UNom) (generator convention)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit IqH1 "Maximum reactive current injection during voltage dip in p.u (base SNom, UNom) (generator convention)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit IqPost "Post fault reactive current injection in p.u (base SNom, UNom) (generator convention)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit IdfHook "User defined fault current injection in p.u (base SNom, UNom) (generator convention)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit IpfHook "User defined post fault current injection in p.u (base SNom, UNom) (generator convention)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.Time Td "Delay flag time constant, specifies the duration F0 will keep the value 2" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.Time Tuss "Time constant of steady state volatage filter" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.Time TqOrd "Time constant in reactive power order lag" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit Kpufrt "Voltage PI controller proportional gain during FRT in p.u (base SNom, UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit Kpu "Voltage PI controller proportional gain in p.u (base SNom, UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit Kiu "Voltage PI controller integration gain in p.u/s (base SNom, UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit Kpq "Active power PI controller proportional gain  in p.u (base SNom, UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit Kiq "Reactive power PI controller integration gain in p.u/s (base SNom, UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit Kqv "Voltage scaling factor for FRT current in p.u (base SNom, UNom)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Types.PerUnit TanPhi "Constant Tangent Phi" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Integer Mqfrt "FRT Q control modes (0-3): Normal operation controller (0), Fault current injection (1)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  parameter Integer MqG "General Q control mode (0-4): Voltage control (0), Reactive power control (1), Power factor control (3)" annotation(
    Dialog(group = "group", tab = "Qcontrol"));
  /*Current Limiter Parameters*/
  parameter Types.PerUnit IMax "Maximum continuous current at the WT terminals in p.u (base UNom, SNom) (generator convention)"  annotation(
    Dialog(group = "group", tab = "CurrentLimit"));
  parameter Types.PerUnit IMaxDip "Maximun current during voltage dip at the WT terlinals in p.u (base UNom, SNom) (generator convention)" annotation(
    Dialog(group = "group", tab = "CurrentLimit"));
  parameter Boolean Mdfslim "Limitation of type 3 stator current (O: total current limitation, 1: stator current limitation)" annotation(
    Dialog(group = "group", tab = "CurrentLimit"));
  parameter Boolean Mqpri "Priorisation of reactive current during FRT (0: active power priority, 1: reactive power priority" annotation(
    Dialog(group = "group", tab = "CurrentLimit"));
  parameter Types.PerUnit IMaxHookPu annotation(
    Dialog(group = "group", tab = "CurrentLimit"));
  parameter Types.PerUnit IqMaxHook annotation(
    Dialog(group = "group", tab = "CurrentLimit"));
  parameter Types.PerUnit UpquMax "WT voltage in the operation point where zero reactive power can be delivered" annotation(
    Dialog(group = "group", tab = "CurrentLimit"));
  parameter Types.PerUnit Kpqu "Partial derivative of reactive current limits vs. voltage" annotation(
    Dialog(group = "group", tab = "CurrentLimit"));
  /*Q limitation Parameters*/
  parameter Boolean QlConst "Fixed reactive power limits (1), 0 otherwise" annotation(Dialog(group = "group", tab = "Qlimit"));
  parameter Types.PerUnit QMax "Fixed value of the maximum reactive power (base SNom) (generator convention)" annotation(Dialog(group = "group", tab = "Qlimit"));
  parameter Types.PerUnit QMin "Fixed value of the minimum reactive power (base SNom) (generator convention)" annotation(Dialog(group = "group", tab = "Qlimit"));
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
  /*Parameters for initialization from load flow*/
  parameter Types.VoltageModulePu U0Pu "Start value of voltage amplitude at plant terminal (PCC) in p.u (base UNom)" annotation(Dialog(group = "group", tab = "Operating point"));
  parameter Types.Angle UPhase0  "Start value of voltage angle at plan terminal (PCC) in rad" annotation(Dialog(group = "group", tab = "Operating point"));
  parameter Types.ActivePowerPu P0Pu "Start value of active power at PCC in p.u (base SnRef) (receptor convention)" annotation(
    Dialog(group = "group", tab = "Operating point"));
  parameter Types.ReactivePowerPu Q0Pu "Start value of reactive power at PCC in p.u (base SnRef) (receptor convention)" annotation(
    Dialog(group = "group", tab = "Operating point"));
  /*Parameters for internal initialization*/
  parameter Types.PerUnit IpMax0Pu "Start value of the maximum active current in p.u (base UNom, SNom)" annotation(
    Dialog(group = "group", tab = "Operating point"));
  parameter Types.PerUnit IqMax0Pu "Start value of the maximum reactive current in p.u (base UNom, SNom)" annotation(
    Dialog(group = "group", tab = "Operating point"));
  parameter Types.PerUnit IqMin0Pu "Start value of the minimum reactive current in p.u (base UNom, SNom)" annotation(
    Dialog(group = "group", tab = "Operating point"));
  parameter Types.PerUnit QMax0Pu "Start value maximum reactive power (Sbase)" annotation(
    Dialog(group = "group", tab = "Operating point"));
  parameter Types.PerUnit QMin0Pu "Start value minimum reactive power (Sbase)" annotation(
    Dialog(group = "group", tab = "Operating point"));
  final parameter Types.ComplexPerUnit u0Pu = ComplexMath.fromPolar(U0Pu, UPhase0) "Start value of the complex voltage at plant terminal (PCC) in p.u (base UNom)";
  final parameter Types.ComplexPerUnit i0Pu = ComplexMath.conj(Complex(P0Pu, Q0Pu) / u0Pu) "Start value of the complex current at plant terminal (PCC) in p.u (base UNom, SnRef)";
/*Inputs*/
  Modelica.Blocks.Interfaces.RealInput iWtRePu(start = -i0Pu.re * SystemBase.SnRef / SNom) "Real component of the current at the wind turbine terminals in p.u (Ubase,SNom) in generator convention" annotation(
    Placement(visible = true, transformation(origin = {-160, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {80, -110}, extent = {{10, -10}, {-10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput iWtImPu(start = -i0Pu.im * SystemBase.SnRef / SNom) "Imaginary component of the current at the wind turbine terminals n p.u (Ubase,SNom) in generator convention" annotation(
    Placement(visible = true, transformation(origin = {-160, 25}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {40, -110}, extent = {{10, 10}, {-10, -10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput uWtRePu(start = u0Pu.re) "Real component of the voltage at the wind turbine (electrical system) terminals in p.u (base UNom)" annotation(
    Placement(visible = true, transformation(origin = {-160, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-40, -110}, extent = {{10, -10}, {-10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput uWtImPu(start = u0Pu.im) "Imaginary component of the voltage at the wind turbine (electrical system) terminals in p.u (base UNom) " annotation(
    Placement(visible = true, transformation(origin = {-160, -25}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-80, -110}, extent = {{10, -10}, {-10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealInput PRefPu(start = -P0Pu * SystemBase.SnRef / SNom ) "Active power reference at the wind turbine terminals in p.u (SNom) in generator convention" annotation(
    Placement(visible = true, transformation(origin = {-161, 114}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 53}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput QRefPu(start = -P0Pu * SystemBase.SnRef / SNom ) "Reactive power reference at the wind turbine terminals in p.u (SNom) in generator convention" annotation(
    Placement(visible = true, transformation(origin = {-160, -113}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -48}, extent = {{-10, 10}, {10, -10}}, rotation = 180)));
  /*Outputs*/
  Modelica.Blocks.Interfaces.RealOutput ipCmdPu(start = -P0Pu * SystemBase.SnRef / (SNom * sqrt(u0Pu.re * u0Pu.re + u0Pu.im * u0Pu.im))) "d-axis reference current at the generator system module (converter) terminal in p.u (Ubase,SNom) in generator convention" annotation(
    Placement(visible = true, transformation(origin = {160, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealOutput iqCmdPu(start = -Q0Pu * SystemBase.SnRef / (SNom * sqrt(u0Pu.re * u0Pu.re + u0Pu.im * u0Pu.im))) "q-axis reference current at the generator system module (converter) terminal in p.u (Ubase,SNom) in generator convention" annotation(
    Placement(visible = true, transformation(origin = {159, -134}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealOutput ipMaxPu(start = IpMax0Pu) "Maximal d-axis reference current at the generator system module (converter) terminal in p.u (Ubase,SNom) in generator convention" annotation(
    Placement(visible = true, transformation(origin = {160, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealOutput iqMaxPu(start = IqMax0Pu) "Maximal q-axis reference current at the generator system module (converter) terminal in p.u (Ubase,SNom) in generator convention" annotation(
    Placement(visible = true, transformation(origin = {160, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealOutput iqMinPu(start = IqMin0Pu) "Minimal q-axis reference current at the generator system module (converter) terminal in p.u (Ubase,SNom) in generator convention" annotation(
    Placement(visible = true, transformation(origin = {160, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealOutput theta(start = UPhase0) "Phase shift between the converter's rotating frame and the grid rotating frame in radians" annotation(
    Placement(visible = true, transformation(origin = {160.5, -60}, extent = {{-10.5, -10.5}, {10.5, 10.5}}, rotation = 0), iconTransformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  /*Blocks*/
  Modelica.Blocks.Math.Gain gain1(k = -1) annotation(
    Placement(visible = true, transformation(origin = {119, -134}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Dynawo.Electrical.Controls.Converters.BaseControls.IECWT4AMeasures iECWT4AMeasures(P0Pu = P0Pu, Q0Pu = Q0Pu,SNom = SNom, Tffilt = Tffilt, Tpfilt = Tpfilt, Tpll = Tpll, Tqfilt = Tqfilt, Tufilt = Tufilt, U0Pu = U0Pu, UPhase0 = UPhase0, Upll1 = Upll1) annotation(
    Placement(visible = true, transformation(origin = {-95, 0}, extent = {{-30, -50}, {30, 50}}, rotation = 0)));
  Dynawo.Electrical.Controls.Converters.BaseControls.IECWT4APControl iECWT4APControl(DpMaxp4A = DpMaxp4A, DpRefMax4A = DpRefMax4A, DpRefMin4A = DpRefMin4A,IpMax0Pu = IpMax0Pu, MpUScale = MpUScale, P0Pu = P0Pu, SNom = SNom, TpOrdp4A = TpOrdp4A, TpWTRef4A = TpWTRef4A, U0Pu = U0Pu, UpDip = UpDip) annotation(
    Placement(visible = true, transformation(origin = {100, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Dynawo.Electrical.Controls.Converters.BaseControls.IECWT4ACurrentLimitation iECWT4ACurrentLimitation( IMax = IMax, IMaxDip = IMaxDip, IMaxHookPu = IMaxHookPu,IpMax0Pu = IpMax0Pu,IqMax0Pu = IqMax0Pu, IqMaxHook = IqMaxHook, IqMin0Pu = IqMin0Pu, Kpqu = Kpqu, Mdfslim = false, Mqpri = Mqpri, P0Pu = P0Pu, Q0Pu = Q0Pu, SNom = SNom, U0Pu = U0Pu, UPhase0 = UPhase0, UpquMax = UpquMax) annotation(
    Placement(visible = true, transformation(origin = {105, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Dynawo.Electrical.Controls.Converters.BaseControls.IECWT4AQControl iECWT4AQControl( IdfHook = IdfHook, IpfHook = IpfHook, IqH1 = IqH1, IqMax = IqMax, IqMin = IqMin, IqPost = IqPost,Kiq = Kiq, Kiu = Kiu, Kpq = Kpq, Kpu = Kpu, Kpufrt = Kpufrt, Kqv = Kqv, MqG = MqG, Mqfrt = Mqfrt, P0Pu = P0Pu, Q0Pu = Q0Pu, QMax0Pu = QMax0Pu, QMin0Pu = QMin0Pu, RDrop = RDrop, SNom = SNom, TanPhi = TanPhi, Td = Td, TqOrd = TqOrd, Ts = Ts, Tuss = Tuss, U0Pu = U0Pu, UMax = UMax, UMin = UMin, UdbOne = UdbOne, UdbTwo = UdbTwo, UqDip = UqDip, UqRise = UqRise, XDrop = XDrop) annotation(
    Placement(visible = true, transformation(origin = {24, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Dynawo.Electrical.Controls.Converters.BaseControls.IECWT4AQLimitation iECWT4AQLimitation(P0Pu = P0Pu, QMax = QMax, QMax0Pu = QMax0Pu, QMin = QMin, QMin0Pu = QMin0Pu, QlConst = QlConst, SNom = SNom, Ts = Ts, U0Pu = U0Pu) annotation(
    Placement(visible = true, transformation(origin = {-50, -125}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1) annotation(
    Placement(visible = true, transformation(origin = {25, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-160, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  connect(iECWT4APControl.ipCmdPu, ipCmdPu) annotation(
    Line(points = {{122, 100}, {156, 100}, {156, 100}, {160, 100}}, color = {0, 0, 127}));
  connect(iECWT4ACurrentLimitation.iqMaxPu, iqMaxPu) annotation(
    Line(points = {{121, 0}, {160, 0}}, color = {0, 0, 127}));
  connect(iECWT4ACurrentLimitation.iqMinPu, iqMinPu) annotation(
    Line(points = {{121, -10}, {137, -10}, {137, -30}, {160, -30}}, color = {0, 0, 127}));
  connect(iECWT4ACurrentLimitation.ipMaxPu, ipMaxPu) annotation(
    Line(points = {{121, 10}, {139, 10}, {139, 30}, {160, 30}}, color = {0, 0, 127}));
  connect(iECWT4ACurrentLimitation.ipMaxPu, iECWT4APControl.ipMaxPu) annotation(
    Line(points = {{121, 10}, {139, 10}, {139, 30}, {65, 30}, {65, 85}, {78, 85}}, color = {0, 0, 127}));
  connect(gain1.y, iqCmdPu) annotation(
    Line(points = {{130, -134}, {159, -134}}, color = {0, 0, 127}));
  connect(iECWT4AMeasures.uWTCPu, iECWT4APControl.uWTCPu) annotation(
    Line(points = {{-62, 41}, {28, 41}, {28, 105}, {78, 105}, {78, 105}}, color = {0, 0, 127}));
  connect(iECWT4AMeasures.uWTCfiltPu, iECWT4APControl.uWTCfiltPu) annotation(
    Line(points = {{-62, 25}, {43, 25}, {43, 95}, {78, 95}, {78, 95}}, color = {0, 0, 127}));
  connect(iECWT4AMeasures.uWTCfiltPu, iECWT4ACurrentLimitation.uWTCfiltPu) annotation(
    Line(points = {{-62, 25}, {43, 25}, {43, 8}, {89, 8}, {89, 6}}, color = {0, 0, 127}));
  connect(iECWT4AMeasures.ffiltPu, gain.u) annotation(
    Line(points = {{-62, 9}, {-38, 9}, {-38, 0}, {17, 0}}, color = {0, 0, 127}));
  connect(iECWT4AQControl.Ffrt, iECWT4ACurrentLimitation.Ffrt) annotation(
    Line(points = {{46, -95}, {55, -95}, {55, -6}, {89, -6}}, color = {255, 127, 0}));
  connect(iECWT4AQControl.iqCmdPu, iECWT4ACurrentLimitation.iqCmdPu) annotation(
    Line(points = {{46, -115}, {63, -115}, {63, -13}, {89, -13}}, color = {0, 0, 127}));
  connect(iECWT4AQControl.iqCmdPu, gain1.u) annotation(
    Line(points = {{46, -115}, {76.5, -115}, {76.5, -134}, {107, -134}}, color = {0, 0, 127}));
  connect(iECWT4AMeasures.uWTCfiltPu, iECWT4AQControl.uWTCfiltPu) annotation(
    Line(points = {{-62, 25}, {-7, 25}, {-7, -84}, {2, -84}, {2, -83.5}}, color = {0, 0, 127}));
  connect(iECWT4AMeasures.pWTCfiltPu, iECWT4AQControl.pWTCfiltPu) annotation(
    Line(points = {{-62, -25}, {-13, -25}, {-13, -90}, {2, -90}}, color = {0, 0, 127}));
  connect(iECWT4AMeasures.qWTCfiltPu, iECWT4AQControl.qWTCfiltPu) annotation(
    Line(points = {{-62, -41}, {-19, -41}, {-19, -96.5}, {2, -96.5}}, color = {0, 0, 127}));
  connect(gain.y, iECWT4ACurrentLimitation.OmegaPu) annotation(
    Line(points = {{36, 0}, {89, 0}}, color = {0, 0, 127}));
  connect(iECWT4AQLimitation.qWTMaxPu, iECWT4AQControl.qWTMaxPu) annotation(
    Line(points = {{-28, -117}, {-22, -117}, {-22, -111}, {2, -111}, {2, -110}}, color = {0, 0, 127}));
  connect(iECWT4AQLimitation.qWTMinPu, iECWT4AQControl.qWTMinPu) annotation(
    Line(points = {{-28, -133}, {-18, -133}, {-18, -117}, {2, -117}, {2, -116.5}}, color = {0, 0, 127}));
  connect(iECWT4AMeasures.uWTCfiltPu, iECWT4AQLimitation.uWTCfiltPu) annotation(
    Line(points = {{-62, 25}, {-50, 25}, {-50, -56}, {-83, -56}, {-83, -113}, {-72, -113}, {-72, -113}}, color = {0, 0, 127}));
  connect(iECWT4AMeasures.pWTCfiltPu, iECWT4AQLimitation.pWTCfiltPu) annotation(
    Line(points = {{-62, -25}, {-55, -25}, {-55, -54}, {-91, -54}, {-91, -125}, {-72, -125}, {-72, -125}}, color = {0, 0, 127}));
  connect(iECWT4AQControl.Ffrt, iECWT4AQLimitation.Ffrt) annotation(
    Line(points = {{46, -95}, {55, -95}, {55, -148}, {-87, -148}, {-87, -137}, {-72, -137}}, color = {255, 127, 0}));
  connect(PRefPu, iECWT4APControl.pWTRefPu) annotation(
    Line(points = {{-161, 114}, {77, 114}, {77, 115}, {78, 115}}, color = {0, 0, 127}));
  connect(QRefPu, iECWT4AQControl.xWTRefPu) annotation(
    Line(points = {{-160, -113}, {-105, -113}, {-105, -103}, {2, -103}, {2, -103}}, color = {0, 0, 127}));
  connect(iECWT4AMeasures.theta, theta) annotation(
    Line(points = {{-62, -9}, {2, -9}, {2, -60}, {161, -60}, {161, -60}}, color = {0, 0, 127}));
  connect(const.y, iECWT4AMeasures.fsysPu) annotation(
    Line(points = {{-149, -50}, {-128, -50}}, color = {0, 0, 127}));
  connect(iWtRePu, iECWT4AMeasures.iWtRePu) annotation(
    Line(points = {{-160, 50}, {-129, 50}, {-129, 50}, {-128, 50}}, color = {0, 0, 127}));
  connect(iWtImPu, iECWT4AMeasures.iWtImPu) annotation(
    Line(points = {{-160, 25}, {-129, 25}, {-129, 25}, {-128, 25}}, color = {0, 0, 127}));
  connect(uWtRePu, iECWT4AMeasures.uWtRePu) annotation(
    Line(points = {{-160, 0}, {-127, 0}, {-127, 0}, {-128, 0}}, color = {0, 0, 127}));
  connect(uWtImPu, iECWT4AMeasures.uWtImPu) annotation(
    Line(points = {{-160, -25}, {-126, -25}, {-126, -25}, {-128, -25}}, color = {0, 0, 127}));
  connect(iECWT4APControl.ipCmdPu, iECWT4ACurrentLimitation.ipCmdPu) annotation(
    Line(points = {{122, 100}, {127, 100}, {127, 40}, {74, 40}, {74, 18}, {83, 18}, {83, 18}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(grid = {1, 1}, extent = {{-150, -150}, {150, 150}})),
    preferredView = "diagram",
    Icon(coordinateSystem(grid = {1, 1}, initialScale = 0.1), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {0, 30}, extent = {{-90, -30}, {90, 30}}, textString = "IEC WT4A"), Text(origin = {0, -30}, extent = {{-90, -30}, {90, 30}}, textString = "Control")}));
end IECWT4AControl;
