for combo in $(curl -s https://raw.githubusercontent.com/CyberAOSP-Project/vendor_cyber_aosp/pie/cyberaosp.devices | sed -e 's/#.*$//' | awk '{printf "cyber_%s\n", $1, $2}')
do
    add_lunch_combo $combo-userdebug;
done
