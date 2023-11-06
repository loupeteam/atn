# Info
Library is provided by Loupe  
https://loupe.team  
info@loupe.team  
1-800-240-7042  

# Description
ATN provides an interface for reading distributed statuses and setting commands to distributed subsystems.  
It’s helpful to think of ATN as a broker that allows independent subsystems to communicate with each other by publishing and subscribing to certain topics on the broker.  
This may be reminiscent of the MQTT protocol for some, but here it is intended for communication between local processes on a single CPU.  
The core portion of ATN keeps track of the value of each topic, and it allows each Module in the system to publish a new value to that topic, or to subscribe to value changes for that topic.

For more documentation and examples, see https://loupeteam.github.io/LoupeDocs/libraries/atn.html

# Installation
To install using the Loupe Package Manager (LPM), in an initialized Automation Studio project directory run `lpm install atn`. For more information about LPM, see https://loupeteam.github.io/LoupeDocs/tools/lpm.html

## Licensing

This project is primarily licensed under the [MIT License](LICENSE).  However, it includes components under dual license strategy: GPL/LGPL and Bernecker + Rainer Industrie-Elektronik Ges.m.b.H Copyright.

-tlsf.h