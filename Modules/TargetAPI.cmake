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




include( cotire )

set( TAPI_TARGET_NAME "" )
set( TAPI_TARGET_VS_FOLDER "" )
set( TAPI_TARGET_SRC_LIST "" )
set( TAPI_TARGET_INC_LIST "" )
set( TAPI_IS_ON_BEGIN_TARGET BOOL FALSE )

set( TAPI_TARGET_PUB_INC_LIST "" )
set( TAPI_TARGET_PRIV_INC_LIST "" )
set( TAPI_TARGET_INTF_INC_LIST "" )

set( TAPI_TARGET_PUB_LIBS_LIST "" )
set( TAPI_TARGET_PRIV_LIBS_LIST "" )
set( TAPI_TARGET_INF_LIBS_LIST "" )

set( TAPI_TARGET_DEPS_LIST "" )
set( TAPI_TARGET_DEFS_LIST "" )
set( TAPI_TARGET_USE_PCH BOOL FALSE )
set( TAPI_TARGET_PCH_INC_NAME "" )
set( TAPI_TARGET_PCH_SRC_NAME "" )
set( TAPI_TARGET_INC_WARN_LEVEL BOOL TRUE )


function( BeginTarget )
	if( TAPI_IS_ON_BEGIN_TARGET EQUAL TRUE )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
    
    set( ONE_VALUE_VAR NAME VS_FOLDER )
	cmake_parse_arguments( OUT_PREF "" "${ONE_VALUE_VAR}" "" ${ARGN} )
	if( OUT_PREF_NAME )
        set( TAPI_TARGET_NAME ${OUT_PREF_NAME} PARENT_SCOPE )
    else( )
        message( FATAL_ERROR "TAPI: target name must be settled" )
    endif( )
    #message( STATUS "vs: ${OUT_PREF_VS_FOLDER} " )
    if( OUT_PREF_VS_FOLDER )
		set( TAPI_TARGET_VS_FOLDER "${OUT_PREF_VS_FOLDER}" PARENT_SCOPE )
	else( )
        set( TAPI_TARGET_VS_FOLDER "" )
    endif( )
    
	set( IS_ON_BEGIN_TARGET TRUE PARENT_SCOPE )
endfunction( )

function( EndTarget )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	
	set( TAPI_TARGET_NAME "" PARENT_SCOPE )
	set( TAPI_TARGET_VS_FOLDER "" PARENT_SCOPE )
	set( TAPI_TARGET_SRC_LIST "" PARENT_SCOPE )
	set( TAPI_TARGET_INC_LIST "" PARENT_SCOPE )
	set( TAPI_IS_ON_BEGIN_TARGET FALSE PARENT_SCOPE )
	
    set( TAPI_TARGET_PUB_INC_LIST "" PARENT_SCOPE )
    set( TAPI_TARGET_PRIV_INC_LIST "" PARENT_SCOPE )
    set( TAPI_TARGET_INTF_INC_LIST "" PARENT_SCOPE )
	
    set( TAPI_TARGET_PUB_LIBS_LIST "" PARENT_SCOPE )
    set( TAPI_TARGET_PRIV_LIBS_LIST "" PARENT_SCOPE )
    set( TAPI_TARGET_INF_LIBS_LIST "" PARENT_SCOPE )
	
    set( TAPI_TARGET_DEPS_LIST "" PARENT_SCOPE )
	set( TAPI_TARGET_DEFS_LIST "" PARENT_SCOPE )
	set( TAPI_TARGET_USE_PCH FALSE PARENT_SCOPE )
	set( TAPI_TARGET_PCH_INC_NAME "" PARENT_SCOPE )
	set( TAPI_TARGET_PCH_SRC_NAME "" PARENT_SCOPE )
	set( TAPI_TARGET_INC_WARN_LEVEL BOOL TRUE PARENT_SCOPE )
endfunction( )

function( SetPchItems _HEADER_NAME )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "SetPchItems for target ${TAPI_TARGET_NAME} already settled" )
		return( )
	endif( )
	set( TAPI_TARGET_PCH_INC_NAME ${_HEADER_NAME} PARENT_SCOPE )
