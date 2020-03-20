within Dynawo.Electrical.HVDC.Standard.ActivePowerControl;

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

model RPFaultFunction "rpfault function"

  import Modelica;
  import Dynawo;
  import Dynawo.Types;
  import Dynawo.Connectors;
  import Dynawo.Electrical.SystemBase;

  parameter Types.PerUnit Slope "Slope of the recovery of rpfault after a fault in p.u/s";

  Modelica.Blocks.Interfaces.BooleanInput blocked(start = false) "Boolean assessing the state of the HVDC link: true if blocked, false if not blocked" annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  Modelica.Blocks.Interfaces.RealOutput rpfault(start = 1) "Signal that is equal to 1 in normal conditions, 0 when the HVDC link is blocked, and that goeas back to 1 with a ramp when it is unblocked" annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

protected

  Types.PerUnit rpfaultRaw(start = 1);
  Types.Time Timer(start = 0);

equation

  when blocked == true then
    rpfaultRaw = 0;
    Timer = 10;
  elsewhen blocked == false then
    rpfaultRaw = 1;
    Timer = time;
  end when;

  rpfault = if Timer == 0 then 1 else min(Slope * max(time - Timer, 0), 1);

  annotation(preferredView = "text",
    Diagram(coordinateSystem(grid = {1, 1})),
    Icon(coordinateSystem(grid = {1, 1})));

end RPFaultFunction;