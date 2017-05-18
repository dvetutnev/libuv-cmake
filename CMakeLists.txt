CMAKE_MINIMUM_REQUIRED(VERSION 3.0)
PROJECT(libuv C)

FIND_PACKAGE(Threads)

SET(LIBUV_DIR "${CMAKE_CURRENT_SOURCE_DIR}/libuv")

FILE(GLOB LIBUV_COMMON_SOURCES "${LIBUV_DIR}/src/*.c")
FILE(GLOB LIBUV_LINUX_SOURCES "${LIBUV_DIR}/src/unix/linux-*.c")
FILE(GLOB LIBUV_WINDOWS_SOURCES "${LIBUV_DIR}/src/win/*.c")

ADD_LIBRARY(
   uv
   ${LIBUV_COMMON_SOURCES}

   # *nix
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/async.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/core.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/dl.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/fs.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/getaddrinfo.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/getnameinfo.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/loop.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/loop-watcher.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/pipe.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/poll.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/process.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/signal.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/stream.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/tcp.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/thread.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/timer.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/tty.c>"
   "$<$<NOT:$<PLATFORM_ID:Windows>>:${LIBUV_DIR}/src/unix/udp.c>"

   # AIX
   "$<$<PLATFORM_ID:AIX>:${LIBUV_DIR}/src/unix/aix.c>"

   # Darwin
   "$<$<PLATFORM_ID:Darwin>:${LIBUV_DIR}/src/unix/darwin.c>"
   "$<$<PLATFORM_ID:Darwin>:${LIBUV_DIR}/src/unix/darwin-proctitle.c>"
   "$<$<PLATFORM_ID:Darwin>:${LIBUV_DIR}/src/unix/fsevents.c>"
   "$<$<PLATFORM_ID:Darwin>:${LIBUV_DIR}/src/unix/kqueue.c>"
   "$<$<PLATFORM_ID:Darwin>:${LIBUV_DIR}/src/unix/proctitle.c>"
   "$<$<PLATFORM_ID:Darwin>:${LIBUV_DIR}/src/unix/pthread-barrier.c>"

   # FreeBSD
   "$<$<PLATFORM_ID:FreeBSD>:${LIBUV_DIR}/src/unix/freebsd.c>"
   "$<$<PLATFORM_ID:FreeBSD>:${LIBUV_DIR}/src/unix/kqueue.c>"

   # Linux
   "$<$<PLATFORM_ID:Linux>:${LIBUV_DIR}/src/unix/proctitle.c>"
   $<$<PLATFORM_ID:Linux>:${LIBUV_LINUX_SOURCES}>

   # NetBSD
   "$<$<PLATFORM_ID:NetBSD>:${LIBUV_DIR}/src/unix/kqueue.c>"
   "$<$<PLATFORM_ID:NetBSD>:${LIBUV_DIR}/src/unix/netbsd.c>"

   # OpenBSD
   "$<$<PLATFORM_ID:OpenBSD>:${LIBUV_DIR}/src/unix/kqueue.c>"
   "$<$<PLATFORM_ID:OpenBSD>:${LIBUV_DIR}/src/unix/openbsd.c>"

   # SunOS
   "$<$<PLATFORM_ID:SunOS>:${LIBUV_DIR}/src/unix/sunos.c>"

   # Windows
   $<$<PLATFORM_ID:Windows>:${LIBUV_WINDOWS_SOURCES}>
)
TARGET_COMPILE_DEFINITIONS(
   uv
   PRIVATE
   _GNU_SOURCE

   # *nix
   $<$<NOT:$<PLATFORM_ID:Windows>>:_FILE_OFFSET_BITS=64>
   $<$<NOT:$<PLATFORM_ID:Windows>>:_LARGEFILE_SOURCE>

   # AIX
   $<$<PLATFORM_ID:AIX>:_ALL_SOURCE>
   $<$<PLATFORM_ID:AIX>:_LINUX_SOURCE_COMPAT>
   $<$<PLATFORM_ID:AIX>:_THREAD_SAFE>
   $<$<PLATFORM_ID:AIX>:_XOPEN_SOURCE=500>

   # Darwin
   $<$<PLATFORM_ID:Darwin>:_DARWIN_UNLIMITED_SELECT=1>
   $<$<PLATFORM_ID:Darwin>:_DARWIN_USE_64_BIT_INODE=1>

   # Linux
   $<$<PLATFORM_ID:Linux>:_POSIX_C_SOURCE=200112>

   # SunOS
   $<$<PLATFORM_ID:SunOS>:__EXTENSIONS__>
   $<$<PLATFORM_ID:SunOS>:_XOPEN_SOURCE=500>

   # Windows
   $<$<PLATFORM_ID:Windows>:_CRT_NONSTDC_NO_WARNINGS>
   $<$<PLATFORM_ID:Windows>:_CRT_SECURE_NO_WARNINGS>
   $<$<PLATFORM_ID:Windows>:WIN32_LEAN_AND_MEAN>
   $<$<PLATFORM_ID:Windows>:_WIN32_WINNT=0x0600>
)
TARGET_COMPILE_OPTIONS(
   uv
   PRIVATE

   $<$<CXX_COMPILER_ID:AppleClang>:-g -fPIC -fvisibility=hidden -pedantic -pipe --std=gnu89 -Wall -Wextra -Wno-unused-parameter>
   $<$<CXX_COMPILER_ID:Clang>:-g -fPIC -fvisibility=hidden -pedantic -pipe --std=gnu89 -Wall -Wextra -Wno-unused-parameter -Wstrict-aliasing>
   $<$<CXX_COMPILER_ID:GNU>:-g -fPIC -fvisibility=hidden -pedantic -pipe --std=gnu89 -Wall -Wextra -Wno-unused-parameter -Wstrict-aliasing>
   $<$<CXX_COMPILER_ID:MSVC>:/DEBUG:FULL /GR- /MP /wd4244 /wd4267 /Zi>
)
TARGET_INCLUDE_DIRECTORIES(
    uv
    PRIVATE
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/libuv/include>"
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/libuv/src>"

    # *nix
    "$<$<NOT:$<PLATFORM_ID:Windows>>:$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/libuv/src/unix>>"

    # Windows
    "$<$<PLATFORM_ID:Windows>:$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/libuv/src/win>>"
)
TARGET_LINK_LIBRARIES(
   uv
   PRIVATE
   ${CMAKE_THREAD_LIBS_INIT}

   # *nix
   $<$<NOT:$<PLATFORM_ID:Windows>>:m>

   # AIX
   $<$<PLATFORM_ID:AIX>:perfstat>

   # FreeBSD
   $<$<PLATFORM_ID:FreeBSD>:kvm>

   # Linux
   $<$<PLATFORM_ID:Linux>:dl>
   $<$<PLATFORM_ID:Linux>:rt>

   # NetBSD
   $<$<PLATFORM_ID:NetBSD>:kvm>

   # OpenBSD
   $<$<PLATFORM_ID:OpenBSD>:kvm>

   # SunOS
   $<$<PLATFORM_ID:SunOS>:kstat>
   $<$<PLATFORM_ID:SunOS>:nsl>
   $<$<PLATFORM_ID:SunOS>:sendfile>
   $<$<PLATFORM_ID:SunOS>:socket>

   # Windows
   $<$<PLATFORM_ID:Windows>:advapi32>
   $<$<PLATFORM_ID:Windows>:iphlpapi>
   $<$<PLATFORM_ID:Windows>:psapi>
   $<$<PLATFORM_ID:Windows>:shell32>
   $<$<PLATFORM_ID:Windows>:userenv>
   $<$<PLATFORM_ID:Windows>:ws2_32>
)

