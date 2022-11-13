#pragma once

#include <Mavlink.hpp>

#include <string>
#include <memory>
#include <thread>
#include <atomic>

class UDPPulseReceiver
{
public:
	UDPPulseReceiver(std::string localIp, int localPort, mavlink::Mavlink& mavlink);
	~UDPPulseReceiver();

	void start 	(void);
	void stop 	(void);
	void receive(void);

private:
	bool _setupPort	(void);

    std::string 			_localIp;
    int 					_localPort;
    int 					_fdSocket	{-1};
    mavlink::Mavlink& 		_mavlink;
};