# Set all versions
CYBER_BUILD_TYPE ?= UNOFFICIAL
CYBER_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)
CYBER_PLATFORM_VERSION := 9.0

TARGET_PRODUCT_SHORT := $(subst cyber_,,$(CYBER_BUILD))
CYBER_VERSION := CyberAOSP_$(CYBER_BUILD)-$(CYBER_PLATFORM_VERSION)-$(CYBER_BUILD_DATE)-$(CYBER_BUILD_TYPE)
ROM_FINGERPRINT := CyberAOSP/$(CYBER_PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(CYBER_BUILD_DATE)

CYBER_PROPERTIES := \
    org.cyberaosp.version=$(CYBER_VERSION) \
    org.cyberaosp.build_date=$(CYBER_BUILD_DATE) \
    org.cyberaosp.build_type=$(CYBER_BUILD_TYPE) \
    org.cyberaosp.fingerprint=$(ROM_FINGERPRINT)