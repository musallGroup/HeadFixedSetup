# This file is part of the autonomous TouchscreenChamber-HomeCageSystem Project,
# and is released under the "CC BY-NC-SA" LICENSE.
# Copyright 2024 by Gerion Nabbefeld, Department for Neurophysiology at RWTH Aachen University.

# The general structure of this project is based on the TouchScreen Routine published by Wiesbrock et al. 2022.
# The routine has been upgraded to run on newer Windows versions, now integrating movie and audiovisual stimulation.
# Further, the TouchscreenChamber now uses a microcontroller for improved lick-detection, timing and general
# reliability.


# In this file I want to create the new general TouchscreenChamber class that all future Experimental paradigms should
# be built upon.

from os import path, makedirs, getcwd
import numpy as np
import pandas
from datetime import datetime
import time
from copy import deepcopy
from psychopy import visual, core, data, event, logging, sound, gui
from modules.functions import (initialize_microcontroller, calibrate_lick_sensor, phase_0_lick_detection,
                               lick_detection, led_on, led_off, give_reward)
from modules.BiasCorrection import BiasCorrection
from modules.TouchscreenInput import TouchscreenInput
from modules.AuditoryCue import play_auditory_cue
from modules.GeneralStimulusClass import MovieStimuli


testMode = True
if testMode:
    for _ in range(125):
        print("WARNING!!! Running in Test Mode without hardware!!!")
    #
#


class TrialVariables:
    # I thought about making this a dataclass, but undecided for now
    def __init__(self, animal_id, protocol_name, session_date_time, session_start_time):
        # This defines all the variables that we want to save later for this experiment

        # These are general parameters that don't change during the session:
        self.animal_id = [animal_id]
        self.protocol_name = [protocol_name]
        self.session_date_time = [session_date_time]
        self.session_start_time = [session_start_time]

        # These are the Trial specific variables that are updated in every trial:
        self.trial_id = []
        self.trial_start_time = []
        self.response_time = []
        self.lick_time = []
        self.target_side = []
        self.response_side = []
        self.correct_response = []
        self.target_stimulus = []
        self.distractor_stimulus = []
    #

    def update_trial_data(self, trial_id, trial_start_time, response_time, lick_time, target_side, response_side,
                          correct_response, target_stimulus, distractor_stimulus):
        # This can be adapted or solved differently, but I wanted to give some structure and an indication what has to
        # be updated every trial and saved accordingly

        # First the variables that don't change in a during a session:
        if trial_id > 1:
            # I want ot skipp it for the first trial
            self.animal_id.append(self.animal_id[0])
            self.protocol_name.append(self.protocol_name[0])
            self.session_date_time.append(self.session_date_time[0])
            self.session_start_time.append(self.session_start_time[0])
        #

        # Now all the Trial-Variables:
        # Now all the Trial-Variables:
        self.trial_id.append(trial_id)
        self.trial_start_time.append(trial_start_time)
        self.response_time.append(response_time)
        self.lick_time.append(lick_time)
        self.target_side.append(target_side)
        self.response_side.append(response_side)
        self.correct_response.append(correct_response)
        self.target_stimulus.append(target_stimulus)
        self.distractor_stimulus.append(distractor_stimulus)
    #

    def save_to_excel(self, save_file_name):
        # Each of those variables is a list that has been appended in every trial. They all must be exactly the same
        # length for this to work!
        df = pandas.DataFrame(data={"animal_id": self.animal_id,
                                    "protocol_name": self.protocol_name,
                                    "session_date_time": self.session_date_time,
                                    "trial_id": self.trial_id,
                                    "target_side": self.target_side,
                                    "response_side": self.response_side,
                                    "correct_response": self.correct_response,
                                    "session_start_time": self.session_start_time,
                                    "trial_start_time": self.trial_start_time,
                                    "response_time": self.response_time,
                                    "lick_time": self.lick_time,
                                    "target_stimulus": self.target_stimulus,
                                    "distractor_stimulus": self.distractor_stimulus})
        df.to_excel(save_file_name)
        # df.to_csv(save_file_name)
    #
