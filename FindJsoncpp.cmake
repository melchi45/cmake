# This module is a jsoncpp wrapper written in modern C++.
# It provides an easy, intuitive, and efficient interface to
# a host of networking methods.
#
# Finding this module will define the following variables:
#  JSONCPP_FOUND - True if the core library has been found
#  JSONCPP_LIBRARIES - Path to the core library archive
#  JSONCPP_INCLUDE_DIRS - Path to the include directories. Gives access
#                     to json.h, which must be included in every
#                     file that uses this interface
include(FindPackageHandleStandardArgs)

if (WIN32)
	# Find include files
	find_path(
		JSONCPP_INCLUDE_DIR
		NAMES json/json.h
		PATHS
		$ENV{PROGRAMFILES}/include
		${JSONCPP_ROOT_DIR}/include
		DOC "The directory where json/json.h resides")

	# Use jsoncpp.lib for static library
	set(JSONCPP_LIBRARY_NAME jsoncpp)

	# Find library files
	find_library(
		JSONCPP_LIBRARY
		NAMES ${JSONCPP_LIBRARY_NAME}
		PATHS
		$ENV{PROGRAMFILES}/lib
		${JSONCPP_ROOT_DIR}/lib)

	unset(JSONCPP_LIBRARY_NAME)
else()
	# Find include files
	find_path(
		JSONCPP_INCLUDE_DIR
		NAMES json/json.h
		PATHS
		/usr/include/jsoncpp
		/usr/local/include/jsoncpp
		/sw/include/jsoncpp
		/opt/local/include/jsoncpp
		DOC "The directory where json/json.h resides")

	# Find library files
	# Try to use static libraries
	find_library(
		JSONCPP_LIBRARY
		NAMES jsoncpp
		PATHS
		/usr/lib64
		/usr/lib
		/usr/local/lib64
		/usr/local/lib
		/sw/lib
		/opt/local/lib
		${GLFW_ROOT_DIR}/lib
		DOC "The GLFW library")
endif()

# Handle REQUIRD argument, define *_FOUND variable
find_package_handle_standard_args(JSONCPP REQUIRED_VARS JSONCPP_LIBRARY JSONCPP_INCLUDE_DIR)

if(JSONCPP_FOUND)
    set(JSONCPP_LIBRARIES ${JSONCPP_LIBRARY})
    set(JSONCPP_INCLUDE_DIRS ${JSONCPP_INCLUDE_DIR})
endif()

# Hide some variables
mark_as_advanced(JSONCPP_INCLUDE_DIR JSONCPP_LIBRARY)