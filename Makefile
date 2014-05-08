ARCHS = armv7 armv7s arm64
SDKVERSION = 7.0

export THEOS_DEVICE_IP = 192.168.1.4
include theos/makefiles/common.mk

BUNDLE_NAME = FakeLowBatteryCCToggle
FakeLowBatteryCCToggle_FILES = Toggle.xm
FakeLowBatteryCCToggle_INSTALL_PATH = /Library/Application Support/CCToggles/Toggles
FakeLowBatteryCCToggle_FRAMEWORKS = UIKit
FakeLowBatteryCCToggle_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/bundle.mk

SUBPROJECTS += ccfakelowbattery
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"