#	set( TAPI_TARGET_PCH_SRC_NAME ${_SOURCE_NAME} PARENT_SCOPE )
	set( TAPI_TARGET_USE_PCH TRUE PARENT_SCOPE )
endfunction( )

function( AddSourcesGroup  )
	#message( STATUS "Args: ${ARGN}" )
    if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
    
    set( ASG_VAR "" )
    set( OPTION_VALUE_VAR VS_FOLDER PLATFORM )
    set( MULTI_VALUE_VAR FILES )
    cmake_parse_arguments( ASG_VAR "" "${OPTION_VALUE_VAR}" "${MULTI_VALUE_VAR}" ${ARGN} )
	#message( STATUS "Folder: ${ASG_VAR_VS_FOLDER}" )
    if( ASG_VAR_PLATFORM )
        set( P_NAME "" )
        string( TOUPPER "${ASG_VAR_PLATFORM}" P_NAME )
        if( VP_PLATFORM NOTEQUAL P_NAME )
            return( )
        endif( )
    endif( )
	
	set( PARAMS_LIST ${ASG_VAR_FILES} )
    #message( STATUS "Params_List: ${PARAMS_LIST}" )
	list( LENGTH PARAMS_LIST PARAMS_COUNT ) 
	set( LST_INDEX 0 )
	set( PARAMS_ITEM "" )
	set( THIS_GROUP_HXX_LIST "" )
	set( THIS_GROUP_CXX_LIST "" )
	set( ITEM_EXT "" )
	
    while( LST_INDEX LESS PARAMS_COUNT )
		list( GET PARAMS_LIST ${LST_INDEX} PARAMS_ITEM )
		foreach( item IN LISTS PARAMS_ITEM )
			set( ITEM_EXT "" )
			string( FIND "${item}" "." EXT_INDEX REVERSE )
			if( EXT_INDEX GREATER -1 )
				math( EXPR EXT_INDEX "${EXT_INDEX}+1" )
				string( SUBSTRING "${item}" ${EXT_INDEX} -1 ITEM_EXT )
				string( TOUPPER "${ITEM_EXT}" ITEM_EXT )
			endif( )
            #message( STATUS "-------------" )
            #message( STATUS "item: ${item}" )
            #message( STATUS "item ext: ${ITEM_EXT}" )
            #message( STATUS "-------------" )
			if( ITEM_EXT STREQUAL "CXX" OR ITEM_EXT STREQUAL "CPP" OR ITEM_EXT STREQUAL "CC" OR ITEM_EXT STREQUAL "C++" OR ITEM_EXT STREQUAL "C" )
                list( APPEND THIS_GROUP_CXX_LIST "${item}" )
                #message( STATUS "Added: ${item}" )
			elseif(  ITEM_EXT STREQUAL "HXX" OR ITEM_EXT STREQUAL "HPP" OR ITEM_EXT STREQUAL "HH" OR ITEM_EXT STREQUAL "H++" OR ITEM_EXT STREQUAL "H" OR ITEM_EXT STREQUAL "INL" )
				list( APPEND THIS_GROUP_HXX_LIST "${item}" )
                #message( STATUS "Added: ${item}" )
			else( )
				message( WARNING "Unknown file type in AddSourcesGroup: ${item}" )
			endif( )
		endforeach( )
		math( EXPR LST_INDEX "${LST_INDEX}+1" )
 	endwhile( )
	
	list( LENGTH THIS_GROUP_CXX_LIST TGCXX_COUNT )
	if( TGCXX_COUNT GREATER 0 )
		set( SG_NAME "Sources" )
		if( ASG_VAR_VS_FOLDER )
			#message( STATUS "Folder: ${ASG_VAR_VS_FOLDER}" )
            string( CONCAT SG_NAME  "${SG_NAME}" "\\${ASG_VAR_VS_FOLDER}" )
		endif( )
		source_group( ${SG_NAME} FILES ${THIS_GROUP_CXX_LIST} )
		set( TAPI_TARGET_SRC_LIST "${TAPI_TARGET_SRC_LIST}" ${THIS_GROUP_CXX_LIST} PARENT_SCOPE )
	endif( )
	list( LENGTH THIS_GROUP_HXX_LIST TGHXX_COUNT )
	if( TGHXX_COUNT GREATER 0 )
		set( SG_NAME "Headers" )
		if( ASG_VAR_VS_FOLDER )
			string( CONCAT SG_NAME  "${SG_NAME}" "\\${ASG_VAR_VS_FOLDER}" )
		endif( )
		source_group( ${SG_NAME} FILES ${THIS_GROUP_HXX_LIST} )
		set( TAPI_TARGET_INC_LIST "${TAPI_TARGET_INC_LIST}" ${THIS_GROUP_HXX_LIST} PARENT_SCOPE )
	endif( )
