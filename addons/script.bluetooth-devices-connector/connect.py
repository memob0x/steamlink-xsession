from utils import isDeviceState, exeBtCmd, log

def connect(devs):
	report = ""

	for dev in devs:
		log(__file__ + " trying to trust " + dev)

		exeBtCmd("trust", dev)

		isTrusted = isDeviceState("Trusted", dev)

		log(__file__ + " " + dev + " trust result: " + str(isTrusted))

		report += "\n" + dev + " Trusted: " + str(isTrusted)

		# ---

		isPaired = isDeviceState("Paired", dev)

		if not isPaired:
			log(__file__ + " trying to pair " + dev)

			exeBtCmd("pair", dev)

			isPaired = isDeviceState("Paired", dev)

			log(__file__ + " " + dev + " pairing result: " + str(isPaired))

			report += "\n" + dev + " Paired: " + str(isPaired)

		# ---

                isConnected = isDeviceState("Connected", dev)

                if not isConnected:
                        log(__file__ + " trying to connect to " + dev)

                        exeBtCmd("connect", dev)

                        isConnected = isDeviceState("Connected", dev)

                        log(__file__ + " " + dev + " connection result: " + str(isConnected))

                        report += dev + " Connected: " + str(isConnected)

	return report