#


class TouchscreenChamber:
    def __init__(self, protocol, animal_id):
        # ## INPUT HANDLING ## #
        self.animal_id = animal_id

        # store the protocol.
        # self.experimental_task = experimental_task
        # self.Protocol_name = protocol.Protocol_name
        # self.protocol.ITI = protocol.ITI  # in sec
        self.protocol = protocol

        #

        # ## CLASSES ## #
        self.bias_correction = BiasCorrection()  # Initialize here. Is used to get the target_side for the next trial

        # general setting:
        # ToDo: We should make this a general config for the entire setup instead even above the level of protocols!
        self.valve_duration = 100  # in ms

        # runtime variables
        self.stop_session = False
        # self.touch_delay = 0
        # self.lick_delay = 0
        self.target_side = None  # ["left", "right"]
        self.response_registered = False
        self.response_side = None
        self.last_response = None  # ["left", "right"]. Note: currently missed isn't an option. We only have a timeout!
        self.correct_response = None
        self.target_stimulus = None
        self.distractor_stimulus = None

        # ## HARDWARE ## #
        # initializations:
        if not testMode:
            self.serial_obj = initialize_microcontroller(module_name="HomecageTouchscreenESP32")
        #

        # Initialize the stimulus.
        # Currently only the Movie as this one is the trickiest to get running well with Psychopy!
        # Adapting this general design to static images is trivial:
        if self.protocol.present_stimuli:
            if self.protocol.movie_stimuli:
                # The GeneralStimulus class opens the window now at __init__():
                self.Stimulus = MovieStimuli()
                self.touchscreen = TouchscreenInput(win=self.Stimulus.win)
            #
        #

        # ## SAVING ## #
        # Since this is time related I want to get the start-time the last
        self.save_folder = path.join(getcwd(), "data")
        self.experimenter_name = "HomeCageSystem"
        makedirs(self.save_folder, exist_ok=True)
        session_date_time = datetime.now().strftime('%Y%m%d_%H%M%S')
        self.save_file_basename = path.join(self.save_folder, self.animal_id + "_" + session_date_time + "_" + self.experimenter_name)

        # ## TIME KEEPING ## #
        # Session variables
        self.session_start_time = time.time()
        self.trial_start_time = deepcopy(self.session_start_time)  # to copy the value and not generate a pointer
        self.response_time = deepcopy(self.session_start_time)
        self.lick_time = deepcopy(self.session_start_time)
        self.trial_id = 0

        # Not sure if this is how I want to solve it in the end, but I might. The idea would be to set all changed
        # variables at the end of a trial and then add them to a DataFrame for saving
        # self.trial_variables = {"animal_id": self.animal_id,
        #                         "protocol": self.protocol.Protocol_name,
        #                         "session_date_time": session_date_time,
        #                         "trial_id": 0,
        #                         "session_start_time": self.session_start_time,
        #                         "trial_start_time": self.trial_start_time,
        #                         "response_time": self.response_time,
        #                         "lick_time": self.lick_time,
        #                         "target_side": None,
        #                         "response_side": None,
        #                         "correct_response": None,
        #                         "target_stimulus": "",
        #                         "distractor_stimulus": ""}

        # I made this a class now to clearly predefine that expected variables
        self.trial_variables = TrialVariables(self.animal_id,
                                              self.protocol.Protocol_name,
                                              session_date_time,
                                              self.session_start_time)
    #

    def run_session(self, trial_timeout=120):
        # trial_timeout in seconds. if the animal doesn't respond in this time period the session is stopped.

        # overwrite the session_start_time with the time the first trial is actually started.
        self.session_start_time = time.time()
        while not self.stop_session:
            if hasattr(self.protocol, "maximum_number_trials"):
                if self.trial_id >= self.protocol.maximum_number_trials:
                    break
                #
            #

            try:
                # Inside a try to ensure that data will be saved even if something goes wrong
                self.new_trial(trial_timeout=trial_timeout)
            except Exception as e:
                print(e)
            #
        #

        # Save all the data we have acquired during this session
        self.trial_variables.save_to_excel(self.save_file_basename + ".xlsx")
    #

    def new_trial(self, trial_timeout=120):
        # trial_timeout in seconds. if the animal doesn't respond in this time period the session is stopped.

        # There is so much unnecessary stuff going on in the old scripts.
        # I just want to have a clean one from scratch to have a better overview

        # ## next trial init
        # Determine the next target side based on the correction based on Knutzen et al. 2006
        self.target_side = self.bias_correction.get_next_target_side(response=self.last_response)

        # reset touchscreen to be able to register the next response
        self.touchscreen.reset()

        if self.protocol.movie_stimuli:
            # stimulus_files: consisting of ["target_path.mp4", "distractor_path.mp4"]
            # if different stimuli are desired in different trials, to this here:
            #     e.g.: stimulus_files[0:2, self.trial_id]
            self.target_stimulus = self.protocol.stimulus_files[0]
            self.distractor_stimulus = self.protocol.stimulus_files[1]
            if hasattr(self.protocol, "movie_audio_on"):
                movie_audio_on = self.protocol.movie_audio_on
            else:
                movie_audio_on = True
            #
            self.Stimulus.load_next_stimulus((self.target_stimulus, self.distractor_stimulus),
                                             target_side_left=(self.target_side == 'left'), use_Audio=movie_audio_on)
        #

        self.trial_id += 1
        self.trial_start_time = time.time()
        self.Stimulus.start_stimulus()
        while True:
            # check for responses
            self.response_registered, self.response_side = self.touchscreen.read_touch()

            if self.response_registered:
                # I would just use the actual os time. You can always calculate the difference to the trial start later
                self.response_time = time.time()
                break
            else:
                if time.time() - self.trial_start_time > trial_timeout:
                    # The mouse didn't response in time
                    self.stop_session = True
                    break
                #
            #

            # check for quit (the Esc key)
            if event.getKeys(keyList=["escape"]):
                self.stop_session = True
            #

            # update/flip the window
            self.Stimulus.update()
        #

        # clean up
        self.Stimulus.stop_stimulus()

        # ## end of trial ## #
        if self.response_registered:
            self.correct_response = self.target_side == self.response_side

            # Light punishment:
            if not self.correct_response:
                self.Stimulus.win.color = [1, 1, 1]
                # I don't know why, but I have to update twice for it to take
                self.Stimulus.update()
                self.Stimulus.update()
                core.wait(0.01)
            #

            # I tried to put this in its own class or to predefine the sounds already, but the way the threads and
            # sound work with PsychoPy everything else (Movies) got muted!
            play_auditory_cue(correct=self.correct_response)
            # potentially stop the stimulus

            if not testMode:
                led_on(self.serial_obj)
                # returns True if timeout is reached:
                self.stop_session = lick_detection(self.Stimulus.win, self.serial_obj, rewarded=self.correct_response)
                self.lick_time = time.time()
                led_off(self.serial_obj)
            else:
                self.lick_time = time.time()
            #

        # current trial is over now
        else:
            self.correct_response = None
            self.response_time = None
            self.lick_time = None
        #

        # Reset screen color
        self.Stimulus.win.color = [-0.02, -0.02, -0.02]
        # I need this twice for some reason:
        self.Stimulus.update()
        self.Stimulus.update()

        # # ToDo: Save current trial
        self.trial_variables.update_trial_data(trial_id=self.trial_id,
                                               trial_start_time=self.trial_start_time,
                                               response_time=self.response_time,
                                               lick_time=self.lick_time,
                                               target_side=self.target_side,
                                               response_side=self.response_side,
                                               correct_response=self.correct_response,
                                               target_stimulus=self.target_stimulus,
                                               distractor_stimulus=self.distractor_stimulus)

        # Then:
        self.last_response = self.response_side

        # Now the ITI:
        if not self.stop_session:
            time.sleep(self.protocol.ITI)
        #
    #
#




