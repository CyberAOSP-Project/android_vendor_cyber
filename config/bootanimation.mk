ifeq ($(TARGET_BOOT_ANIMATION_RES),720)
     PRODUCT_COPY_FILES += vendor/cyber/bootanimation/bootanimation_720.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1080)
     PRODUCT_COPY_FILES += vendor/cyber/bootanimation/bootanimation_1080.zip:system/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1440)
     PRODUCT_COPY_FILES += vendor/cyber/bootanimation/bootanimation_1440.zip:system/media/bootanimation.zip
else
     $(warning "CyberAOSP: TARGET_BOOT_ANIMATION_RES is undefined, assuming 720p")
     PRODUCT_COPY_FILES += vendor/cyber/bootanimation/bootanimation_720.zip:system/media/bootanimation.zip
endif
