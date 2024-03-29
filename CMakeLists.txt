cmake_minimum_required(VERSION 3.10.2)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pthread")

project(MavlinkTagController)

if(NOT MSVC)
    add_definitions("-Wall -Wextra")
else()
    add_definitions("-WX -W2")
endif()

find_package(MAVSDK REQUIRED)

add_executable(MavlinkTagController
    main.cpp
    channelizerTuner.cpp channelizerTuner.h
    CommandHandler.cpp CommandHandler.h
    UDPPulseReceiver.cpp UDPPulseReceiver.h
    sendTunnelMessage.cpp sendTunnelMessage.h
    sendStatusText.cpp sendStatusText.h
    MonitoredProcess.cpp MonitoredProcess.h
    log.cpp log.h
    formatString.h
    TagDatabase.cpp TagDatabase.h
    TelemetryCache.cpp TelemetryCache.h
    MavlinkOutgoingMessageQueue.cpp MavlinkOutgoingMessageQueue.h
    startHeartbeatSender.cpp startHeartbeatSender.h
    uavrt_interfaces/include/uavrt_interfaces/TunnelProtocol.h
)

target_link_libraries(MavlinkTagController
    MAVSDK::mavsdk
)

target_include_directories(MavlinkTagController
    PRIVATE
    uavrt_interfaces/include/uavrt_interfaces
)
