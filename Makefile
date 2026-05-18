TARGET := iphone:clang:16.5:14.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoIGBetaNag

$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk

after-NoIGBetaNag-all::
	@if [ -f $(THEOS)/toolchain/linux/iphone/bin/install_name_tool ]; then $(THEOS)/toolchain/linux/iphone/bin/install_name_tool -change /Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate @executable_path/Frameworks/CydiaSubstrate.framework/CydiaSubstrate $(THEOS_OBJ_DIR)/NoIGBetaNag.dylib; elif command -v install_name_tool >/dev/null 2>&1; then install_name_tool -change /Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate @executable_path/Frameworks/CydiaSubstrate.framework/CydiaSubstrate $(THEOS_OBJ_DIR)/NoIGBetaNag.dylib; fi
