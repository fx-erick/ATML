from gym.envs.registration import register
from gym_jumping_task.envs import OBSTACLE_COLORS

register(
    id='jumping-task-v0',
    entry_point='gym_jumping_task.envs:JumpTaskEnv',
)

register(
    id='jumping-colors-task-v0',
    entry_point='gym_jumping_task.envs:JumpTaskEnvWithColors',
    max_episode_steps=600
)