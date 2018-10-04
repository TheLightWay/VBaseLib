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

#ifndef _VDEFINES_HXX_INCLUDED_
#define _VDEFINES_HXX_INCLUDED_

#include "VConfig.hxx"

#define V_INVALID_INDEX (-1)

#if (VP_SHARED_LIBS == TRUE )

#if( VP_COMPILER == VP_COMPILER_MSVC )

#define V_API_EXPORT __declspec( dllexport )
#define V_API_IMPORT __declspec( dllimport )

#elif( VP_COMPILER == VP_COMPILER_CLANG )

#define V_API_EXPORT __declspec( dllexport )
#define V_API_IMPORT __declspec( dllimport )

#elif( VP_COMPILER == VP_COMPILER_GCC )

#define V_API_EXPORT __attribute__ ((visibility ("default")))
#define V_API_IMPORT 

#else

#error "Unknow C++ compiler. Invalid CMake script?"

#endif //VP_COMPILER == VP_COMPILER_CL


#else //(VP_SHARED_LIBS == FALSE )

#define V_API_EXPORT
#define V_API_IMPORT

#endif //(VP_SHARED_LIBS == TRUE )

#define V_THREADLOCAL thread_local

#if defined(_SHAREDLIB)

#if defined(_EXPORT)
#define V_API V_API_EXPORT
#else
#define V_API V_API_IMPORT
#endif //_EXPORT

#elif defined(_STATICLIB)

#define V_API 

#else

#error "In't not an library project"

#endif //defined(_SHAREDLIB)

#if VP_COMPILER == VP_COMPILER_MSVC
#   define VINLINE          inline
#   define VFORCE_INLINE    __forceinline
#elif VP_COMPILER == VP_COMPILER_GCC
#   define VINLINE          inline
#   define VFORCE_INLINE    inline  __attribute__((always_inline))
#elif VP_COMPILER == VP_COMPILER_CLANG
#   define VINLINE          inline
#   define VFORCE_INLINE    inline  __attribute__((always_inline))
#else
#   define VINLINE          inline
#   define VFORCE_INLINE    inline // no force inline for other platforms possible
#endif

// Windows Settings
#if VP_PLATFORM == VP_PLATFORM_WINDOWS
// Win32 compilers use _DEBUG for specifying debug builds.
// for MinGW, we set DEBUG
#   if defined(_DEBUG) || defined(DEBUG)
#       define VP_DEBUG_MODE 1
#   else
#       define VP_DEBUG_MODE 0
#   endif

#endif

// Linux/Mac Settings
#if VP_PLATFORM == VP_PLATFORM_LINUX || VP_PLATFORM == VP_PLATFORM_MACOS
#   ifdef DEBUG
#       define VP_DEBUG_MODE 1
#   else
#       define VP_DEBUG_MODE 0
#   endif
#endif




#define V_UNUSED( x ) (void)x

#define V_DISABLE_COPY_ASSIGN_MOVE_OPS( Class ) \
    Class( const Class& other) = delete; \
    Class( Class& other ) = delete; \
    Class( Class&& other ) = delete; \
    Class& operator = ( const Class& other ) = delete; \
    Class& operator = ( Class& other ) = delete;

#define V_DEFAULT_COPY_ASSIGN_MOVE_OPS( Class ) \
    Class( const Class& other) = default; \
    Class( Class& other ) = default; \
    Class( Class&& other ) = default; \
    Class& operator = ( const Class& other ) = default; \
    Class& operator = ( Class& other ) = default;

#define VSAFE_DELETE( p ) if( p ) { delete p; p = nullptr; }
#define VSAFE_DELETE_ARRAY( p ) if( p ) { delete[] p; p = nullptr; }

// We disable some annoying warnings of VC++
#if defined(_MSC_VER)
#pragma warning(disable: 4275) // non dll-interface class 'X' used as GetBaseClass for dll-interface class 'Y'
#pragma warning(disable: 4251) // class 'X' needs to have dll-interface to be used by clients of class 'Y'
#endif

#endif //_VDEFINES_HXX_INCLUDED_

