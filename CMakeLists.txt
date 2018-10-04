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


add_subdirectory( 3rdparty )



set( VBASE_INC_DIR "${CMAKE_CURRENT_LIST_DIR}/include" )
set( VBASE_SRC_DIR "${CMAKE_CURRENT_LIST_DIR}/src" )


include (TestBigEndian)
set( VBASE_IS_BIG_ENDIAN FALSE )
TEST_BIG_ENDIAN(VCORE_IS_BIG_ENDIAN)

set( VB_PUB_INC_LIST_DIRS "${CMAKE_CURRENT_BINARY_DIR}/include" )
list( APPEND VB_PUB_INC_LIST_DIRS "${VBASE_INC_DIR}" )

set( VBASE_PUBLIC_INCLUDE_DIRS "${VB_PUB_INC_LIST_DIRS}" )

set( VBASE_PRIVATE_INCLUDE_DIRS "${CMAKE_CURRENT_LIST_DIR}/src" )

configure_file( ${CMAKE_CURRENT_LIST_DIR}/include/VConfig.hxx.cmakein
	${CMAKE_CURRENT_BINARY_DIR}/include/VConfig.hxx )

BeginTarget( NAME "VBase" )

AddSourcesGroup( FILES ${CMAKE_CURRENT_BINARY_DIR}/include/VConfig.hxx  )

AddSourcesGroup( VS_FOLDER "Global"	FILES
                ${VBASE_INC_DIR}/VDefines.hxx 
                ${VBASE_INC_DIR}/VVersion.hxx
                ${VBASE_SRC_DIR}/VVersion.cxx
                ${VBASE_INC_DIR}/VTypeDefs.hxx
				)
      
AddTargetIncludeDirs( TYPE PUBLIC DIRS ${VBASE_PUBLIC_INCLUDE_DIRS} )
AddTargetIncludeDirs( TYPE PRIVATE DIRS ${VBASE_PRIVATE_INCLUDE_DIRS} )

AddTargetLibs( TYPE PRIVATE LIBS "MiniZ" )

CreateLibrary()

EndTarget( )