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

model GridFollowingControl_INIT "Initialization model for the grid following control"

  import Modelica;
  import Dynawo.Types;
  import Dynawo.Connectors;
  import Dynawo.Electrical.SystemBase;

  extends AdditionalIcons.Init;

  parameter Types.PerUnit Lfilter "Filter inductance in p.u (base UNom, SNom)";
  parameter Types.PerUnit Cfilter "Filter capacitance in p.u (base UNom, SNom)";

  Types.PerUnit PRef0Pu;
  Types.PerUnit QRef0Pu;
  Types.PerUnit IdcSourceRef0Pu;
  Types.PerUnit IdConv0Pu;
  Types.PerUnit IqConv0Pu;
  Types.PerUnit IdPcc0Pu;
  Types.PerUnit IqPcc0Pu;
  Types.PerUnit UdFilter0Pu;
  Types.PerUnit UdConv0Pu;
  Types.PerUnit UqConv0Pu;
  Types.Angle Theta0;
  Types.PerUnit IdcSource0Pu;
  Types.PerUnit Udc0Pu;

  equation

  PRef0Pu = UdFilter0Pu * IdConv0Pu;
  PRef0Pu = IdcSourceRef0Pu * Udc0Pu;
  QRef0Pu =  - UdFilter0Pu * IqConv0Pu;
  Udc0Pu = UdFilter0Pu;

annotation(preferredView = "text");

end GridFollowingControl_INIT;