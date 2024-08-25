import sys
import pygame
import random

pygame.init()
pygame.font.init()
FONT = pygame.font.SysFont('Comic Sans MS', 30)

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
state = {
    'tank': {
        'x' : WIDTH / 2,
        'y': HEIGHT - 40,
        'width': 40,
        'height': 40
    },
    'invaders': [],
    'missiles': [],
    'clock': None
}

clock = pygame.time.Clock()
clock.tick(FPS)

start_time = pygame.time.get_ticks()


def init():
    state['clock'] = clock
    return clock


def render_tank(tank: dict, surface: pygame.Surface):
    tank = pygame.Rect(tank['x'], tank['y'], tank['width'], tank['height'])
    pygame.draw.rect(surface, GREEN, tank)

def render_missile(missile: dict, surface: pygame.Surface):
    missile = pygame.Rect(missile['x'], missile['y'], 10, 20)
    pygame.draw.rect(surface, GRAY, missile)

def render_missiles(missiles: list, surface: pygame.Surface):
    if missiles == []:
        return
    else:
        render_missile(missiles[0], surface) 
        return render_missiles(missiles[1:], surface)

def render_invader(invader: dict, surface: pygame.Surface):
    invader = pygame.Rect(invader['x'], invader['y'], 40, 20)
    pygame.draw.rect(surface, RED, invader)

def render_invaders(invaders: list, surface):
    if invaders == []:
        return
    else:
        render_invader(invaders[0], surface)
        render_invaders(invaders[1:], surface)

def render_fps(state: dict, surface: pygame.Surface):
    font_surf = FONT.render(f'FPS: {state['clock'].get_fps()}', False, BLACK)
    surface.blit(font_surf, (0, 0))

def render(state: dict, surface: pygame.Surface) -> dict:
    surface.fill(WHITE)
    render_fps(state, surface)
    render_tank(state['tank'], surface)
    render_invaders(state['invaders'], surface)
    render_missiles(state['missiles'], surface)
    return state


def move_missiles(missiles: list):
    if missiles == []:
        return
    else:
        missiles[0]['y'] -= 0.2
        move_missiles(missiles[1:])

def remove_missile(missiles: list):
    if missiles == []:
        return
    else:
        if missiles[0]['y'] < 0:
            missiles.remove(missiles[0])
        remove_missile(missiles[1:])

def remove_invaders(invaders: list):
    if invaders == []:
        return
    else:
        if invaders[0]['y'] > HEIGHT:
            invaders.remove(invaders[0])
        remove_invaders(invaders[1:])

def remove(state: dict):
    remove_missile(state['missiles'])
    remove_invaders(state['invaders'])

def spawn_invaders(invaders: list):
    now = pygame.time.get_ticks()
    global start_time
    if now - start_time > 2000:
        start_time = now
        invaders.append({
        'x': random.choice([20, WIDTH - 50]),
        'y': -20})

def move_invader(invader: dict):
    if invader['x'] < 0:
        invader['x'] = random.randrange(3)
    elif invader['x'] > WIDTH:
        invader['x'] = random.choice([WIDTH - 40, WIDTH - 20])
    else:
        invader['x'] += random.choice([-1, 1])
    invader['y'] += 0.09

def move_invaders(invaders: list):
    if invaders == []:
        return
    else:
        move_invader(invaders[0])
        move_invaders(invaders[1:])

def check_collision(invaders: list, missiles: list):
    if invaders == []:
        return
    else:
        if invaders[0].collidepoint(missiles):
            remove_invaders(invaders)
            remove_missile(missiles)
        check_collision(invaders[1:], missiles)

def update(state: dict) -> dict:
    move_missiles(state['missiles'])
    spawn_invaders(state['invaders'])
    move_invaders(state['invaders'])
    # check_collision(state['invaders'], state['missiles'])
    remove(state)

    return state


def handle_events(state: dict, event: pygame.event.Event) -> bool:
    if event.type == pygame.QUIT:
        return False
    elif event.type == pygame.KEYDOWN:
        if event.key == pygame.K_SPACE:
            state['missiles'].append({
                'x': state['tank']['x'] + ((state['tank']['width'] / 2) - 5),
                'y': state['tank']['y']})
    return True

def handle_key_press(state: dict, keys: dict):
    if keys[pygame.K_LEFT]:
        if state['tank']['x'] >= 0: 
            state['tank']['x'] -= SPEED
    elif keys[pygame.K_RIGHT]:
        if state['tank']['x'] <= WIDTH - state['tank']['width']:
            state['tank']['x'] += SPEED


def end_game(state: dict) -> bool:
    return False


def run(state: dict):
    init()
    running = True
    while running:
        render(state, SURF)
        state['clock'].tick() # get fps reading
        update(state)
        for event in pygame.event.get():
            running = handle_events(state, event)
        keys = pygame.key.get_pressed()
        handle_key_press(state, keys)
        if end_game(state):
            running = False
        pygame.display.flip()
    print({
        'x': state['tank']['x'], 
        'y': state['tank']['y'],
        'missiles': len(state['missiles']),
        'invaders': len(state['invaders'])})
    pygame.quit()
    sys.exit()    


if __name__ == '__main__':
    run(state)
