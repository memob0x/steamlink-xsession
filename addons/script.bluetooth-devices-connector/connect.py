from utils import isDeviceState, exeBtCmd

def attemptInteraction(dev, cmd, state):
	def interact():
		exeBtCmd(cmd, dev)

	interact()

	attempts = 0

	while not isDeviceState(state, dev):
		attempts += 1

		if attempts == 3:
			return False

		interact()

	return True

def connect(devs):
	report = ""

	init = False

	for dev in devs:
		connected = attemptInteraction(dev, "connect", "Connected")

		if init:
			report += "\n\n"

		report += dev + " Connected: " + str(connected)

		paired = attemptInteraction(dev, "pair", "Paired")

		report += "\n" + dev + " Paired: " + str(paired)

		if connected and paired:
			paired = attemptInteraction(dev, "trust", "Trusted")

			report += "\n" + dev + " Trusted: " + str(paired)

		init = True

	return report
