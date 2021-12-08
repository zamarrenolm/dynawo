# -*- coding: utf-8 -*-

# Copyright (c) 2015-2020, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain
# simulation tool for power systems.

import os

test_cases = []
standardReturnCode = [0]
standardReturnCodeType = "ALLOWED"
forbiddenReturnCodeType = "FORBIDDEN"

#####################################
#     IEEE 14 - Disconnect Line     #
#####################################

case_name = "DynaFlow - IEEE14 - DisconnectLine"
case_description = "IEEE 14 test case with a line disconnection"
job_file = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__)))), "examples", "DynaFlow", "IEEE14", "IEEE14_DisconnectLine", "IEEE14.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

###########################################################
#     IEEE 14 - Disconnect Line with intermediate dump    #
###########################################################

case_name = "DynaFlow - IEEE14 - DisconnectLine intermediate"
case_description = "IEEE 14 test case with a line disconnection and intermediate dumps"
job_file = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__)))), "examples", "DynaFlow", "IEEE14", "IEEE14_DisconnectLine_intermediate_dump", "IEEE14.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

##############################################
#  Small System with an HVDC link and a CLA  #
##############################################

case_name = "DynaFlow - HVDC and CLA"
case_description = "Small System with an HVDC link and a CLA"
job_file = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__)))), "examples", "DynaFlow", "IllustrativeExamples", "HVDC_CLA", "HVDC_CLA.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

########################################################
#  Small System with an HVDC link and a Phase Shifter  #
########################################################

case_name = "DynaFlow - HVDC and PhaseShifter"
case_description = "Small System with an HVDC link and a Phase Shifter"
job_file = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__)))), "examples", "DynaFlow", "IllustrativeExamples", "HVDC_PhaseShifter", "HVDC_PhaseShifter.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

##########################################
#  Small System with a Load Restoration  #
##########################################

case_name = "DynaFlow - LoadRestoration"
case_description = "Small System with a Load Restoration"
job_file = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__)))), "examples", "DynaFlow", "IllustrativeExamples", "LoadRestoration", "LoadRestoration.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

##########################################
#  Small System with two Phase Shifters  #
##########################################

case_name = "DynaFlow - PhaseShifters"
case_description = "Small System with two Phase Shifters"
job_file = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(__file__)))), "examples", "DynaFlow", "IllustrativeExamples", "PhaseShifters", "PhaseShifters.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

#############################################
#  Small System with a Shunt with sections  #
#############################################

