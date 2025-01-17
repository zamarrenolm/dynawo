within Dynawo.Electrical.HVDC.HvdcVSC;

/*
* Copyright (c) 2015-2021, RTE (http://www.rte-france.com)
* See AUTHORS.txt
* All rights reserved.
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, you can obtain one at http://mozilla.org/MPL/2.0/.
* SPDX-License-Identifier: MPL-2.0
*
* This file is part of Dynawo, an hybrid C++/Modelica open source suite of simulation tools for power systems.
*/

model HvdcVSCDanglingUdc_INIT "Initialisation model for the HVDC VSC model with terminal2 connected to a switched-off bus (Udc control on terminal 1)"
  extends AdditionalIcons.Init;

  parameter Types.ApparentPowerModule SNom "Injector nominal apparent power in MVA";
  parameter Types.PerUnit Lambda "Lambda coefficient for the QRefUPu calculation";
  parameter Types.PerUnit RdcPu "DC line resistance in p.u (base UNom, SnRef)";

  parameter Types.ActivePowerPu P10Pu  "Start value of active power at terminal 1 in p.u (base SnRef) (receptor convention)";
  parameter Types.ReactivePowerPu Q10Pu  "Start value of reactive power at terminal 1 in p.u (base SnRef) (receptor convention)";
  parameter Types.VoltageModulePu U10Pu "Start value of voltage amplitude at terminal 1 in p.u (base UNom)";
  parameter Types.Angle UPhase10  "Start value of voltage angle at terminal 1 in rad";
  parameter Real modeU1Set "Set value of the real assessing the mode of the control at terminal 1: 1 if U mode, 0 if Q mode";

protected
  Types.ComplexVoltagePu u10Pu  "Start value of complex voltage at terminal 1 in p.u (base UNom)";
  Types.ComplexApparentPowerPu s10Pu "Start value of complex apparent power at terminal 1 in p.u (base SnRef) (receptor convention)";
  flow Types.ComplexCurrentPu i10Pu  "Start value of complex current at terminal 1 in p.u (base UNom, SnRef) (receptor convention)";
  Types.PerUnit Ip10Pu "Start value of active current at terminal 1 in p.u (base SNom)";
  Types.PerUnit Iq10Pu "Start value of reactive current at terminal 1 in p.u (base SNom)";
  Types.PerUnit Udc10Pu "Start value of dc voltage at terminal 1 in p.u (base UdcNom)";
  Types.PerUnit Udc20Pu "Start value of dc voltage at terminal 2 in p.u (base UdcNom)";
  Types.VoltageModulePu URef10Pu "Start value of the voltage reference for the side 1 of the HVDC link in p.u (base UNom)";
  Types.ReactivePowerPu QRef10Pu "Start value of reactive power reference at terminal 1 in p.u (base SNom) (generator convention)";
  Real modeU10 "Start value of the real assessing the mode of the control at terminal 1: 1 if U mode, 0 if Q mode";

equation
  u10Pu = ComplexMath.fromPolar(U10Pu, UPhase10);
  s10Pu = Complex(P10Pu, Q10Pu);
  s10Pu = u10Pu * ComplexMath.conj(i10Pu);
  P10Pu = - U10Pu * Ip10Pu * (SNom/SystemBase.SnRef);
  Q10Pu = U10Pu * Iq10Pu * (SNom/SystemBase.SnRef);
  Udc10Pu = 1;
  Udc20Pu = 1 - RdcPu * P10Pu;
  QRef10Pu = - Q10Pu * (SystemBase.SnRef/SNom);
  URef10Pu = U10Pu - Lambda * Q10Pu * (SystemBase.SnRef/SNom);
  modeU10 = modeU1Set;

annotation(preferredView = "text");
end HvdcVSCDanglingUdc_INIT;
