import gym
import gym_jumping_task
import importlib
jp = importlib.import_module("jumping_task.jumping-task.jumping_task")
import pygame
from matplotlib import animation
import matplotlib.pyplot as plt

from jumping_task import gym_helpers


def save_frames_as_gif(frames, path='./', filename='gym_animation.gif'):

    #Mess with this to change frame size
    plt.figure(figsize=(frames.shape[1] / 72.0, frames[0].shape[0] / 72.0), dpi=72)

    patch = plt.imshow(frames[0])
    plt.axis('off')

    def animate(i):
        patch.set_data(frames[i])

    anim = animation.FuncAnimation(plt.gcf(), animate, frames = len(frames), interval=50)
    anim.save(path + filename, writer='imagemagick', fps=60)

if __name__ == '__main__':
    env = gym.make('jumping-task-v0')
    env = jp.JumpTaskEnv(scr_w=60, scr_h=60, rendering=True, slow_motion = False)

    env.render()
    score = 0
    env.reset()
    frames = []

    while not env.done:
        action = None
        if env.jumping[0] and env.finish_jump:
            action = 3
        else:
            events = pygame.event.get()
            for event in events:
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_RIGHT:
                        action = 0
                    elif event.key == pygame.K_UP:
                        action = 1
                    elif event.key == pygame.K_LEFT:
                        action = 2
                    elif event.key == pygame.K_e:
                        env.exit()
                    else:
                        action = 'unknown'
        if action is None:
            continue
        elif action == 'unknown':
            print('We did not recognize that action. Please use the arrows to move the agent or the \'e\' key to exit.')
            continue
        _, r, term, _ = env.step(action)
        image = env.render()
        filename = "Frame_" + str(env.agent_pos_x) + ".png"
        #image.save(env.screen, filename)
        score += r
        print('Agent position: {:2d} | Reward: {:2d} | Terminal: {}'.format(env.agent_pos_x, r, term))
    print('---------------')
    print('Final score: {:2d}'.format(int(score)))
    print('---------------')