endfunction( )


function( AddTargetIncludeDirs )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	
    #set( ATID_VAR "" )
    set( ONE_VAL_VAR TYPE )
    set( MULTI_VAL_VAR DIRS )
    
    cmake_parse_arguments( ATID_VAR "" "${ONE_VAL_VAR}" "${MULTI_VAL_VAR}" ${ARGN} )
    
    #message( STATUS "Target: ${TAPI_TARGET_NAME} atid: ${ATID_VAR_DIRS} " )
	set( INC_DIR_LIST "${ATID_VAR_DIRS}" )
	list( LENGTH INC_DIR_LIST INC_DIR_COUNT ) 
	set( LST_INDEX 0 )
	set( INC_DIR_ITEM "" )
	set( THIS_INC_DIR_LIST "" )
	while( LST_INDEX LESS INC_DIR_COUNT )
		list( GET INC_DIR_LIST ${LST_INDEX} INC_DIR_ITEM )
		foreach( item IN LISTS INC_DIR_ITEM )
			list( APPEND THIS_INC_DIR_LIST "${item}" )
		endforeach( )
		math( EXPR LST_INDEX "${LST_INDEX}+1" )
 	endwhile( )
	
    #message( STATUS "atid: ${ATID_VAR_TYPE}" )
    if( ATID_VAR_TYPE )
        set( TYPE_FOUND BOOL FALSE )
        set( DIRS_TYPE "${ATID_VAR_TYPE}" )
        string( TOUPPER "${DIRS_TYPE}" DIRS_TYPE )
        
        #message( STATUS "this inc: ${THIS_INC_DIR_LIST}" )
        if( DIRS_TYPE STREQUAL "PRIVATE" )
            set( TAPI_TARGET_PRIV_INC_LIST "${TAPI_TARGET_PRIV_INC_LIST}" ${THIS_INC_DIR_LIST} PARENT_SCOPE )
            set( TYPE_FOUND TRUE )
            #message( STATUS "Target: ${TAPI_TARGET_NAME} priv inc: ${TAPI_TARGET_PRIV_INC_LIST}" )
        endif( )
        
        if( DIRS_TYPE STREQUAL "PUBLIC" )
            set( TAPI_TARGET_PUB_INC_LIST "${TAPI_TARGET_PUB_INC_LIST}" ${THIS_INC_DIR_LIST} PARENT_SCOPE )
            set( TYPE_FOUND TRUE )
            #message( STATUS "Target: ${TAPI_TARGET_NAME} pub inc: ${TAPI_TARGET_PUB_INC_LIST}" )
        endif( )
        
        if( DIRS_TYPE STREQUAL "INTERFACE" )
            set( TAPI_TARGET_INTF_INC_LIST "${TAPI_TARGET_INTF_INC_LIST}" ${THIS_INC_DIR_LIST} PARENT_SCOPE )
            set( TYPE_FOUND TRUE )
            #message( STATUS "Target: ${TAPI_TARGET_NAME} intf inc: ${TAPI_TARGET_INTF_INC_LIST}" )
        endif( )
        
        if( TYPE_FOUND EQUAL FALSE )
            message( FATAL_ERROR "TargetApi: Invalid type of include dirs (must be PUBLIC,PRIVATE,INTERFACE)" )
        endif( )
    else( )
        message( FATAL_ERROR "TargetApi: Type of include dirs list must be settled" )
    endif( )
endfunction( )

