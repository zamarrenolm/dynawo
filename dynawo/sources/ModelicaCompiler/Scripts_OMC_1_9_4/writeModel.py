#!/usr/bin/env python

# -*- coding: utf-8 -*-

# Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain
# simulation tool for power systems.

from optparse import OptionParser
from readerOMC import ReaderOMC
from factory import Factory
from modelWriter import ModelWriter, ModelWriterManager
from utils import *

import os

# -m, --model: model name
# -i --inputDir: directory to find files generated by omc
# -o --outDir: directory to output the .c file
options = {}

options[('-m', '--model')] = {'dest': 'modName',
                               'help': 'Designate the model name'}

options[('-i', '--inputDir')] = {'dest': 'inputDir',
                                 'help': 'Describe the path to find the files generated by omc'}

options[('-o', '--outputDir')] = {'dest': 'outputDir',
                                  'help': 'Describe the path where to build the model file'}


options[('-b','--init')] = { 'action':"store_true",
                            'dest': 'init_pb',
                            'help': 'To indicate an init problem for the model',
                            'default': False}

options[('-p','--package-name')] = { 'dest': 'packageName',
                                    'help': 'To indicate a package name.',
                                    'default': ''}

options[('-a','--additionalHeaderList')] = { 'dest': 'additionalHeaderFilesStr',
                            'help': 'list of headers that should be included in the dynamic model files'}
