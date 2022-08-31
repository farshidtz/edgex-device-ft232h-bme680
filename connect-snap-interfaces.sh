#!/bin/bash -ev

sudo snap connect edgexfoundry:edgex-secretstore-token edgex-device-ft232h-bme680:edgex-secretstore-token

sudo snap connect edgex-device-ft232h-bme680:raw-usb :raw-usb
