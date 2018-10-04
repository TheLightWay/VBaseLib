/*
Copyright (C) 2014-2018 Nickolai  Vostrikov (nickolayvostrikov@gmail.com)

Licensed to the Apache Software Foundation( ASF ) under one
or more contributor license agreements.See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.The ASF licenses this file
to you under the Apache License, Version 2.0 ( the
"License" ); you may not use this file except in compliance
with the License.You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
or read LICENSE file in root repository directory

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.See the License for the
specific language governing permissions and limitations
under the License.
*/

#include "VConfig.hxx"
#include "VDefines.hxx"
#include "VVersion.hxx"
#include "VTypeDefs.hxx"

static const vchar* gCurrentVersion = VP_VERSION_STRING;

static constexpr vdword VMakeFourcc ( vchar const p[5] )
{
	return ( p[0] << 24 ) | ( p[1] << 16 ) | ( p[2] << 8 ) | p[3];
}

static constexpr vdword VMakeFourcc ( vchar const p0, vchar const p1, vchar const p2, vchar const p3 )
{
	return ( p0 << 24 ) | ( p1 << 16 ) | ( p2 << 8 ) | p3;
}

const vchar* VGetVersionString( )
{
	return gCurrentVersion;
}

vdword VGetVersion( )
{
	const vdword dwVersion = VMakeFourcc( VP_VERSION_MAJOR, VP_VERSION_MINOR,
		VP_VERSION_PATCH, VP_VERSION_DEVTWEAK );
	return dwVersion;
}

vbyte VGetVersionMajor( )
{
	return VP_VERSION_MAJOR;
}

vbyte VGetVersionMinor( )
{
	return VP_VERSION_MINOR;
}

vbyte VGetVersionPatch( )
{
	return VP_VERSION_PATCH;
}

vbyte VGetVersionDevTweak( )
{
	return VP_VERSION_DEVTWEAK;
}