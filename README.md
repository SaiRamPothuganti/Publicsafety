# Public Safety
## An Oracle Innovation Project


### Hardware Requirements
- Tello Drone: Ryze Tello Edu Drone powered by DJI 
  - https://www.apple.com/shop/product/HMBE2ZM/A/ryze-tello-edu-drone-powered-by-dji?fnode=359878eb0501816c5219a5d9fe44923300b1adcd52511952d106aa574667498f649ba65aceeb180b40f34fa5e1d7838d613d714d38f94e55dd38fe1deb17bd554ec491871cda1d45bbe8866692577c8fc0c1d9b88afad0fa702023856d43d688
  
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
  – custom image with object storage url: COMPUTE (https://objectstorage.us-ashburn-1.oraclecloud.com/p/IWcS0CfqE3lCT4Of0O0E-Ir6FQorZ6QluZz78y_6FYA/n/orasenatdpltintegration01/b/PublicSafetyImageRepo/o/OML_PS2)
- VCN Should allow traffic (ingress & egress) through ports 80, 3306, 9094, 9092, 9093

### Sensors Configuration
- Connect Wio smartphone app to a non-Oracle wi-fi (Don’t connect to clear-guest, clear-internet, or clear-cooperate)
- Change proxy configuration to automatic
- You can look at sample sensor configurations





