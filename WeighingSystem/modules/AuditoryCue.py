# from psychopy import prefs
# prefs.general['audioLib'] = ['PTB']
# prefs.general['audioDevice'] = ['Built-in Output']
from psychopy import sound
from multiprocessing import Process
from psychopy import core


def _play_cue(correct=True):
    if correct:
        # Correct response Cue
        auditory_cue = sound.backend_ptb.SoundPTB(value='c', secs=0.2, octave=4, stereo=True, volume=1.0, loops=0,
                                                  sampleRate=44100, hamming=True, name='Correct', autoLog=True)
        auditory_cue.play()
        # time.sleep(0.3)
        core.wait(0.2 + 0.05)
    else:
        # Error Cue
        auditory_cue = sound.backend_ptb.SoundPTB(value='d', secs=0.5, octave=8, stereo=True, volume=1.0, loops=0,
                                                  sampleRate=44100, hamming=True, name='Error', autoLog=True)
        auditory_cue.play()
        core.wait(0.5 + 0.05)
    #
    auditory_cue.stop()
#


def play_auditory_cue(correct=True):
    p = Process(target=_play_cue, args=(correct,))
    p.start()
    p.join()
#



# THIS WAS A FAILED ATTEMPT TO MAKE IT NICER:
# The Only alternative I see right now is to either have a microcontroller play the sound or make it a seperate python
# script and send a signal byte using UDP, similar to our VisualStimulus Server/Client.

# def _play_cue(correct_cue, error_cue, correct=True):
#     if correct:
#         correct_cue.play()
#         time.sleep(0.3)
#         correct_cue.pause()
#     else:
#         # Error Cue
#         error_cue.play()
#         time.sleep(0.5)
#         error_cue.pause()
#     #
# #
#
#
# class AuditoryCue:
#     def __init__(self):
#         self.correct_cue = sound.backend_ptb.SoundPTB(value='c', secs=0.2, octave=4, stereo=True, volume=1.0, loops=0,
#                                                       sampleRate=44100, hamming=True, name='Correct', autoLog=True)
#         # self.correct_cue.pause()
#         self.error_cue = sound.backend_ptb.SoundPTB(value='c', secs=0.2, octave=4, stereo=True, volume=1.0, loops=0,
#                                                     sampleRate=44100, hamming=True, name='Correct', autoLog=True)
#         # self.error_cue.pause()
#     #
#
#     def play_auditory_cue(self, correct=True):
#         self.correct_cue.play()
#         # # p = Process(target=_play_cue, args=(self.correct_cue, self.error_cue, correct,))
#         # p = Process(target=self.correct_cue.play, args=())
#         # p.start()
#         # p.join()
#     #
# #
#
# aud_cue = AuditoryCue()
# aud_cue.play_auditory_cue()
# time.sleep(2)
#
