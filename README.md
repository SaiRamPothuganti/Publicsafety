# Public Safety
## An Oracle Innovation Project


### Hardware Requirements
- Tello Drone: Ryze Tello Edu Drone powered by DJI 
  - (link  to buy)
- Linksys: Next-Gen AC Dual-Band AC600 USB Network Adapter 
  – (this External NIC card helps you to connect to 2 WIFI’s at the same time, allowing simultaneous communication with drone and cloud servers
- Wio Link & Wio Node
- Grove System Components
  - Temperature & Humidity Sensor （DHT11）
  – Light sensor
  - One Wire Temperature Sensor
  - Solid State Relay
  - Power bank (optional) 
- Building Model

### Software Requirements
- Windows 10
- Wio (Mobile App)
- Oracle Cloud Account
  - 1 OCPU – OCI Compute
  - 1 OCPU for Integration Cloud Instance
  - 1 OCPU for ATP (AQ & Data Storage)

## Quickstart
### Windows Configuration
- Install Python 2.7
- Install Python Django REST framework
- Install ngrok
- Install the Linksys External NIC Card
- Turn off Windows Defender to allow ngrok to tunnel to public internet

### OCI-compute Configuration (Terra-form)
- Import the image into OCI 
  – custom image with object storage url: COMPUTE
- VCN Should allow traffic (ingress & egress) through ports 80, 3306, 9094, 9092, 9093

### Sensors Configuration
- Connect Wio smartphone app to a non-Oracle wi-fi (Don’t connect to clear-guest, clear-internet, or clear-cooperate)
- Change proxy configuration to automatic
- You can look at sample sensor configurations





