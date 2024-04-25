from modules.AuditoryCue import play_auditory_cue
from psychopy import visual, prefs
from psychopy.constants import FINISHED
from multiprocessing import Process
prefs.general['audioLib'] = ['PTB']
prefs.general['audioDevice'] = ['Built-in Output']
from psychopy import sound
import numpy as np
import time
from os import path
from glob import glob


class GeneralStimulusClass:
    # This function is intended to be inherited from in more specific classes: static image, image sequence, movies
    # But I want to define the general syntax for the other classes to overwrite if needed.
    def __init__(self):  # , expInfo):
        # self.expInfo = expInfo

        self.target_stim = None
        self.distractor_stim = None

        # status variable used to make sure that we only try to start the stimulus once
        self.started = False

        # This is the window the stimuli are presented in
        self.open_window()
    #

    def open_window(self):
        # First create the window
        # Depending on the setup we might need to make some changes here / make those settings
        self.win = visual.Window(size=(640, 480), pos=(300, 0), fullscr=False, screen=1, allowGUI=False, allowStencil=False,
                                 monitor='testMonitor', color=[-0.02, -0.02, -0.02], colorSpace='rgb',
                                 blendMode='avg', useFBO=True, multiSample=True, numSamples=16)
        self.update()

        # if 0:
        #     # ToDo: This takes time. Ideally, move this into a config file and make a dedication calibration routine to run
        #     #  this once and just use the result!
        #     self.expInfo['frameRate'] = self.win.getActualFrameRate(nIdentical=1000, nMaxFrames=100000, nWarmUpFrames=100)
        #     print(self.expInfo['frameRate'])
        #     if self.expInfo['frameRate'] != None:
        #         self.frameDur = 1.0 / round(self.expInfo['frameRate'])
        #     else:
        #         self.frameDur = 1.0 / 60.0  # couldn't get a reliable measure so guess
        #     #
        # else:
        #     # I ran this manually now and got 60. This is not the final solution!
        #     self.expInfo['frameRate'] = 60.
        #     self.frameDur = 1.0 / round(self.expInfo['frameRate'])
        # #
    #

    def load_next_stimulus(self, file_paths: tuple, target_side_left: bool):
        # In this function you would set up

        # by default there is no stimulus, so just the empty screen
        pass
    #

    def start_stimulus(self):
        self.started = True
    #

    def stop_stimulus(self):
        self.started = False
    #

    def update(self):
        self.win.flip()
    #
#


class MovieStimuli(GeneralStimulusClass):
    def __init__(self, file_paths=("", "")):
        super().__init__()
    #

    # ## MOVIE SPECIFIC FUNCTIONS ## #
    def load_next_movie(self, target_path, distractor_path, target_side_left=True, noAudio=False, setup_scale=2):
        if target_side_left:
            target_pos = -1
            distractor_pos = 1
        else:
            target_pos = 1
            distractor_pos = -1
        #

        # target_position = target_pos * self.target_stim.size[0] / 2
        # distractor_position = 0
        # if distractor_path is not None:
        #     distractor_position = distractor_pos * self.distractor_stim.size[0] / 2
        # #

        self.target_stim = visual.VlcMovieStim(self.win, target_path, size=(500 / setup_scale, 500 / setup_scale),
                                               pos=(0, 0), noAudio=noAudio, opacity=1., loop=True, autoStart=False)
        if distractor_path is not None:
            self.distractor_stim = visual.VlcMovieStim(self.win, distractor_path, size=(500 / setup_scale, 500 / setup_scale),
                                                       pos=(0, 0), noAudio=True, opacity=1., loop=True, autoStart=False)
        else:
            self.distractor_stim = None
        #

        self.target_stim.noAudio = noAudio
        if self.distractor_stim is not None:
            self.distractor_stim.noAudio = noAudio
        #

        target_position = target_pos * self.target_stim.size[0] / 2
        self.target_stim.setPos([target_position, 0])
        if self.distractor_stim is not None:
            distractor_position = distractor_pos * self.distractor_stim.size[0] / 2
            self.distractor_stim.setPos([distractor_position, 0])
        #
    #

    # ## INHERITED FUNCTIONS ## #
    def load_next_stimulus(self, file_paths: tuple, target_side_left: bool, use_Audio=True):
        # initialize_movies() has to be called first
        # file_paths: paths to the individual movies [TargetMovie, DistractorMovie]
        self.load_next_movie(target_path=file_paths[0], distractor_path=file_paths[1],
                             target_side_left=target_side_left, noAudio=not use_Audio)
    #

    def start_stimulus(self):
        self.target_stim.setAutoDraw(True)
        if self.distractor_stim is not None:
            self.distractor_stim.setAutoDraw(True)
        #
        self.target_stim.play(True)
        if self.distractor_stim is not None:
            self.distractor_stim.play(True)
        #
        self.started = True
    #

    def stop_stimulus(self):
        self.target_stim.stop()
        if self.distractor_stim is not None:
            self.distractor_stim.stop()
        #

        print(self.target_stim)
        self.update()
        self.started = False
    #
#


class DefaultSineWaveGrating(GeneralStimulusClass):
    def __init__(self):
        super().__init__()
        self.frameN = -1

    #

    def load_next_stimulus(self, file_paths):
        # for the default image the "file_paths" is ignored
        self.target_stim = visual.GratingStim(win=self.win, name='grating',
                                              tex=u'sin', mask=None,
                                              ori=0, pos=[0, 0], size=[2, 2], sf=3, phase=0.0,
                                              color=[1, 1, 1], colorSpace='rgb', opacity=1,
                                              texRes=256, interpolate=True, depth=-1.0)
    #

    def start_stimulus(self):
        self.target_stim.setAutoDraw(True)
        if 0:
            # ToDo: This is a placeholder for now
            # keep track of start time/frame for later
            t = self.trialClock.getTime()
            self.target_stim.tStart = t  # underestimates by a little under one frame
            self.target_stim.frameNStart = self.frameN  # exact frame index
        #
    #

    def stop_stimulus(self):
        self.target_stim.setAutoDraw(True)
    #
#


if __name__ == "__main__":
    expInfo = dict()

    stimulus_files = ("", "")
    target_side = 'left'
    if 0:
        stim = GeneralStimulusClass()
    elif 0:
        stim = DefaultSineWaveGrating()
    else:
        rel_path = path.dirname(__file__)
        # stimulus_files = (path.join(rel_path, r"stimulus_files\Target_fast.mp4"), None)
        rel_path = path.split(path.dirname(__file__))[0]
        stimulus_files = (path.join(rel_path, r"stimulus_files\Target_fast.mp4"),
                          path.join(rel_path, r"stimulus_files\example50p.mp4"))
        stim = MovieStimuli(stimulus_files)
    #

    # simulate 3 trials
    for i in range(3):
        if np.mod(i, 2) == 0:
            stim.load_next_stimulus(stimulus_files, target_side_left=(target_side == 'left'))
        else:
            stim.load_next_stimulus(stimulus_files[::-1], target_side_left=(target_side == 'right'))
        #

        stim.start_stimulus()
        startTime = time.time()
        while time.time() - startTime < 6:
            # print(stim.target_stim._filename)
            stim.update()
        #
        stim.stop_stimulus()

        # I tried to put this in its own class or to predefine the sounds already, but the way the threads and sound
        # work with PsychoPy nothing else worked!
        play_auditory_cue(correct=True)
    #

    # time.sleep(2)
    print("Done")
#

