within Dynawo.Electrical.StaticVarCompensators;

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

model SVarCPVRemote "PV static var compensator model with remote voltage regulation"
  import Modelica;
  import Dynawo.Types;
  import Dynawo.Connectors;
  import Dynawo.Electrical.StaticVarCompensators.BaseControls.Mode;
  import Dynawo.Electrical.Controls.Basics.SwitchOff;

  extends AdditionalIcons.SVarC;
  extends SwitchOff.SwitchOffShunt;

  Connectors.ACPower terminal(V(re(start = u0Pu.re), im(start = u0Pu.im)), i(re(start = i0Pu.re), im(start = i0Pu.im))) "Connector used to connect the static var compensator to the grid";
  input Real URegulatedPu(start = URegulated0Pu) "Regulated voltage in p.u (base UNomRemote)";

  extends BaseControls.Parameters.Params_ModeHandling;
  parameter Types.PerUnit BMaxPu "Maximum value for the variable susceptance in p.u (base UNomLocal, SnRef)";
  parameter Types.PerUnit BMinPu "Minimum value for the variable susceptance in p.u (base UNomLocal, SnRef)";
  parameter Types.PerUnit LambdaPu "Statism of the regulation law URefPu = UPu + LambdaPu*QPu in p.u (base UNomRemote, SnRef)";
  parameter Types.PerUnit BShuntPu "Fixed susceptance of the static var compensator in p.u (for standby mode) (base UNomLocal, SnRef)";
  parameter Types.VoltageModule UNomRemote "Static var compensator remote nominal voltage in kV";

  Modelica.Blocks.Interfaces.RealInput URef(start = URef0) "Voltage reference for the regulation in kV";
  Modelica.Blocks.Interfaces.BooleanInput selectModeAuto(start = selectModeAuto0) "Whether the static var compensator is in automatic configuration";
  Modelica.Blocks.Interfaces.IntegerInput setModeManual(start = setModeManual0) "Mode selected when in manual configuration";

  Types.PerUnit BVarRawPu(start = BVar0Pu) "Raw variable susceptance of the static var compensator in p.u (base UNomLocal, SnRef)";
  Types.PerUnit BVarPu(start = BVar0Pu) "Variable susceptance of the static var compensator in p.u (base UNomLocal, SnRef)";
  Types.PerUnit BPu(start = B0Pu) "Susceptance of the static var compensator in p.u (base UNomLocal, SnRef)";
  Types.VoltageModulePu UPu(start = U0Pu) "Voltage amplitude at terminal in p.u (base UNomLocal)";
  Types.ReactivePowerPu QInjPu(start = B0Pu * U0Pu ^ 2) "Reactive power in p.u (base SnRef) (generator convention)";
  Types.ActivePowerPu PInjPu(start = 0) "Active power in p.u (base SnRef) (generator convention)";
  Types.VoltageModulePu URefPu(start = URef0 / UNomRemote) = modeHandling.URefPu "Reference voltage amplitude in p.u (base UNomRemote)";

  BaseControls.ModeHandling modeHandling(Mode0 = Mode0, UNom = UNomRemote, URefDown = URefDown, URefUp = URefUp, UThresholdDown = UThresholdDown, UThresholdUp = UThresholdUp, tThresholdDown = tThresholdDown, tThresholdUp = tThresholdUp, URef0 = URef0);

protected
  parameter Types.PerUnit B0Pu "Start value of the susceptance in p.u (base UNomLocal, SnRef)";
  parameter Types.VoltageModulePu U0Pu  "Start value of voltage amplitude at injector terminal in p.u (base UNomLocal)";
  parameter Types.VoltageModulePu URegulated0Pu  "Start value of voltage amplitude of the regulated voltage in p.u (base UNomRemote)";
  parameter Types.ComplexVoltagePu u0Pu  "Start value of complex voltage at injector terminal in p.u (base UNomLocal)";
  parameter Types.ComplexCurrentPu i0Pu  "Start value of complex current at injector terminal in p.u (base UNomLocal, SnRef) (receptor convention)";
  parameter Types.VoltageModule URef0  "Start value of voltage reference in kV";
  final parameter Types.PerUnit BVar0Pu = B0Pu - BShuntPu "Start value of variable susceptance in p.u (base UNomLocal, SnRef)";
  parameter BaseControls.Mode Mode0 "Start value for mode";
  parameter Boolean selectModeAuto0 = true "Start value of the boolean indicating whether the SVarC is initially in automatic configuration";
  final parameter Integer setModeManual0 = Integer(Mode0) "Start value of the mode when in manual configuration";

equation
  UPu = Modelica.ComplexMath.'abs'(terminal.V);

  URegulatedPu = modeHandling.UPu;
  URef = modeHandling.URef;
  selectModeAuto = modeHandling.selectModeAuto;
  setModeManual = modeHandling.setModeManual;

  URefPu = URegulatedPu + LambdaPu * (BVarRawPu + BShuntPu) * UPu ^ 2;
  BVarPu = if BVarRawPu > BMaxPu then BMaxPu elseif BVarRawPu < BMinPu then BMinPu else BVarRawPu;

  if modeHandling.mode.value == Mode.RUNNING_V then
    BPu = BVarPu + BShuntPu;
  elseif modeHandling.mode.value == Mode.STANDBY then
    BPu = BShuntPu;
  else
    BPu = 0;
  end if;

  if (running.value) then
    terminal.i = terminal.V * Complex(0, BPu);
  else
    terminal.i = Complex(0);
  end if;

  PInjPu = 0;
  QInjPu = - ComplexMath.imag(terminal.V * ComplexMath.conj(terminal.i));

  annotation(preferredView = "text");
end SVarCPVRemote;
