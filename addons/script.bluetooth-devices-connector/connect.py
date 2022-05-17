from utils import isBtInfoState, exeBtCmd, log

def connect(devs):
	report = ""

	for dev in devs:
                log("-------------------------------------------------------------")
		log("connection " + dev + " start")
		log("-------------------------------------------------------------")

		info = exeBtCmd("info", dev)

		isTrusted = isBtInfoState(info, "Trusted")
		isPaired = isBtInfoState(info, "Paired")
		isConnected = isBtInfoState(info, "Connected")

		if not isTrusted:
			log(__file__ + " trying to trust " + dev)

			isTrusted = "succeeded" in exeBtCmd("trust", dev)

			log(__file__ + " " + dev + " trust result: " + str(isTrusted))

			report += "\n" + dev + " Trusted: " + str(isTrusted)
		else:
			log(__file__ + " " + dev + " already trusted")

			report += "\n" + dev + " already trusted"

		if not isPaired:
			log(__file__ + " trying to pair " + dev)

			isPaired = "succeeded" in exeBtCmd("pair", dev)

			log(__file__ + " " + dev + " pairing result: " + str(isPaired))

			report += "\n" + dev + " Paired: " + str(isPaired)
		else:
			log(__file__ + " " + dev + " already paired")

			report += "\n" + dev + " already paired"

                if not isConnected:
                        log(__file__ + " trying to connect to " + dev)

                        isConnected = "succeeded" in exeBtCmd("connect", dev)

                        log(__file__ + " " + dev + " connection result: " + str(isConnected))

                        report += dev + " Connected: " + str(isConnected)
		else:
			log(__file__ + " " + dev + " already connected")

			report += "\n" + dev + " already connected"

		log("-------------------------------------------------------------")
		log("connection " + dev + " end")
		log("-------------------------------------------------------------")

	return report

