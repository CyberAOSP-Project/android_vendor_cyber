# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

PRODUCT_BRAND ?= CyberAOSP

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    keyguard.no_require_sim=true \
    ro.build.selinux=1

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.sys.dun.override=0
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/cache
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cyber/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cyber/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cyber/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \
    vendor/cyber/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/cyber/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/cyber/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/cyber/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Some permissions
PRODUCT_COPY_FILES += \
    vendor/cyber/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
    vendor/cyber/config/permissions/privapp-permissions-cyber.xml:system/etc/permissions/privapp-permissions-cyber.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/cyber/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/cyber/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all cyber init rc files
$(foreach f,$(wildcard vendor/cyber/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/cyber/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Optional packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/cyber/overlay

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    vendor/cyber/overlay/common \
    vendor/cyber/overlay/themes

# Key disabler package
PRODUCT_PACKAGES += \
    org.cyberaosp.keydisabler

PRODUCT_BOOT_JARS += \
    org.cyberaosp.keydisabler

# CyberAOSP Packages
PRODUCT_PACKAGES += \
    WellbeingPrebuilt \
    Gallery2 \
    LatinIME \
    Launcher3 \
    GContacts \
    GDeskClock \
    GDialer \
    GMessaging \
    CyberSettings \
    OmniStyle

# Branding
include vendor/cyber/config/branding.mk

# Bootanimation
include vendor/cyber/config/bootanimation.mk

# Fonts
include vendor/cyber/config/fonts.mk

# Sounds
include vendor/cyber/config/sounds.mk

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/cyber/prebuilt/common/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

# Additional
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opa.eligible_device=true

# Themes
PRODUCT_PACKAGES += \
    SystemDarkTheme

-include $(WORKSPACE)/build_env/image-auto-bits.mk
