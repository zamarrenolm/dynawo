# Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.

# Preassembled models

set(MODELICA_PREASSEMBLED_MODELS
  Bus.xml
  CurrentLimitAutomaton.xml
  EventConnectedStatus.xml
  EventQuadripoleConnection.xml
  EventQuadripoleDisconnection.xml
  EventSetPointBoolean.xml
  EventSetPointReal.xml
  EventSetPointDoubleReal.xml
  GeneratorFictitious.xml
  GeneratorPQ.xml
  GeneratorPQPropSignalN.xml
  GeneratorPQPropDiagramPQSignalN.xml
  GeneratorPV.xml
  GeneratorPVSignalN.xml
  GeneratorPVDiagramPQSignalN.xml
  GeneratorPVPropSignalN.xml
  GeneratorPVRemoteSignalN.xml
  GeneratorPVRemoteDiagramPQSignalN.xml
  GeneratorSynchronousFourWindings.xml
  GeneratorSynchronousThreeWindings.xml
  GeneratorSynchronousFourWindingsProportionalRegulations.xml
  GeneratorSynchronousThreeWindingsProportionalRegulations.xml
  GeneratorSynchronousFourWindingsGoverPropVRPropInt.xml
  GeneratorSynchronousThreeWindingsGoverPropVRPropInt.xml
  GenericAutomaton.xml
  GridFormingConverterDroopControl.xml
  GridFormingConverterMatchingControl.xml
  GridFormingConverterDispatchableVirtualOscillatorControl.xml
  HvdcPQProp.xml
  HvdcPQPropEmulation.xml
  HvdcPQPropEmulationVariableK.xml
  HvdcPQPropDiagramPQ.xml
  HvdcPQPropDiagramPQEmulation.xml
  HvdcPQPropDiagramPQEmulationVariableK.xml
  HvdcPQPropDangling.xml
  HvdcPQPropDanglingDiagramPQ.xml
  HvdcPV.xml
  HvdcPVEmulation.xml
  HvdcPVEmulationVariableK.xml
  HvdcPVDiagramPQ.xml
  HvdcPVDiagramPQEmulation.xml
  HvdcPVDiagramPQEmulationVariableK.xml
  HvdcPVDangling.xml
  HvdcPVDanglingDiagramPQ.xml
  HvdcPTanPhi.xml
  HvdcPTanPhiDiagramPQ.xml
  HvdcPTanPhiDangling.xml
  HvdcPTanPhiDanglingDiagramPQ.xml
  HvdcVSC.xml
  HvdcVSCDanglingP.xml
  HvdcVSCDanglingUdc.xml
  HvdcVSCEmulation.xml
  InfiniteBus.xml
  InfiniteBusWithVariations.xml
  InjectorBG.xml
  Line.xml
  LoadAlphaBeta.xml
  LoadAlphaBetaRestorative.xml
  LoadAlphaBetaRestorativeLimitsRecalc.xml
  LoadOneTransformer.xml
  LoadOneTransformerTapChanger.xml
  LoadPQ.xml
  LoadTwoTransformers.xml
  LoadTwoTransformersTapChangers.xml
  LoadZIP.xml
  NodeFault.xml
  PhaseShifterI.xml
  PhaseShifterP.xml
  PhotovoltaicsWeccCurrentSource.xml
  PowerTransferHVDCEmulation.xml
  ShuntBWithSections.xml
  SetPoint.xml
  SignalN.xml
  StaticVarCompensator.xml
  StaticVarCompensatorPV.xml
  StaticVarCompensatorPVRemote.xml
  Step.xml
  TapChangerAutomaton.xml
  TapChangerBlockingAutomaton1.xml
  TapChangerBlockingAutomaton2.xml
  TapChangerBlockingAutomaton3.xml
  TapChangerBlockingAutomaton4.xml
  TapChangerBlockingAutomaton5.xml
  TransformerFixedRatio.xml
  UnderVoltageAutomaton.xml
  VRRemote.xml
  )

# PYTHON scripts preassembled models
set(PYTHON_SCRIPTS_PREASSEMBLED_MODELS
  buildChecker.py
  )

install(PROGRAMS ${PYTHON_SCRIPTS_PREASSEMBLED_MODELS} DESTINATION ${SBINDIR_NAME})

foreach( FILE ${MODELICA_PREASSEMBLED_MODELS} )
  compile_preassembled_model(${FILE})
endforeach( FILE )

if(BUILD_TESTS OR BUILD_TESTS_COVERAGE)
  add_subdirectory(test)
endif()
