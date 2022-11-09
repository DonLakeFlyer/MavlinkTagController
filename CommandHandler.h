#pragma once

#include <mavsdk/mavsdk.h>
#include <mavsdk/plugins/mavlink_passthrough/mavlink_passthrough.h>

#include "uavrt_interfaces/include/uavrt_interfaces/TunnelProtocol.h"

using namespace mavsdk;

class CommandHandler {
public:
    CommandHandler(System& system, MavlinkPassthrough& mavlinkPassthrough);

private:
    void _sendCommandAck        (uint32_t command, uint32_t result);
    void _handleTagCommand      (const mavlink_tunnel_t& tunnel);
    void _handleStartDetection  (void);
    void _handleStopDetection   (void);
    void _handleTunnelMessage   (mavlink_message_t& message);


private:
    System&                     _system;
    MavlinkPassthrough&         _mavlinkPassthrough;
    TunnelProtocol::TagInfo_t   _tagInfo;
};
