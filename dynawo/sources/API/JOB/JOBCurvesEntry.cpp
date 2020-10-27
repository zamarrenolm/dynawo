//
// Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
// See AUTHORS.txt
// All rights reserved.
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at http://mozilla.org/MPL/2.0/.
// SPDX-License-Identifier: MPL-2.0
//
// This file is part of Dynawo, an hybrid C++/Modelica open source time domain
// simulation tool for power systems.
//

/**
 * @file JOBCurvesEntry.cpp
 * @brief curves entry description : implementation file
 *
 */

#include "JOBCurvesEntry.h"

namespace job {

const std::string&
CurvesEntry::getInputFile() const {
  return inputFile_;
}

const std::string&
CurvesEntry::getOutputFile() const {
  return outputFile_;
}

const std::string&
CurvesEntry::getExportMode() const {
  return exportMode_;
}

void
CurvesEntry::setInputFile(const std::string & inputFile) {
  inputFile_ = inputFile;
}

void
CurvesEntry::setOutputFile(const std::string & outputFile) {
  outputFile_ = outputFile;
}

void
CurvesEntry::setExportMode(const std::string & exportMode) {
  exportMode_ = exportMode;
}

}  // namespace job