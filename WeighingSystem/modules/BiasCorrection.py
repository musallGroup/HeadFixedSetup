import numpy as np


class BiasCorrection:
    def __init__(self):
        self.current_trial_id = 0
        self.last_response = ''
        self._history_left_responses = []
        self._history_right_responses = []
        self._history_same_responses = []
        self._history_opposite_responses = []
    #

    def get_next_target_side(self, response):
        # update _history
        self._history_left_responses.append(response == 'left')
        self._history_right_responses.append(response == 'right')
        self._history_same_responses.append(response == self.last_response)
        self._history_opposite_responses.append(response != self.last_response)

        if self.current_trial_id > 9:
            # update _history to only keep the last 10 entries
            self._history_left_responses = self._history_left_responses[-10:]
            self._history_right_responses = self._history_right_responses[-10:]
            self._history_same_responses = self._history_same_responses[-10:]
            self._history_opposite_responses = self._history_opposite_responses[-10:]
        #

        # side bias correction
        target_side_str = ['left', 'right']
        target_side_left = True
        next_target_side = ''
        if self.current_trial_id < 10:
            # random until we have enough trials to use the bias correction
            next_target_side = target_side_str[np.random.rand() < 0.5]
        else:
            # Use Bias-correction
            n_left = np.sum(self._history_left_responses)
            n_right = np.sum(self._history_right_responses)
            n_same = np.sum(self._history_same_responses)
            n_opposite = np.sum(self._history_opposite_responses)
            if np.abs(n_left - n_right) == np.abs(n_same - n_opposite):
                # no bias -> random
                next_target_side = target_side_str[np.random.rand() < 0.5]
            elif np.abs(n_left - n_right) > np.abs(n_same - n_opposite):
                # animal prefers one side
                if n_left > n_right:
                    next_target_side = 'right'
                else:
                    next_target_side = 'left'
                #
            elif np.abs(n_left - n_right) < np.abs(n_same - n_opposite):
                if n_same < n_opposite:
                    # If the animal alternates responses -> repeat same side
                    next_target_side = self.last_response
                else:  # n_same > n_opposite
                    # animal repeat same side -> opposite
                    if self.last_response == 'left':
                        next_target_side = 'right'
                    elif self.last_response == 'right':
                        next_target_side = 'left'
                    #
                #
            #
        #

        # now set this as the last-response for the next trial
        self.last_response = response
        self.current_trial_id += 1
        
        return next_target_side
    #
#


if __name__ == "__main__":
    bias_correction = BiasCorrection()

    for i in range(30):
        if np.random.rand() < 0:  # 0.5:
            resp = 'left'
        else:
            resp = 'right'
        #

        next_target = bias_correction.get_next_target_side(resp)

        print(i, resp, next_target,
              np.sum(bias_correction._history_left_responses),
              np.sum(bias_correction._history_right_responses),
              np.sum(bias_correction._history_same_responses),
              np.sum(bias_correction._history_opposite_responses))
    #
#
