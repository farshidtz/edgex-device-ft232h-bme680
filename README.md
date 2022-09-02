# EdgeX FT232H BME680 Device Service

[Adafruit FT232H](https://www.adafruit.com/product/2264) is a USB to GPIO, SPI, I2C breakout board. 

This device service connects EdgeX to FT2322H to:
- Read from [BME680 Gas Sensor](https://www.adafruit.com/product/3660) connected over I2C
- Control the GPIO


## Native build and run
To setup the driver dependencies, refer to https://learn.adafruit.com/circuitpython-on-any-computer-with-ft232h/linux


Get a token from edgexfoundry:
```
./add-addon-service.sh
```

Go to `device-service` and configure the devices. Then build and run:
```
go run .
```

Get sensor values:
```
curl -X 'GET' 'http://localhost:59882/api/v2/device/name/GasSensor/ReadAll' | jq
```

Set GPIO output:
```
curl -X 'PUT' -d '{"State": true}'  'http://localhost:59882/api/v2/device/name/Fan/State' | jq
curl -X 'PUT' -d '{"State": false}'  'http://localhost:59882/api/v2/device/name/Fan/State' | jq
```

Delete devices and profiles:
```
# Gas sensor
curl -X 'DELETE'   'http://localhost:59881/api/v2/device/name/GasSensor' && curl -X 'DELETE'   'http://localhost:59881/api/v2/deviceprofile/name/BME680'

# GPIO
curl -X 'DELETE'   'http://localhost:59881/api/v2/device/name/Fan' && curl -X 'DELETE'   'http://localhost:59881/api/v2/deviceprofile/name/FanController' 
```

## Snap build and run

```
snapcraft -v
snap install ./edgex-device-ft232h-bme680_0+git.af8b6dd-dirty_amd64.snap --dangerous --classic
./add-addon-service.sh 
./connect-snap-interfaces.sh 
snap start edgex-device-ft232h-bme680.device-ft232h-bme680
```

Read the logs:
```
$ snap logs -f edgex-device-ft232h-bme680.device-ft232h-bme680 
...
2022-09-01T11:04:29+02:00 edgex-device-ft232h-bme680.device-ft232h-bme680[44439]: level=INFO ts=2022-09-01T09:04:29.352293222Z app=device-ft232h-bme680 source=message.go:55 msg="device service started"
2022-09-01T11:04:29+02:00 edgex-device-ft232h-bme680.device-ft232h-bme680[44439]: level=INFO ts=2022-09-01T09:04:29.35229734Z app=device-ft232h-bme680 source=message.go:58 msg="Service started in: 9.771266ms"
```
