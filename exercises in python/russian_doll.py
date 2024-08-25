import doctest

# RD (russian doll) is one of:
# - String
# - {'color': String, 'doll': RD}
# interp. representation of a russian doll
# examples
rd0 = 'red'
rd1 = {'color': 'green', 'doll': 'red'}
rd2 = {'color': 'yellow', 'doll': {'color': 'green', 'doll': 'red'}}
rd3 = {'color': 'black', 'doll': rd2}
# template
"""
def fn_for_rd(rd: dict) -> ?:
    if type(rd) == str:
        return ...
    else:
        return ... rd['color'] ... fn_for_rd(rd['doll'])
"""

def depth(rd: dict) -> int:
    """
    returns the depth of a russian doll
    >>> depth(rd0)
    1
    >>> depth(rd1)
    2
    >>> depth(rd2)
    3
    >>> depth(rd3)
    4
    """
    if type(rd) == str:
        return 1
    else:
        return depth(rd['doll']) + 1


def color(rd: dict) -> str:
    """
    produces a string of all colors, separated by a comma and a space
    >>> color(rd0)
    'red'
    >>> color(rd1)
    'green, red'
    >>> color(rd2)
    'yellow, green, red'
    >>> color(rd3)
    'black, yellow, green, red'
    """
    if type(rd) == str:
        return rd
    else:
        return rd['color'] + ', ' + color(rd['doll'])


def inner(rd: dict) -> str:
    """
    produces the color of the innermost doll
    >>> inner(rd0)
    'red'
    >>> inner(rd1)
    'red'
    >>> inner(rd2)
    'red'
    >>> inner(rd3)
    'red'
    """
    if type(rd) == str:
        return rd
    else:
        return inner(rd['doll'])


if __name__ == '__main__':
    doctest.testmod()