case_name = "DynaFlow - Shunts"
case_description = "Small System with a Shunt with Sections"
job_file = os.path.join(os.path.dirname(__file__), "Shunts", "Shunt.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

case_name = "DynaFlow - Shunts init"
case_description = "Small System with a Shunt with Sections to check SIM solver parameters"
job_file = os.path.join(os.path.dirname(__file__), "ShuntsInit", "Shunt.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

#######################################################################
#  Small System with two Shunts with sections and sections regulation  #
#######################################################################

case_name = "DynaFlow - Centralized Shunts with regulation"
case_description = "Small System with two Shunts with sections and sections regulation"
job_file = os.path.join(os.path.dirname(__file__), "CentralizedShuntsRegulation", "Shunt.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

########################################################
#  Small System with dangling HVDC links (VSC and LCC) #
########################################################

case_name = "DynaFlow - Dangling HVDC links"
case_description = "Small System with dangling HVDC links (VSC and LCC)"
job_file = os.path.join(os.path.dirname(__file__), "HvdcDangling", "HvdcDangling.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

####################################################################################
#  Small System with two HVDC links with AC Emulation and a power transfer control #
####################################################################################

case_name = "DynaFlow - HVDC links with AC Emulation and a power transfer control"
case_description = "Small System with two HVDC links with AC Emulation and a power transfer control"
job_file = os.path.join(os.path.dirname(__file__), "HvdcPowerTransfer", "HvdcPowerTransfer.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

################################################################################################
#  Small System with with a Load Restoration following a line disconnection, using a cpp model #
################################################################################################

case_name = "DynaFlow - LoadRestoration with line disconnection"
case_description = "Small System with with a Load Restoration following a line disconnection, using a cpp model"
job_file = os.path.join(os.path.dirname(__file__), "LoadRestorativeWithLimits", "LoadRestorativeWithLimits.jobs")

test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

######################################################################################################
#  Small System with two HVDC links with AC Emulation, a centralized voltage control and PQ diagrams #
######################################################################################################

if os.environ["DYNAWO_CXX11_ENABLED"] == "YES" and os.environ.get("DYNAWO_USE_LEGACY_IIDM", "NO") != "YES":
    case_name = "DynaFlow - HVDC links with AC Emulation, a centralized voltage control and PQ diagrams"
    case_description = "Small System with two HVDC links with AC Emulation, a centralized voltage control and PQ diagrams"
    job_file = os.path.join(os.path.dirname(__file__), "HvdcPQPropDiagramPQ", "HvdcPQPropDiagramPQ.jobs")

    test_cases.append((case_name, case_description, job_file, 1, standardReturnCodeType, standardReturnCode))

##################################################################
# Small System with PV Static Var Compensator and Load variation #
##################################################################

case_name = "DynaFlow - LoadVar - SVarCPV"
case_description = "SVarCPV test case with a load variation"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_LoadVar", "SVarCPV", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

#######################################################################
# Small System with PV Prop Static Var Compensator and Load variation #
#######################################################################

case_name = "DynaFlow - LoadVar - SVarCPVProp"
case_description = "SVarCPVProp test case with a load variation"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_LoadVar", "SVarCPVProp", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

##################################################################################
# Small System with PV Prop Simplified Static Var Compensator and Load variation #
##################################################################################

case_name = "DynaFlow - LoadVar - SVarCPVPropSimplified"
case_description = "SVarCPVPropSimplfied test case with a load variation"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_LoadVar", "SVarCPVPropSimplified", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

#########################################################################
# Small System with PV Remote Static Var Compensator and Load variation #
#########################################################################

case_name = "DynaFlow - LoadVar - SVarCPVRemote"
case_description = "SVarCPVRemote test case with a load variation"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_LoadVar", "SVarCPVRemote", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

##############################################################################
# Small System with PV Remote Prop Static Var Compensator and Load variation #
##############################################################################

case_name = "DynaFlow - LoadVar - SVarCPVRemoteProp"
case_description = "SVarCPVRemoteProp test case with a load variation"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_LoadVar", "SVarCPVRemoteProp", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

#########################################################################################
# Small System with PV Remote Prop Simplified Static Var Compensator and Load variation #
#########################################################################################

case_name = "DynaFlow - LoadVar - SVarCPVRemotePropSimplified"
case_description = "SVarCPVRemotePropSimplified test case with a load variation"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_LoadVar", "SVarCPVRemotePropSimplified", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

####################################################################################
# Small System with PV Remote Simplified Static Var Compensator and Load variation #
####################################################################################

case_name = "DynaFlow - LoadVar - SVarCPVRemoteSimplified"
case_description = "SVarCPVRemoteSimplified test case with a load variation"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_LoadVar", "SVarCPVRemoteSimplified", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

#############################################################################
# Small System with PV Simplified Static Var Compensator and Load variation #
#############################################################################

case_name = "DynaFlow - LoadVar - SVarCPVSimplified"
case_description = "SVarCPVSimplified test case with a load variation"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_LoadVar", "SVarCPVSimplified", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

######

###################################################################################
# Small System with PV Static Var Compensator and a step on the reference voltage #
###################################################################################

case_name = "DynaFlow - StepURef - SVarCPV"
case_description = "SVarCPV test case with a step on the reference voltage"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_StepURef", "SVarCPV", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

########################################################################################
# Small System with PV Prop Static Var Compensator and a step on the reference voltage #
########################################################################################

case_name = "DynaFlow - StepURef - SVarCPVProp"
case_description = "SVarCPVProp test case with a step on the reference voltage"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_StepURef", "SVarCPVProp", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

###################################################################################################
# Small System with PV Prop Simplified Static Var Compensator and a step on the reference voltage #
###################################################################################################

case_name = "DynaFlow - StepURef - SVarCPVPropSimplified"
case_description = "SVarCPVPropSimplfied test case with a step on the reference voltage"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_StepURef", "SVarCPVPropSimplified", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

##########################################################################################
# Small System with PV Remote Static Var Compensator and a step on the reference voltage #
##########################################################################################

case_name = "DynaFlow - StepURef - SVarCPVRemote"
case_description = "SVarCPVRemote test case with a step on the reference voltage"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_StepURef", "SVarCPVRemote", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

###############################################################################################
# Small System with PV Remote Prop Static Var Compensator and a step on the reference voltage #
###############################################################################################

case_name = "DynaFlow - StepURef - SVarCPVRemoteProp"
case_description = "SVarCPVRemoteProp test case with a step on the reference voltage"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_StepURef", "SVarCPVRemoteProp", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

######################################################################################################
# Small System with PV Remote Prop Simplified Static Var Compensator a step on the reference voltage #
######################################################################################################

case_name = "DynaFlow - StepURef - SVarCPVRemotePropSimplified"
case_description = "SVarCPVRemotePropSimplified test case with a step on the reference voltage"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_StepURef", "SVarCPVRemotePropSimplified", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

#################################################################################################
# Small System with PV Remote Simplified Static Var Compensator a step on the reference voltage #
#################################################################################################

case_name = "DynaFlow - StepURef - SVarCPVRemoteSimplified"
case_description = "SVarCPVRemoteSimplified test case with a step on the reference voltage"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_StepURef", "SVarCPVRemoteSimplified", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))

##############################################################################################
# Small System with PV Simplified Static Var Compensator and a step on the reference voltage #
##############################################################################################

case_name = "DynaFlow - StepURef - SVarCPVSimplified"
case_description = "SVarCPVSimplified test case with a step on the reference voltage"
job_file = os.path.join(os.path.dirname(__file__),  "StaticVarCompensators", "SVarC_StepURef", "SVarCPVSimplified", "SVarC.jobs")

test_cases.append((case_name, case_description, job_file, 30, standardReturnCodeType, standardReturnCode))
