from utils import isDeviceState, exeBtCmd, log

from time import sleep

def connect(devs):
	report = ""

	for dev in devs:
		log(__file__ + " trying to trust " + dev)

		isTrusted = "succeeded" in exeBtCmd("trust", dev)

		log(__file__ + " " + dev + " trust result: " + str(isTrusted))

		report += "\n" + dev + " Trusted: " + str(isTrusted)

		sleep(2)

		isPaired = isDeviceState("Paired", dev)

		if not isPaired:
			log(__file__ + " trying to pair " + dev)

			isPaired = "succeeded" in exeBtCmd("pair", dev)

			log(__file__ + " " + dev + " pairing result: " + str(isPaired))

			report += "\n" + dev + " Paired: " + str(isPaired)

		sleep(2)

                isConnected = isDeviceState("Connected", dev)

                if not isConnected:
                        log(__file__ + " trying to connect to " + dev)

                        isConnected = "succeeded" in exeBtCmd("connect", dev)

                        log(__file__ + " " + dev + " connection result: " + str(isConnected))

                        report += dev + " Connected: " + str(isConnected)

	return report