function( AddTargetLibs )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
    
    set( ATL_VAR "" )
    set( ONE_VAL_VAR TYPE )
    set( MULTI_VAL_VAR LIBS )
    
    cmake_parse_arguments( ATL_VAR "" "${ONE_VAL_VAR}" "${MULTI_VAL_VAR}"  ${ARGN} )
	
	set( LIBS_LIST "${ATL_VAR_LIBS}" )
	list( LENGTH LIBS_LIST LIBS_COUNT ) 
	set( LST_INDEX 0 )
	set( LIBS_ITEM "" )
	set( THIS_LIBS_LIST "" )
	
    while( LST_INDEX LESS LIBS_COUNT )
		list( GET LIBS_LIST ${LST_INDEX} LIBS_ITEM )
		foreach( item IN LISTS LIBS_ITEM )
			list( APPEND THIS_LIBS_LIST "${item}" )
		endforeach( )
		math( EXPR LST_INDEX "${LST_INDEX}+1" )
 	endwhile( )
    
    if( ATL_VAR_TYPE )
        set( TYPE_FOUND BOOL FALSE )
        set( LIBS_TYPE "${ATL_VAR_TYPE}" )
        string( TOUPPER "${LIBS_TYPE}" LIBS_TYPE )
        
        if( LIBS_TYPE STREQUAL "PRIVATE" )
            set( TAPI_TARGET_PRIV_LIBS_LIST "${TAPI_TARGET_PRIV_LIBS_LIST}" ${THIS_LIBS_LIST} PARENT_SCOPE )
            set( TYPE_FOUND TRUE )
        endif( )
        
        if( LIBS_TYPE STREQUAL "PUBLIC" )
            set( TAPI_TARGET_PUB_LIBS_LIST "${TAPI_TARGET_PUB_LIBS_LIST}" ${THIS_LIBS_LIST} PARENT_SCOPE )
            set( TYPE_FOUND TRUE )
        endif( )
        
        if( LIBS_TYPE STREQUAL "INTERFACE" )
            set( TAPI_TARGET_INTF_LIBS_LIST "${TAPI_TARGET_INTF_LIBS_LIST}" ${THIS_LIBS_LIST} PARENT_SCOPE )
            set( TYPE_FOUND TRUE )
        endif( )
        
        if( TYPE_FOUND EQUAL FALSE )
            message( FATAL_ERROR "TargetApi: Invalid type of lib list (must be PUBLIC,PRIVATE,INTERFACE)" )
        endif( )
    else( )
        message( FATAL_ERROR "TargetApi: Type of libs list must be settled" )
    endif( )
endfunction( )

function( AddTargetDeps )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	
	set( DEPS_LIST ${ARGV} )
	list( LENGTH DEPS_LIST DEPS_COUNT ) 
	set( LST_INDEX 0 )
	set( DEPS_ITEM "" )
	set( THIS_DEPS_LIST "" )
	while( LST_INDEX LESS DEPS_COUNT )
		list( GET DEPS_LIST ${LST_INDEX} DEPS_ITEM )
		foreach( item IN LISTS DEPS_ITEM )
			list( APPEND THIS_DEPS_LIST "${item}" )
		endforeach( )
		math( EXPR LST_INDEX "${LST_INDEX}+1" )
 	endwhile( )
	set( TAPI_TARGET_DEPS_LIST "${TAPI_TARGET_DEPS_LIST}" ${THIS_DEPS_LIST} PARENT_SCOPE )
endfunction( )

function( AddTargetDefinitions )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	set( DEFS_LIST ${ARGV} )
	list( LENGTH DEFS_LIST DEFS_COUNT ) 
	set( LST_INDEX 0 )
	set( DEFS_ITEM "" )
	set( THIS_DEFS_LIST "" )
	#message( STATUS "${DEFS_COUNT}" )
	while( LST_INDEX LESS DEFS_COUNT )
		list( GET DEFS_LIST ${LST_INDEX} DEFS_ITEM )
		foreach( item IN LISTS DEFS_ITEM )
			#message( STATUS "${item}" )
			list( APPEND THIS_DEFS_LIST "${item}" )
		endforeach( )
		math( EXPR LST_INDEX "${LST_INDEX}+1" )
 	endwhile( )
	set( TAPI_TARGET_DEFS_LIST "${TAPI_TARGET_DEFS_LIST}" ${THIS_DEFS_LIST} PARENT_SCOPE )
endfunction( )

