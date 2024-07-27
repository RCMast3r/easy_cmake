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
        else()
            string(SUBSTRING "${package_command}" 0 ${space_index} package_name)
        endif()

        # Execute the find_package command with the specified options
        execute_process(COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --cyan "Running: find_package(${package_command})")
        find_package(${package_command})

        # Check for errors in finding the package
        if(NOT ${package_name}_FOUND)
            message(FATAL_ERROR "Failed to find package: ${package_command}")
        endif()

        # Append to the .cmake.in file content
        string(REPLACE " " ";" package_arg ${package_arg})
        set(dependency_file_content "${dependency_file_content}find_dependency(${package_arg})\n")
    endforeach()

    # Write the .cmake.in file using the specified output filename
    set(cmake_in_filepath "${CMAKE_CURRENT_BINARY_DIR}/${lib}.cmake.in")
    file(WRITE ${cmake_in_filepath} "${dependency_file_content}")
    message(STATUS "Generated ${cmake_in_filepath}")
endmacro()

# # Example usage:
# # Call the macro with the desired packages and options
# easy_find_packages(MyProjectConfig
#     "Boost REQUIRED COMPONENTS system"  # Boost with components
#     "Qt5 REQUIRED Widgets"              # Qt5 with Widgets
#     "Eigen3 REQUIRED"                   # Eigen3 without components
# )