##
# Main program
if __name__ == '__main__':
    """
    Main program
    """
    input_dir = ""
    output_dir = "."
    mod_name = ""
    package_name = ""

    opt_parser = OptionParser()
    for param, option in options.items():
        opt_parser.add_option(*param, **option)
    options, args = opt_parser.parse_args()

    # Options "input_dir" and "mod_name" are mandatory
    if not options.inputDir:
        opt_parser.error('Input directory not given')
    if not options.modName:
        opt_parser.error('Model name not given')

    input_dir = options.inputDir
    if options.outputDir is not None: output_dir = options.outputDir
    mod_name = options.modName
    mod_name_init =  mod_name + "_INIT"
    init_pb = options.init_pb
    additional_header_files = []
    if options.additionalHeaderFilesStr is not None: additional_header_files = options.additionalHeaderFilesStr.split(" ")
    if options.packageName: package_name = options.packageName

    ###########################################
    # Readers (init pb and dynamic pb)
    ###########################################

    # Reader for the init pb
    reader_init = None

    if init_pb:
        reader_init = ReaderOMC(mod_name_init, input_dir, is_init_pb = True)

        #reader_init.readInfoXml()   # Read *_info.xml
        reader_init.read_info_json()              # Read *_info.json
        reader_init.read_init_xml()   # Read *_init.xml
        reader_init.read_model_header()   # Read *_model.h
        reader_init.read_main_c()     # Read *.c principal
        reader_init.read_03lsy_c_file()   # Read *_03lsy.c
        reader_init.read_02nls_c_file()   # Read *_02nls.c
        reader_init.read_06inz_c_file()    # Read *_06inz.c
        reader_init.read_08bnd_c_file()    # Read *_08bnd.c
        reader_init.read_05evt_c_file()    # Read *_05evt.c
        reader_init.read_functions_header()      # Read *_functions.h
        reader_init.read_functions_c_file()       # Read *_functions.c
        reader_init.read_literals_h_file()        # Read *_literals.h

    # Reader for dynamic pb
    reader = ReaderOMC(mod_name, input_dir, is_init_pb = False)

    #reader.readInfoXml()         # Read *_info.xml
    reader.read_info_json()              # Read *_info.json
    reader.read_init_xml()         # Read *_init.xml
    reader.read_model_header()         # Read *_model.h
    reader.read_main_c()           # Read *.c principal
    reader.read_03lsy_c_file()         # Read *_03lsy.c
    reader.read_02nls_c_file()         # Read *_02nls.c
    reader.read_06inz_c_file()           # Read *_06inz.c
    reader.read_08bnd_c_file()           # Read *_08bnd.c
    reader.read_05evt_c_file()           # Read *_05evt.c
    reader.read_eq_fictive_xml() # Read the fictitious equation file
    reader.read_struct_xml_file()        # Read *_structure.xml (contains structure elements)
    reader.read_functions_header()      # Read *_functions.h
    reader.read_functions_c_file()       # Read *_functions.c
    reader.read_literals_h_file()        # Read *_literals.h


    #################################
    # Builders
    #################################

    # Builder for the init pb
    builder_init_pb = None
    if init_pb:
        builder_init_pb = Factory(reader_init)

        builder_init_pb.build_variables()
        builder_init_pb.build_equations()
        builder_init_pb.build_warnings()
        builder_init_pb.build_call_functions()
        builder_init_pb.prepare_for_print()

    # Builder for the dynamic pb
    builder = Factory(reader)

    builder.build_variables()

    # In order to build C++ methods getTypeVariable(...) and defineElements(...)
    builder.build_elements()

    builder.build_equations()
    builder.build_warnings()
    builder.build_call_functions()
    builder.prepare_for_print()



    #################################
    # Writers
    #################################

    # -------------------------------------------------------
    # Generation of the file related to the initialization model
    # -------------------------------------------------------

    writer_init_pb = None # The file writer binds to the initialization template

    if init_pb:
        writer_init_pb = ModelWriter(builder_init_pb, mod_name, output_dir, package_name, init_pb)

        writer_init_pb.getHead()
        writer_init_pb.fill_initData()
        writer_init_pb.fill_setupDataStruc()
        writer_init_pb.fill_initializeDataStruc()
        writer_init_pb.fill_deInitializeDataStruc()
        writer_init_pb.fill_initRpar()
        writer_init_pb.fill_setFomc()
        writer_init_pb.fill_evalMode()
        writer_init_pb.fill_setGomc()
        writer_init_pb.fill_setZomc()
        writer_init_pb.fill_setY0omc()
        writer_init_pb.fill_setSharedParamsDefault()
        writer_init_pb.fill_setParameters()
        writer_init_pb.fill_defineElements()
        writer_init_pb.fill_setVariables()
        writer_init_pb.fill_defineParameters()
        writer_init_pb.fill_evalFAdept()
        writer_init_pb.fill_warnings()
        writer_init_pb.fill_setFequations()
        writer_init_pb.fill_setGequations()
        writer_init_pb.fill_setYType_omc()
        writer_init_pb.fill_setFType_omc()
        writer_init_pb.fill_tail()

        writer_init_pb.write_file()

        writer_init_pb.getHeadExternalCalls()
        writer_init_pb.fill_externalCalls()
        writer_init_pb.fill_tailExternalCalls()
        writer_init_pb.writeExternalCallsFile()

        # h file corresponding to INIT_CPP
        writer_init_pb.getHeaderPattern(additional_header_files)
        writer_init_pb.insert_model_name()
        writer_init_pb.insert_checkSum(os.path.abspath(output_dir))
        writer_init_pb.addExternalCalls()
        writer_init_pb.addParameters()
        writer_init_pb.write_header_file()

        writer_init_pb.fill_externalLiteralConstants()
        writer_init_pb.writeHeaderLiteralsFile()

        writer_init_pb.fill_variables_definitions()
        writer_init_pb.writeHeaderDefinitionsFile()

    # -------------------------------------------------------
    # Generation of files related to the dynamic model
    # -------------------------------------------------------

    writer = ModelWriter(builder, mod_name, output_dir, package_name)

    # Fichier C
    writer.getHead()
    writer.fill_initData()
    writer.fill_setupDataStruc()
    writer.fill_initializeDataStruc()
    writer.fill_deInitializeDataStruc()
    writer.fill_initRpar()
    writer.fill_setFomc()
    writer.fill_evalMode()
    writer.fill_setZomc()
    writer.fill_setGomc()
    writer.fill_setY0omc()
    writer.fill_setYType_omc()
    writer.fill_setFType_omc()
    writer.fill_setSharedParamsDefault()
    writer.fill_setParameters()
    writer.fill_setVariables()
    writer.fill_defineParameters()
    writer.fill_defineElements()
    writer.fill_evalFAdept()
    writer.fill_warnings()
    writer.fill_setFequations()
    writer.fill_setGequations()
    writer.fill_tail()

    writer.write_file()

    writer.getHeadExternalCalls()
    writer.fill_externalCalls()
    writer.fill_tailExternalCalls()
    writer.writeExternalCallsFile()

    # h file corresponding to the CPP
    writer.getHeaderPattern(additional_header_files)
    writer.insert_model_name()
    writer.insert_checkSum(os.path.abspath(output_dir))
    writer.addExternalCalls()
    writer.addParameters()
    writer.write_header_file()

    writer.fill_externalLiteralConstants()
    writer.writeHeaderLiteralsFile()

    writer.fill_variables_definitions()
    writer.writeHeaderDefinitionsFile()


    # -------------------------------------------------------
    # Generation of the files related to the complete model
    # -------------------------------------------------------
    writer = ModelWriterManager( mod_name, output_dir, package_name, init_pb)
    writer.set_body()
    writer.write_file()

    writer.setBodyHeader()
    writer.write_header_file()
