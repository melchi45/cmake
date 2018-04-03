# This module is a mosquitto wrapper written in modern C++.
# It provides an easy, intuitive, and efficient interface to
# a host of networking methods.
#
# Finding this module will define the following variables:
#  MOSQUITTO_FOUND - True if the core library has been found
#  MOSQUITTO_LIBRARIES - Path to the core library archive
#  MOSQUITTO_INCLUDE_DIRS - Path to the include directories. Gives access
#                     to mosquitto.h, which must be included in every
#                     file that uses this interface
include(FindPackageHandleStandardArgs)

if (WIN32)
	# Find include files
	find_path(
		MOSQUITTO_INCLUDE_DIR
		NAMES mosquitto.h
		PATHS
		$ENV{PROGRAMFILES}/include
		${MOSQUITTO_ROOT_DIR}/include
		DOC "The directory where mosquitto.h resides")

	find_path(
		MOSQUITTOPP_INCLUDE_DIR
		NAMES mosquittopp.h
		PATHS
		$ENV{PROGRAMFILES}/include
		${MOSQUITTOPP_ROOT_DIR}/include
		DOC "The directory where mosquittopp.h resides")
		
	# Use mosquitto.lib for static library
	set(MOSQUITTO_LIBRARY_NAME mosquitto)
	set(MOSQUITTOPP_LIBRARY_NAME mosquittopp)
	
	# Find library files
	find_library(
		MOSQUITTO_LIBRARY
		NAMES ${MOSQUITTO_LIBRARY_NAME}
		PATHS
		$ENV{PROGRAMFILES}/lib
		${MOSQUITTO_ROOT_DIR}/lib)

	# Find library files
	find_library(
		MOSQUITTOPP_LIBRARY
		NAMES ${MOSQUITTOPP_LIBRARY_NAME}
		PATHS
		$ENV{PROGRAMFILES}/lib
		${MOSQUITTOPP_ROOT_DIR}/lib)

	unset(MOSQUITTO_LIBRARY_NAME)
	unset(MOSQUITTOPP_LIBRARY_NAME)	
else()
	# Find include files
	find_path(
		MOSQUITTO_INCLUDE_DIR
		NAMES mosquitto.h
		PATHS
		/usr/include
		/usr/local/include
		/sw/include
		/opt/local/include
		DOC "The directory where mosquitto.h resides")

	# Find library files
	# Try to use static libraries
	find_library(
		MOSQUITTO_LIBRARY
		NAMES mosquitto
		PATHS
		/usr/lib64
		/usr/lib
		/usr/local/lib64
		/usr/local/lib
		/sw/lib
		/opt/local/lib
		${GLFW_ROOT_DIR}/lib
		DOC "The mosquitto library")
		
	# Find include files
	find_path(
		MOSQUITTOPP_INCLUDE_DIR
		NAMES mosquittopp.h
		PATHS
		/usr/include
		/usr/local/include
		/sw/include
		/opt/local/include
		DOC "The directory where mosquittopp.h resides")

	# Find library files
	# Try to use static libraries
	find_library(
		MOSQUITTOPP_LIBRARY
		NAMES mosquittopp
		PATHS
		/usr/lib64
		/usr/lib
		/usr/local/lib64
		/usr/local/lib
		/sw/lib
		/opt/local/lib
		${GLFW_ROOT_DIR}/lib
		DOC "The mosquittopp library")		
endif()

# Handle REQUIRD argument, define *_FOUND variable
find_package_handle_standard_args(MOSQUITTO REQUIRED_VARS MOSQUITTO_LIBRARY MOSQUITTOPP_LIBRARY MOSQUITTO_INCLUDE_DIR)

if(MOSQUITTO_FOUND)
    set(MOSQUITTO_LIBRARIES ${MOSQUITTO_LIBRARIES} ${MOSQUITTO_LIBRARY} ${MOSQUITTOPP_LIBRARY})
    set(MOSQUITTO_INCLUDE_DIRS ${MOSQUITTO_INCLUDE_DIR})
endif()

# Hide some variables
mark_as_advanced(MOSQUITTO_INCLUDE_DIR MOSQUITTO_LIBRARY MOSQUITTOPP_LIBRARY MOSQUITTOPP_INCLUDE_DIR)