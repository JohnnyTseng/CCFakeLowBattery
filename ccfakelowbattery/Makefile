
ARCHS = armv7 armv7s arm64
SDKVERSION = 7.0

include theos/makefiles/common.mk

BUNDLE_NAME = CCFakeLowBattery
CCFakeLowBattery_FILES = CCFakeLowBattery.mm
CCFakeLowBattery_INSTALL_PATH = /Library/PreferenceBundles
CCFakeLowBattery_FRAMEWORKS = UIKit
CCFakeLowBattery_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CCFakeLowBattery.plist$(ECHO_END)
