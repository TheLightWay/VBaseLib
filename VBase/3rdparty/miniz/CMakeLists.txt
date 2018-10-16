#Copyright (C) 2014-2018 Nickolai  Vostrikov
#
#Licensed to the Apache Software Foundation( ASF ) under one
#or more contributor license agreements.See the NOTICE file
#distributed with this work for additional information
#regarding copyright ownership.The ASF licenses this file
#to you under the Apache License, Version 2.0 ( the
#	"License" ); you may not use this file except in compliance
#	with the License.You may obtain a copy of the License at
#
#	http ://www.apache.org/licenses/LICENSE-2.0
#	or read LICENSE file in root repository directory
#
#Unless required by applicable law or agreed to in writing,
#software distributed under the License is distributed on an
#"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#KIND, either express or implied.See the License for the
#specific language governing permissions and limitations
#under the License.

set( MINIZ_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}" CACHE PATH INTERNAL )

BeginTarget( NAME "MiniZ" VS_FOLDER "3rdParty" )

AddSourcesGroup( FILES 
				${CMAKE_CURRENT_LIST_DIR}/miniz.c
				${CMAKE_CURRENT_LIST_DIR}/miniz.h
				)
AddTargetIncludeDirs( TYPE PUBLIC DIRS ${CMAKE_CURRENT_LIST_DIR} )

CreateStaticLibrary()

EndTarget( )