function( ApplyTargetSettings )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	
	list(  LENGTH TAPI_TARGET_PUB_INC_LIST INC_PUB_COUNT )
    list(  LENGTH TAPI_TARGET_PRIV_INC_LIST INC_PRIV_COUNT )
    list(  LENGTH TAPI_TARGET_INTF_INC_LIST INC_INTF_COUNT )
    
    list(  LENGTH TAPI_TARGET_PUB_LIBS_LIST LIBS_PUB_COUNT )
    list(  LENGTH TAPI_TARGET_PRIV_LIBS_LIST LIBS_PRIV_COUNT )
    list(  LENGTH TAPI_TARGET_INTF_LIBS_LIST LIBS_INTF_COUNT )
    
	list( LENGTH TAPI_TARGET_DEPS_LIST DEPS_COUNT )
	list( LENGTH TAPI_TARGET_DEFS_LIST DEFS_COUNT )
	
	if( INC_PUB_COUNT GREATER 0 )
		target_include_directories( ${TAPI_TARGET_NAME} PUBLIC ${TAPI_TARGET_PUB_INC_LIST} )
        #message( STATUS "Target: ${TAPI_TARGET_NAME} pub inc: ${TAPI_TARGET_PUB_INC_LIST}" )
	endif( )
    
	if( INC_PRIV_COUNT GREATER 0 )
		target_include_directories( ${TAPI_TARGET_NAME} PRIVATE ${TAPI_TARGET_PRIV_INC_LIST} )
        #message( STATUS "Target: ${TAPI_TARGET_NAME} priv inc: ${TAPI_TARGET_PRIV_INC_LIST}" )
	endif( )
    
    if( INC_INTF_COUNT GREATER 0 )
		target_include_directories( ${TAPI_TARGET_NAME} INTERFACE ${TAPI_TARGET_INTF_INC_LIST} )
        #message( STATUS "Target: ${TAPI_TARGET_NAME} intf inc: ${TAPI_TARGET_INTF_INC_LIST}" )
	endif( )
    
    if( LIBS_PUB_COUNT GREATER 0 )
		target_link_libraries( ${TAPI_TARGET_NAME} PUBLIC ${TAPI_TARGET_PUB_LIBS_LIST} )
        #message( STATUS "Target: ${TAPI_TARGET_NAME} pub lib: ${TAPI_TARGET_PUB_LIBS_LIST}" )
	endif( )
    
    if( LIBS_PRIV_COUNT GREATER 0 )
		target_link_libraries( ${TAPI_TARGET_NAME} PRIVATE ${TAPI_TARGET_PRIV_LIBS_LIST} )
        #message( STATUS "Target: ${TAPI_TARGET_NAME} priv lib: ${TAPI_TARGET_PRIV_LIBS_LIST}" )
	endif( )
    
    if( LIBS_INTF_COUNT GREATER 0 )
		target_link_libraries( ${TAPI_TARGET_NAME} INTERFACE ${TAPI_TARGET_INTF_LIBS_LIST} )
        #message( STATUS "Target: ${TAPI_TARGET_NAME} intf lib: ${TAPI_TARGET_INTF_LIBS_LIST}" )
	endif( )
	
    if( DEPS_COUNT GREATER 0 )
		add_dependencies( ${TAPI_TARGET_NAME} ${TAPI_TARGET_DEPS_LIST} )
	endif( )
	if( DEFS_COUNT GREATER 0 )
		#message( STATUS "${TAPI_TARGET_DEFS_LIST}" )
		target_compile_definitions( ${TAPI_TARGET_NAME} PRIVATE "${TAPI_TARGET_DEFS_LIST}" )
	endif( )
	if( TAPI_TARGET_USE_PCH EQUAL TRUE )
		#message( STATUS "${TAPI_TARGET_NAME} Use PCH : ${TAPI_TARGET_PCH_INC_NAME}" )
		set_target_properties( ${TAPI_TARGET_NAME} PROPERTIES COTIRE_ADD_UNITY_BUILD FALSE )
		set_target_properties( ${TAPI_TARGET_NAME} PROPERTIES COTIRE_CXX_PREFIX_HEADER_INIT  "${TAPI_TARGET_PCH_INC_NAME}" )
		cotire( ${TAPI_TARGET_NAME} )
	endif( )
	if( TAPI_TARGET_VS_FOLDER )
		#message( STATUS "${TAPI_TARGET_NAME} : ${TAPI_TARGET_VS_FOLDER}" )
		set_target_properties( "${TAPI_TARGET_NAME}" PROPERTIES FOLDER "${TAPI_TARGET_VS_FOLDER}" )
	endif( )
	if( TAPI_TARGET_INC_WARN_LEVEL )
		if( CMAKE_CXX_COMPILER_ID MATCHES "Clang" )
			set_target_properties( ${TAPI_TARGET_NAME} PROPERTIES COMPILE_FLAGS "-Weverything ")
		endif()
		if( CMAKE_CXX_COMPILER_ID MATCHES "GNU" )
			set_target_properties( ${TAPI_TARGET_NAME} PROPERTIES COMPILE_FLAGS "-Wall -Wextra" )
		endif()
		if( CMAKE_CXX_COMPILER_ID MATCHES "MSVC" )
			set_target_properties( ${TAPI_TARGET_NAME} PROPERTIES COMPILE_FLAGS "/W4" )
		endif()
    endif()
    AddTargetDefinitions( "_UNICODE" )