OPTION(LIBUV_BUILD_TESTS "builds libuv tests and benchmarks if set to ON" OFF)
IF (LIBUV_BUILD_TESTS)
   ENABLE_TESTING()

   FILE(
      GLOB
      LIBUV_TEST_SOURCES
      "${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/*-server.c"
      "${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/test-*.c"
   )
   FILE(COPY "${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/fixtures" DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/test")
   ADD_EXECUTABLE(
      libuv-tests
      ${LIBUV_TEST_SOURCES}
      "${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/run-tests.c"
      "${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/runner.c"

      # *nix
      "$<$<NOT:$<PLATFORM_ID:Windows>>:${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/runner-unix.c>"

      # Windows
      "$<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/libuv/src/win/snprintf.c>"
      "$<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/runner-win.c>"
   )
   TARGET_COMPILE_DEFINITIONS(
      libuv-tests
      PRIVATE
      _GNU_SOURCE

      # AIX
      $<$<PLATFORM_ID:AIX>:_ALL_SOURCE>
      $<$<PLATFORM_ID:AIX>:_XOPEN_SOURCE=500>

      # SunOS
      $<$<PLATFORM_ID:SunOS>:__EXTENSIONS__>
      $<$<PLATFORM_ID:SunOS>:_XOPEN_SOURCE=500>

      # Windows
      $<$<PLATFORM_ID:Windows>:_CRT_NONSTDC_NO_WARNINGS>
      $<$<PLATFORM_ID:Windows>:_CRT_SECURE_NO_WARNINGS>
      $<$<PLATFORM_ID:Windows>:WIN32_LEAN_AND_MEAN>
      $<$<PLATFORM_ID:Windows>:_WIN32_WINNT=0x0600>
   )
   TARGET_COMPILE_OPTIONS(
      libuv-tests
      PRIVATE

      $<$<CXX_COMPILER_ID:AppleClang>:-g -pedantic -pipe --std=gnu89 -Wall -Wextra -Wno-long-long -Wno-unused-parameter>
      $<$<CXX_COMPILER_ID:Clang>:-g -pedantic -pipe --std=gnu89 -Wall -Wextra -Wno-long-long -Wno-unused-parameter -Wstrict-aliasing>
      $<$<CXX_COMPILER_ID:GNU>:-g -pedantic -pipe --std=gnu89 -Wall -Wextra -Wno-long-long -Wno-unused-parameter -Wstrict-aliasing>
      $<$<CXX_COMPILER_ID:MSVC>:/DEBUG:FULL /GR- /MP /wd4244 /wd4267 /Zi>
   )
   TARGET_INCLUDE_DIRECTORIES(
      libuv-tests
      PRIVATE
      "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/libuv/include>"
      "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/libuv/test>"
   )
   TARGET_LINK_LIBRARIES(
      libuv-tests
      uv

      # *nix
      $<$<NOT:$<PLATFORM_ID:Windows>>:util>

      # Windows
      $<$<PLATFORM_ID:Windows>:ws2_32>
   )
   ADD_TEST(
      NAME run-libuv-tests
      COMMAND libuv-tests
      WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
   )

   FILE(
      GLOB
      LIBUV_BENCHMARK_SOURCES
      "${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/*-server.c"
      "${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/benchmark-*.c"
   )
   ADD_EXECUTABLE(
      libuv-benchmarks
      ${LIBUV_BENCHMARK_SOURCES}
      "${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/run-benchmarks.c"
      "${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/runner.c"

      # *nix
      "$<$<NOT:$<PLATFORM_ID:Windows>>:${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/runner-unix.c>"

      # Windows
      "$<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/libuv/src/win/snprintf.c>"
      "$<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/libuv/test/runner-win.c>"
   )
   TARGET_COMPILE_DEFINITIONS(
      libuv-benchmarks
      PRIVATE
      _GNU_SOURCE

      $<$<PLATFORM_ID:Windows>:_CRT_NONSTDC_NO_WARNINGS>
      $<$<PLATFORM_ID:Windows>:_CRT_SECURE_NO_WARNINGS>
      $<$<PLATFORM_ID:Windows>:WIN32_LEAN_AND_MEAN>
      $<$<PLATFORM_ID:Windows>:_WIN32_WINNT=0x0600>
   )
   TARGET_COMPILE_OPTIONS(
      libuv-benchmarks
      PRIVATE

      $<$<CXX_COMPILER_ID:AppleClang>:-g -pedantic -pipe --std=gnu89 -Wall -Wextra -Wno-long-long -Wno-unused-parameter>
      $<$<CXX_COMPILER_ID:Clang>:-g -pedantic -pipe --std=gnu89 -Wall -Wextra -Wno-long-long -Wno-unused-parameter -Wstrict-aliasing>
      $<$<CXX_COMPILER_ID:GNU>:-g -pedantic -pipe --std=gnu89 -Wall -Wextra -Wno-long-long -Wno-unused-parameter -Wstrict-aliasing>
      $<$<CXX_COMPILER_ID:MSVC>:/DEBUG:FULL /GR- /MP /wd4244 /wd4267 /Zi>
   )
   TARGET_INCLUDE_DIRECTORIES(
      libuv-benchmarks
      PRIVATE
      "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/libuv/include>"
      "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/libuv/test>"
   )
   TARGET_LINK_LIBRARIES(
      libuv-benchmarks
      uv

      # *nix
      $<$<NOT:$<PLATFORM_ID:Windows>>:util>

      # Windows
      $<$<PLATFORM_ID:Windows>:ws2_32>
   )
ENDIF()
