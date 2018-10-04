/*
Copyright (C) 2014-2017 Nickolai  Vostrikov (nickolayvostrikov@gmail.com)

Licensed to the Apache Software Foundation( ASF ) under one
or more contributor license agreements.See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.The ASF licenses this file
to you under the Apache License, Version 2.0 ( the
"License" ); you may not use this file except in compliance
with the License.You may obtain a copy of the License at

http ://www.apache.org/licenses/LICENSE-2.0
or read LICENSE file in root repository directory

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.See the License for the
specific language governing permissions and limitations
under the License.
*/

#ifndef _VVERSION_HXX_INCLUDED_
#define _VVERSION_HXX_INCLUDED_

#include "VDefines.hxx"
#include "VTypeDefs.hxx"



/**
 * @brief vVersionString
 *
 * Return version string as C language null 
 * terminated characters array.
 *
 * @return pointer to static null terminated char array
 */
V_API const vchar* VGetVersionString( );


/**
 * @brief Obtain version as 32 bit dword value
 *
 * Returned dword value of version in VMakeFourcc format
 *
 * @return version dword value
 */
 V_API vdword VGetVersion( );


/**
 * @brief Obtain major version number as 8 bit value
 *
 * Returned byte value major version number in version
 *
 * @return major version number value
 */
 V_API vbyte VGetVersionMajor( );

 /**
 * @brief Obtain minor version number as 8 bit value
 *
 * Returned byte value minor version number in version
 *
 * @return minor version number value
 */
 V_API vbyte VGetVersionMinor( );

 /**
 * @brief Obtain patch version number as 8 bit value
 *
 * Returned byte value patch version number in version
 *
 * @return patch version number value
 */
 V_API vbyte VGetVersionPatch( );

 /**
 * @brief Obtain devtweak version number as 8 bit value
 *
 * Returned byte value devtweak version number in version
 *
 * @return devtweak version number value
 */
 V_API vbyte VGetVersionDevTweak( );

#endif //_VVERSION_HXX_INCLUDED_
