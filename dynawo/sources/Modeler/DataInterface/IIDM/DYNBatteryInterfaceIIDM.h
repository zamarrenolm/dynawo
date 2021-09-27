//
// Copyright (c) 2021, RTE (http://www.rte-france.com)
// See AUTHORS.txt
// All rights reserved.
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at http://mozilla.org/MPL/2.0/.
// SPDX-License-Identifier: MPL-2.0
//
// This file is part of Dynawo, an hybrid C++/Modelica open source suite of simulation tools
// for power systems.
//

//======================================================================
/**
 * @file  DataInterface/IIDM/DYNBatteryInterfaceIIDM.h
 *
 * @brief Battery data interface : header file for IIDM interface
 *
 */
//======================================================================
#ifndef MODELER_DATAINTERFACE_IIDM_DYNBATTERYINTERFACEIIDM_H_
#define MODELER_DATAINTERFACE_IIDM_DYNBATTERYINTERFACEIIDM_H_

#include <boost/shared_ptr.hpp>
#include <IIDM/extensions/activePowerControl/ActivePowerControl.h>

#include "DYNGeneratorInterface.h"
#include "DYNInjectorInterfaceIIDM.h"

namespace IIDM {
class Battery;
}

namespace DYN {

/**
 * class BatteryInterfaceIIDM
 */
class BatteryInterfaceIIDM : public GeneratorInterface, public InjectorInterfaceIIDM<IIDM::Battery> {
 public:
  /**
   * @brief defines the index of each state variable
   */
  typedef enum {
    VAR_P = 0,
    VAR_Q,
    VAR_STATE
  } indexVar_t;

 public:
  /**
   * @brief Destructor
   */
  ~BatteryInterfaceIIDM();

  /**
   * @brief Constructor
   * @param battery: battery iidm instance
   */
  explicit BatteryInterfaceIIDM(IIDM::Battery& battery);

  /**
   * @copydoc ComponentInterface::exportStateVariablesUnitComponent()
   */
  void exportStateVariablesUnitComponent();

  /**
   * @copydoc ComponentInterface::importStaticParameters()
   */
  void importStaticParameters();

  /**
   * @copydoc GeneratorInterface::setBusInterface(const boost::shared_ptr<BusInterface>& busInterface)
   */
  void setBusInterface(const boost::shared_ptr<BusInterface>& busInterface);

  /**
   * @copydoc GeneratorInterface::setVoltageLevelInterface(const boost::shared_ptr<VoltageLevelInterface>& voltageLevelInterface)
   */
  void setVoltageLevelInterface(const boost::shared_ptr<VoltageLevelInterface>& voltageLevelInterface);

  /**
   * @copydoc GeneratorInterface::getBusInterface() const
   */
  boost::shared_ptr<BusInterface> getBusInterface() const;

  /**
   * @copydoc GeneratorInterface::getInitialConnected()
   */
  bool getInitialConnected();

  /**
   * @copydoc GeneratorInterface::getP()
   */
  double getP();

  /**
   * @copydoc GeneratorInterface::getPMin()
   */
  double getPMin();

  /**
   * @copydoc GeneratorInterface::getPMax()
   */
  double getPMax();

  /**
   * @copydoc GeneratorInterface::getTargetP()
   */
  double getTargetP();

  /**
   * @copydoc GeneratorInterface::getQ()
   */
  double getQ();

  /**
   * @copydoc GeneratorInterface::getQMax()
   */
  double getQMax();

  /**
   * @copydoc GeneratorInterface::getQMin()
   */
  double getQMin();

  /**
   * @copydoc GeneratorInterface::getTargetQ()
   */
  double getTargetQ();

  /**
   * @copydoc GeneratorInterface::getTargetV()
   */
  double getTargetV();

  /**
   * @copydoc GeneratorInterface::getID() const
   */
  std::string getID() const;

  /**
   * @copydoc ComponentInterface::getComponentVarIndex()
   */
  int getComponentVarIndex(const std::string& varName) const;

  /**
   * @copydoc GeneratorInterface::getReactiveCurvesPoints() const
   */
  std::vector<ReactiveCurvePoint> getReactiveCurvesPoints() const;

  /**
   * @brief Determines if voltage regulation is on
   * @returns whether voltage regulation is on
   */
  bool isVoltageRegulationOn() const;

  /**
   * @brief Determines if generator has active power control information
   * @returns whether generator has active power control information
   */
  bool hasActivePowerControl() const;

  /**
   * @brief Determines if generator is participating in active power control
   * @returns whether generator is participating to active power control
   */
  bool isParticipating() const;

  /**
   * @brief Getter for the active power control droop
   * @returns active power control droop value
   */
  double getActivePowerControlDroop() const;

  /**
   * @brief Determines if generator has coordinated reactive power control information
   * @returns whether generator has coordinated reactive power power control information
   */
  bool hasCoordinatedReactiveControl() const;

  /**
   * @brief Getter for the reactive power control percentage of participation
   * @returns reactive power control percentage of participation value
   */
  double getCoordinatedReactiveControlPercentage() const;

 private:
  IIDM::Battery& batteryIIDM_;  ///< reference to the iidm generator instance
  IIDM::extensions::activepowercontrol::ActivePowerControl * activePowerControl_;  ///< pointer to ActivePowerControl extension
};
}  // namespace DYN

#endif  // MODELER_DATAINTERFACE_IIDM_DYNBATTERYINTERFACEIIDM_H_
