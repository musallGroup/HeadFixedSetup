import time
from modules.Serial_functions import search_for_microcontroller_by_name, send_data_until_confirmation, wait_for_signal_byte


ADJUST_TOUCHLEVEL = 75
FLUSH_VALVE = 100
LED_ON = 101
LED_OFF = 102
WAIT_FOR_LICK_REWARDED = 103
WAIT_FOR_LICK_NOT_REWARDED = 104
MODULE_INFO = 255  # returns module information

# valve_duration = 2  # in ms


def initialize_microcontroller(module_name="HomecageTouchscreenESP32", valve_duration=100, testMode=False):
    # For now, I assume that only one chamber is connected per PC. If that changes then we would need to give each
    # Microcontroller a unique identifier and search for this specific setup.
    # run setup without Microcontroller
    if not testMode:
        # If memory serves me well, this just throws an error if the module is not found and the program aborts with
        # this as intended
        serial_obj = search_for_microcontroller_by_name(module_name)

        # This takes ~2s. In this time the mouse is not allowed to touch the Spout!
        calibrate_lick_sensor(serial_obj)

        # This line is necessary as it sets the desired valve duration for the setup!
        give_reward(serial_obj, valve_duration=valve_duration)
        print('ready')
    else:
        for _ in range(25):
            print("WARNING! The setup is running in test mode. Only for debugging!")
        #
        serial_obj = None
    #

    return serial_obj
#


def calibrate_lick_sensor(serial_obj):
    send_data_until_confirmation(serial_obj, header_byte=ADJUST_TOUCHLEVEL, data=[1])
    time.sleep(2.)

    return 0
#


def phase_0_lick_detection(serial_obj, timeout=30):
    # timeout for how long to wait for a response in sec
    send_data_until_confirmation(serial_obj=serial_obj, header_byte=WAIT_FOR_LICK_REWARDED,
                                 data=[timeout * 1000])

    st = time.time()
    # There is an additional timeout that if the mouse doesn't lick for more than 2min the session is stopped. This can be changed is desired.
    while time.time() - st < 120:
        input_raw, received = wait_for_signal_byte(serial_obj=serial_obj, target_bytes=[FLUSH_VALVE], timeout=0.5)

        if time.time() - st > timeout:
            print('Auto-reward')
            give_reward(serial_obj)
            break
        #

        if received:
            print('CORRECT')
            break
        #
    #
#


def lick_detection(win, serial_obj, rewarded=True, timeout=120):
    stop = False

    # timeout = 120  # sec
    if rewarded:
        send_data_until_confirmation(serial_obj=serial_obj, header_byte=WAIT_FOR_LICK_REWARDED,
                                     data=[timeout * 1000])
    else:
        send_data_until_confirmation(serial_obj=serial_obj, header_byte=WAIT_FOR_LICK_NOT_REWARDED,
                                     data=[timeout * 1000])
    #

    st = time.time()
    received = True
    while time.time() - st < 120:
        input_raw, received = wait_for_signal_byte(serial_obj=serial_obj, target_bytes=[FLUSH_VALVE], timeout=0.5)

        if win is not None:
            win.flip()
        #

        if received:
            break
        #
    #

    if not received:
        stop = True
    #

    return stop
#


def give_reward(serial_obj, valve_duration=100):
    send_data_until_confirmation(serial_obj=serial_obj, header_byte=FLUSH_VALVE,
                                 data=[valve_duration * 1000])
#


def led_on(serial_obj):
    send_data_until_confirmation(serial_obj=serial_obj, header_byte=LED_ON)
#


def led_off(serial_obj):
    send_data_until_confirmation(serial_obj=serial_obj, header_byte=LED_OFF)
#


if __name__ == "__main__":
    ADJUST_TOUCHLEVEL = 75

    serial_obj = initialize_microcontroller()
    send_data_until_confirmation(serial_obj, header_byte=ADJUST_TOUCHLEVEL, data=[5])
    send_data_until_confirmation(serial_obj, header_byte=LED_ON)
    print("ON")
    time.sleep(0.5)
    send_data_until_confirmation(serial_obj, header_byte=LED_OFF)
    print("OFF")
    time.sleep(0.5)

    send_data_until_confirmation(serial_obj, header_byte=LED_ON)
    print("ON")
    time.sleep(0.5)
    send_data_until_confirmation(serial_obj, header_byte=LED_OFF)
    print("OFF")
#