endfunction( )

function ( PrintTargetSources )
	if( TAPI_IS_ON_BEGIN_TARGET EQUAL FALSE )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	message( STATUS "${TAPI_TARGET_NAME} : INC ${TAPI_TARGET_INC_LIST} SRC ${TAPI_TARGET_SRC_LIST} " )
endfunction( )

function ( PrintTargetIncDirs )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	message( STATUS "${TAPI_TARGET_NAME} : ${TAPI_TARGET_INCLUDE_LIST}" )
endfunction( )

function ( PrintTargetDefs )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	message( STATUS "${TAPI_TARGET_NAME} : ${TAPI_TARGET_DEFS_LIST}" )
endfunction( )

function ( PrintTargetDeps )
	message( STATUS "${TAPI_TARGET_NAME} : ${TAPI_TARGET_DEPS_LIST}" )
endfunction( )

function ( PrintTargetLibs )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	message( STATUS "${TAPI_TARGET_NAME} : ${TAPI_TARGET_LIBS_LIST}" )
endfunction( )


function( CreateLibrary )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	set( THIS_TARGET_SOURCES ${TAPI_TARGET_INC_LIST} ${TAPI_TARGET_SRC_LIST} )
	if( TAPI_BUILD_SHARED_LIBS )
		CreateSharedLibrary( )
	else( )
		CreateStaticLibrary( )
	endif( )
	ApplyTargetSettings( )
endfunction( )

function( CreateStaticLibrary )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	AddTargetDefinitions( "_STATICLIB" "_EXPORT" )
	set( THIS_TARGET_SOURCES ${TAPI_TARGET_INC_LIST} ${TAPI_TARGET_SRC_LIST} )
	add_library( ${TAPI_TARGET_NAME} STATIC ${THIS_TARGET_SOURCES} )
	ApplyTargetSettings( )
endfunction( )

function( CreateSharedLibrary )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	AddTargetDefinitions( "_SHAREDLIB" "_EXPORT" )
	set( THIS_TARGET_SOURCES ${TAPI_TARGET_INC_LIST} ${TAPI_TARGET_SRC_LIST} )
	add_library( ${TAPI_TARGET_NAME} SHARED ${THIS_TARGET_SOURCES} )
	ApplyTargetSettings( )
endfunction( )

function( CreateExecutable )
	if( NOT TAPI_IS_ON_BEGIN_TARGET )
		message( FATAL_ERROR "Invalid target creation sequeince")
		return( )
	endif( )
	set( THIS_TARGET_SOURCES ${TAPI_TARGET_INC_LIST} ${TAPI_TARGET_SRC_LIST} )
	if( WIN32 OR WIN64 )
		add_executable( ${TAPI_TARGET_NAME} WIN32 ${THIS_TARGET_SOURCES} )
	else( )
		add_executable( ${TAPI_TARGET_NAME} ${THIS_TARGET_SOURCES} )
	endif( )
	ApplyTargetSettings( )
endfunction( )