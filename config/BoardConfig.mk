include vendor/cyber/config/BoardConfigKernel.mk

ifeq ($(BOARD_HAVE_QCOM_FM),true)
include vendor/cyber/config/BoardConfigQcom.mk
endif

include vendor/cyber/config/BoardConfigSoong.mk
