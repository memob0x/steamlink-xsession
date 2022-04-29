from utils import isDeviceState, exeBtCmd, log

def attemptInteraction(dev, cmd, state):
	def interact():
		exeBtCmd(cmd, dev)

	attempts = 0

	while not isDeviceState(state, dev):
		if attempts == 3:
			return False

		interact()

		attempts += 1

	return True

def connect(devs):
	report = ""

	hasIteratedOnce = False

	for dev in devs:
		log(__file__ + " trying to connect to " + dev)

		isConnected = attemptInteraction(dev, "connect", "Connected")

		if hasIteratedOnce:
			report += "\n\n"

		log(__file__ + " " + dev + " connection result: " + str(isConnected))

		report += dev + " Connected: " + str(isConnected)

		log(__file__ + " trying to pair " + dev)

		isPaired = attemptInteraction(dev, "pair", "Paired")

		log(__file__ + " " + dev + " pairing result: " + str(isPaired))

		report += "\n" + dev + " Paired: " + str(isPaired)

		if isConnected and isPaired:
			log(__file__ + " trying to trust " + dev)

			isTrusted = attemptInteraction(dev, "trust", "Trusted")

			log(__file__ + " " + dev + " trust result: " + str(isTrusted))

			report += "\n" + dev + " Trusted: " + str(isTrusted)

		hasIteratedOnce = True

	return report
