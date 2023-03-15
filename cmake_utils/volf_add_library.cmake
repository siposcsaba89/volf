function(volf_add_library LIBRARY_NAME)
    set(options OPTIONAL)
    set(oneValueArgs DESTINATION RENAME FOLDER)
    set(multiValueArgs PUBLIC_HEADERS SRCS PUBLIC_DEPS PRIVATE_DEPS PUBLIC_DEFS PRIVATE_DEFS PUBLIC_COMPILE_OPTIONS PRIVATE_COMPILE_OPTIONS)
    cmake_parse_arguments(PARSE_ARGV 1
        "volf" #prefix
        "${options}" #options
        "${oneValueArgs}" # one value arguments
        "${multiValueArgs}") # multi value arguments
    
    add_library(${LIBRARY_NAME}
        ${volf_PUBLIC_HEADERS}
        ${volf_SRCS})
    
    string(REGEX REPLACE "^volf_" #matches at beginning of input
       "" BASE_NAME ${LIBRARY_NAME})
    message(STATUS "Adding alias library: volf::${BASE_NAME}")
    
    
    add_library(volf::${BASE_NAME} ALIAS ${LIBRARY_NAME})
    
    target_include_directories(${LIBRARY_NAME} PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
        $<INSTALL_INTERFACE:include/volf/${BASE_NAME}>)
    
    target_link_libraries(${LIBRARY_NAME} PUBLIC ${volf_PUBLIC_DEPS}
        PRIVATE ${volf_PRIVATE_DEPS})
    set_target_properties(${LIBRARY_NAME} PROPERTIES 
        CXX_STANDARD 14
        CXX_STANDARD_REQUIRED TRUE
        MAP_IMPORTED_CONFIG_RELWITHDEBINFO RELWITHDEBINFO RELEASE MINSIZEREL
        MAP_IMPORTED_CONFIG_MINSIZEREL MINSIZEREL RELEASE RELWITHDEBINFO
        DEBUG_POSTFIX _d
        RELWITHDEBINFO_POSTFIX _rd
        MINSIZEREL_POSTFIX _mr
        EXPORT_NAME ${BASE_NAME})

    if (volf_FOLDER)
        set_target_properties(${LIBRARY_NAME} PROPERTIES FOLDER ${volf_FOLDER})
    endif()
    if (BUILD_SHARED_LIBS)
        set_target_properties(${LIBRARY_NAME} PROPERTIES CXX_VISIBILITY_PRESET hidden)
        set_target_properties(${LIBRARY_NAME} PROPERTIES VISIBILITY_INLINES_HIDDEN 1)
    endif()

    if (volf_PUBLIC_DEFS)
        target_compile_definitions(${LIBRARY_NAME} PUBLIC ${volf_PUBLIC_DEFS})
    endif()

    if (volf_PRIVATE_DEFS)
        target_compile_definitions(${LIBRARY_NAME} PRIVATE ${volf_PRIVATE_DEFS})
    endif()
    
    if (volf_PRIVATE_COMPILE_OPTIONS)
        target_compile_options(${LIBRARY_NAME} PRIVATE ${volf_PRIVATE_COMPILE_OPTIONS})
    endif()

    if (volf_PUBLIC_COMPILE_OPTIONS)
        target_compile_options(${LIBRARY_NAME} PUBLIC ${volf_PUBLIC_COMPILE_OPTIONS})
    endif()

    include(CMakePackageConfigHelpers)
    write_basic_package_version_file(
        "${CMAKE_CURRENT_BINARY_DIR}/gen/${PROJECT_NAME}-config-version.cmake"
        VERSION 0.0.1
        COMPATIBILITY AnyNewerVersion
    )
    include(GenerateExportHeader)
    generate_export_header(${LIBRARY_NAME}
        EXPORT_FILE_NAME ${CMAKE_CURRENT_BINARY_DIR}/gen/volf/${BASE_NAME}/${BASE_NAME}_export.h)
    
    
    configure_file(cmake/config.cmake.in ${LIBRARY_NAME}-config.cmake @ONLY)
    install(TARGETS ${LIBRARY_NAME} EXPORT ${LIBRARY_NAME}-targets DESTINATION 
        ARCHIVE DESTINATION lib LIBRARY DESTINATION lib RUNTIME DESTINATION bin)
    install(FILES 
            ${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}-config.cmake 
            ${CMAKE_CURRENT_BINARY_DIR}/gen/${LIBRARY_NAME}-config-version.cmake
        DESTINATION 
            lib/cmake/${LIBRARY_NAME})
        
    install(EXPORT ${LIBRARY_NAME}-targets NAMESPACE volf:: DESTINATION lib/cmake/${LIBRARY_NAME})
    
    install(DIRECTORY
            include/
        DESTINATION include/volf/${BASE_NAME})
    install(FILES
            ${CMAKE_CURRENT_BINARY_DIR}/gen/volf/${BASE_NAME}/${BASE_NAME}_export.h
        DESTINATION include/volf/${BASE_NAME}/volf/${BASE_NAME})
endfunction()