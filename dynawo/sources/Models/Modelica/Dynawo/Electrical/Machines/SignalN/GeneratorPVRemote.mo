within Dynawo.Electrical.Machines.SignalN;

/*
* Copyright (c) 2015-2020, RTE (http://www.rte-france.com)
* See AUTHORS.txt
* All rights reserved.
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, you can obtain one at http://mozilla.org/MPL/2.0/.
* SPDX-License-Identifier: MPL-2.0
*
* This file is part of Dynawo, an hybrid C++/Modelica open source suite of simulation tools for power systems.
*/

model GeneratorPVRemote "Model for generator PV based on SignalN for the frequency handling and a remote voltage regulation"

  extends BaseClasses.BaseGeneratorSignalN;
  extends AdditionalIcons.Machine;

  type QStatus = enumeration (Standard "Reactive power is fixed to its initial value",
                              AbsorptionMax "Reactive power is fixed to its absorption limit",
                              GenerationMax "Reactive power is fixed to its generation limit");

  parameter Types.ReactivePowerPu QMinPu  "Minimum reactive power in p.u (base SnRef)";
  parameter Types.ReactivePowerPu QMaxPu  "Maximum reactive power in p.u (base SnRef)";
  parameter Types.VoltageModule URef0 "Start value of the voltage regulation set point in kV";

  input Types.VoltageModule URegulated "Regulated voltage in kV";
  Connectors.ImPin URef (value(start = URef0)) "Voltage regulation set point in kV";

protected
  QStatus qStatus (start = QStatus.Standard) "Voltage regulation status: standard, absorptionMax or generationMax";

equation

  when QGenPu <= QMinPu and URegulated >= URef.value then
    qStatus = QStatus.AbsorptionMax;
  elsewhen QGenPu >= QMaxPu and URegulated <= URef.value then
    qStatus = QStatus.GenerationMax;
  elsewhen (QGenPu > QMinPu or URegulated < URef.value) and (QGenPu < QMaxPu or URegulated > URef.value) then
    qStatus = QStatus.Standard;
  end when;

if running.value then
  if qStatus == QStatus.GenerationMax then
    QGenPu = QMaxPu;
  elseif qStatus == QStatus.AbsorptionMax then
    QGenPu = QMinPu;
  else
    URegulated = URef.value;
  end if;
else
  terminal.i.im = 0;
end if;

annotation(preferredView = "text",
    Documentation(info = "<html><head></head><body> This generator regulates the voltage URegulatedPu unless its reactive power generation hits its limits QMinPu or QMaxPu (in this case, the generator provides QMinPu or QMaxPu and the voltage is no longer regulated).</div></body></html>"));
end GeneratorPVRemote;
