import sys
import pygame
import random

pygame.init()
pygame.font.init()

BLACK = pygame.Color(0, 0, 0)
WHITE = pygame.Color(255, 255, 255)
GRAY = pygame.Color(128, 128, 128)
RED = pygame.Color(255, 0, 0)
GREEN = pygame.Color(0, 255, 0)
BLUE = pygame.Color(0, 0, 255)

WIDTH = 400
HEIGHT = 500
FPS = 24
SPEED = 0.09

SURF = pygame.display.set_mode((WIDTH, HEIGHT))
FONT = pygame.font.SysFont('Roman Times', 22)

clock = pygame.time.Clock()
clock.tick(FPS)

state = {
    'x': 100,
    'y': 100,
    'w': 20,
    'h': 20,
    'segments': 1,
    'score': 0,
    'food': []
}

def render_snake(state: dict, surface: pygame.Surface):
    snake = pygame.Rect(state['x'], state['y'], state['w'], state['h'])
    pygame.draw.rect(surface, RED, snake)


def render(state: dict, surface: pygame.Surface):
    surface.fill(WHITE)
    render_snake(state, surface)


def update(state: dict):
    pass


def handle_events(state: dict, event: pygame.event.Event):
    pass


def handle_key_press(state: dict, keys):
    if keys[pygame.K_LEFT]:
        state['x'] -= SPEED
    if keys[pygame.K_RIGHT]:
        state['x'] += SPEED
    if keys[pygame.K_UP]:
        state['y'] -= SPEED
    if keys[pygame.K_DOWN]:
        state['y'] += SPEED


def game_over(state: dict) -> bool:
    return False


def run(state: dict):
    running = True
    while running:
        render(state, SURF)
        update(state)
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            handle_events(state, event)
        keys = pygame.key.get_pressed()
        handle_key_press(state, keys)
        if game_over(state):
            running = False
        pygame.display.flip()
    print({
        'x': state['x'], 
        'y': state['y']})
    pygame.quit()
    sys.exit()


if __name__ == '__main__':
    run(state)