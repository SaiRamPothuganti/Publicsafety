# Publicsafety
# Innovation Project from Oracle .

## Hardware Requirements.

- Laptop -  windows 10 OS  (Drone Server)
- Tello Drone - Ryze Tello Edu Drone powered by DJI ( link  to buy )
- Linksys - Next-Gen AC Dual-Band AC600 USB Network Adapter – (this External NIC card helps you to connect to 2 WIFI’s at the same time – Which helps us to Communicate to the drone and Cloud at the same time).
-Building Model.
- Wio Link  , Wio Node.
- Grove - Temperature & Humidity Sensor （DHT11）
- Grove – Light sensor
- Grove - One Wire Temperature Sensor
- Power bank (optional) 
- Grove – Solid State Relay.

## Software Requirements.

- Wio (mobile App)
- Oracle Cloud Account ( minimum 3 OCPU’s  , 1 OCPU – OCI Compute , 1 OCPU for Integration Cloud Instance , 1 - OCPU for ATP (for AQ & Data to store))
- windows 10 OS installed on the laptop ( Drone Server)


## Windows Laptop Configuration.
- Install Python (Preferably python 2.7 ) 
- Install python Django rest framework
- Install ngrok.
- Install the Linksys (External NIC Card)
- Turn off Windows Defender (so it allows ngrok to tunnel to public internet)

## OCI- compute Configuration (Terra-form )
- Import the image into OCI – custom image with this objet storage url : COMPUTE
- VCN Should allow traffic through these 4 ports 80,3306,9094,9092,9093 ingress and egress 


## Sensors Configuration

- Download the Wio App (Preferably iPhone) 
- Connect to a non-oracle Wi-Fi ( Don’t connect to clear-guest , clear-internet, clear-cooperate)
- Change the configuration of Proxy to automatic
- You can look at sample examples to configure the sensors 





