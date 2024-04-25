from psychopy import event


class TouchscreenInput:
    def __init__(self, win, inverted_screen=False):
        if win is not None:
            self.win = win  # Psychopy stimulus window
            self.mouse = event.Mouse(win=self.win, visible=False)
            self.x, self.y = [None, None]  # Currently only the x position of a touch is used to distinguish left/right
            self.inverted_screen = inverted_screen  # In case the monitor had to be inverted left/right would be switched
        #
    #

    def reset(self):
        # The mouse position has to be reset at the beginning of a new trial so the next response can be read properly
        self.mouse.setPos((0, 0))
    #

    def read_touch(self):
        self.x, self.y = self.mouse.getPos()

        # Currently only the x position of a touch is used to distinguish left/right
        response_registered = not (self.x == 0)
        response = ''
        if response_registered:
            if self.x < 0:
                response = 'left'
            elif self.x > 0:
                response = 'right'
            #

            if self.inverted_screen:
                if response == 'left':
                    response = 'right'
                elif response == 'right':
                    response = 'left'
                #
            #
        #

        return response_registered, response
    #
#
