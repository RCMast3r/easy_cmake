# Define a macro to simplify finding multiple packages with options and generate a .cmake.in file

macro(easy_find_packages lib)
    # Initialize a variable to store the content for the .cmake.in file
    set(dependency_file_content "@PACKAGE_INIT@\n\ninclude(CMakeFindDependencyMacro)\n\n")

    # Loop over each package and its options
    foreach(package_arg ${ARGV})
        if (package_arg STREQUAL ${ARGV0})
            continue() # Skip the first argument, which is the output filename
        endif()

        # Use the semicolon as a delimiter to split the argument into package name and options
        string(REPLACE ";" " " package_command ${package_arg})

        # Extract the package name by taking the first word before any space
        string(FIND "${package_command}" " " space_index)
        if(space_index EQUAL -1)
            set(package_name ${package_command})
            set(using_components FALSE)
        else()
            string(SUBSTRING "${package_command}" 0 ${space_index} package_name)
            set(using_components TRUE)
            message(${space_index})
            message(${package_name})
            string(LENGTH ${package_command} length_of_package_command)
            string(SUBSTRING ${package_command} "${space_index}" ${length_of_package_command} package_components)
            string(SUBSTRING ${package_components} 1 -1 package_components)
            string(REPLACE " " ";" package_components ${package_components})
        endif()

        if(NOT ${using_components})
            find_package(${package_name} REQUIRED)
        else()
            message(STATUS "finding components ${package_components}")
            find_package(${package_name} REQUIRED COMPONENTS ${package_components})
        endif()

        # Check for errors in finding the package
        if(NOT ${package_name}_FOUND)
            message(FATAL_ERROR "Failed to find package: ${package_command}")
        endif()

        # Append to the .cmake.in file content
        if(using_components)
            string(REPLACE ";" " " package_components "${package_components}")
            set(dependency_file_content "${dependency_file_content}find_dependency(${package_name} REQUIRED COMPONENTS ${package_components})\n")
        else()
            set(dependency_file_content "${dependency_file_content}find_dependency(${package_name} REQUIRED)\n")
        endif()
    endforeach()

    set(dependency_file_content "${dependency_file_content}\ncheck_required_components(${lib})")
    # Write the .cmake.in file using the specified output filename
    set(cmake_in_filepath "${CMAKE_CURRENT_BINARY_DIR}/${lib}Config.cmake.in")
    file(WRITE ${cmake_in_filepath} "${dependency_file_content}")
    message(STATUS "Generated ${cmake_in_filepath}")
endmacro()
