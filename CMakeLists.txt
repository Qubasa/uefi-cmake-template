cmake_minimum_required(VERSION 3.16)

# Set debug mode
set(CMAKE_BUILD_TYPE Debug)


# Find clang++ executable and set it as compiler
find_program(Clang_P clang++ REQUIRED True)
set(CMAKE_CXX_COMPILER ${Clang_P})

# Find clang executable and set it as compiler
find_program(Clang_C clang REQUIRED True)
set(CMAKE_C_COMPILER ${Clang_C})
# lots of warnings and all warnings as errors
add_compile_options(-Wall -Wextra -pedantic -Werror
    -Wno-unused-variable
)

# Disable cmakes compiler test
# because of this cross compilation chain
# the normal compile test would fail
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Set target to baremetal windows
set(CMAKE_C_COMPILER_TARGET  x86_64-unknown-windows)
set(CMAKE_CXX_COMPILER_TARGET  x86_64-unknown-windows)
add_compile_options(-ffreestanding) # Baremetal environment
add_compile_options(-fshort-wchar) # Make L strings two bytes wide
add_compile_options(-mno-red-zone) # Disable dangerous optimization
add_compile_options(-masm=intel) # Enable intel asm syntax

# Ignore errors to get EDK2 headers to work
add_compile_options(-Wno-unused-command-line-argument)
add_compile_options(-Wno-c11-extensions)
add_compile_options(-Wno-c99-extensions)
add_compile_options(-Wno-language-extension-token)
add_compile_options(-Wno-microsoft-enum-value)
add_compile_options(-Wno-writable-strings)

# Use windows lld linker & add linker options
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fuse-ld=lld-link")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -nostdlib")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-entry:efi_main")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-subsystem:efi_application")

# set the project name
project(BOOTX64.EFI VERSION 0.1)

# specify the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Generate compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Get num cores & set num threads for build
include(ProcessorCount)
ProcessorCount(N)
if(NOT N EQUAL 0)
    set(CMAKE_BUILD_PARALLEL_LEVEL ${N})
endif()

# add FetchContent
include(FetchContent)

# add the executable
add_executable(${PROJECT_NAME} src/main.cpp)

# add include directory include/
target_include_directories(${PROJECT_NAME} PUBLIC include include/UEFI
    include/UEFI/X64)

# FetchContent_Declare(
# fmt
# GIT_REPOSITORY https://github.com/fmtlib/fmt
# GIT_TAG 7.0.3
# GIT_PROGRESS True
# )
# FetchContent_MakeAvailable(fmt)

# target_link_libraries(${PROJECT_NAME} fmt)
