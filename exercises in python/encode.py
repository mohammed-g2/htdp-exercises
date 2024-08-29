import doctest

# Design a program that encodes text files numerically. Each letter in a word should be
# encoded as a numeric three-letter string with a value between 0 and 256.

# list of lists of strings (llos) is one of:
# - [los]
# - [los] + llos
# interp. a representation of a file, where each line is a list of strings (words)
# examples:
llos0 = [[]]
llos1 = [['hello', 'world'], [], ['this', 'is', 'a', 'newline']]
# template:
"""
def fn_for_llos(llos: list) -> ...:
    if llos == []:
        return ...
    else:
        return fn_for_los(llos[0]) ... fn_for_llos(llos[1:])
"""

def encode_word(word: str) -> str:
    """
    encode word
    >>> encode_word('hello')
    '104101108108111'
    """
    if word == '':
        return word
    else:
        return str(ord(word[0])) + encode_word(word[1:])


def encode_line(line: list) -> list:
    """
    encode line, a list of strings
    >>> encode_line([])
    []
    >>> encode_line(['ab', 'a', 'c'])
    ['9798', '97', '99']
    """
    if line == []:
        return line
    else:
        return [encode_word(line[0])] + encode_line(line[1:])


def encode_lines(lines: list) -> list:
    """
    encode lines, a list of lists
    >>> encode_lines([[]])
    [[]]
    >>> encode_lines([['ab', 'a', 'c'], ['d']])
    [['9798', '97', '99'], ['100']]
    """
    if lines == []:
        return lines
    else:
        return [encode_line(lines[0])] + encode_lines(lines[1:])


def collapse_line(lst: list) -> str:
    """
    collapse a list of strings to string
    >>> collapse_line([])
    ''
    >>> collapse_line(['a', 'b', 'c'])
    'abc'
    """
    if lst == []:
        return ''
    else:
        return lst[0] + collapse_line(lst[1:])


def collapse_lines(lst: list) -> str:
    """
    collapse a list of lists of strings to string
    """
    if lst == []:
        return ''
    else:
        if lst[0] == ['']:
            return collapse_line(lst[0]) + '\n' + collapse_lines(lst[1:])
        else:
            return collapse_line(lst[0]) + collapse_lines(lst[1:])


def encode(filename: str) -> str:
    """
    encode file
    """
    with open('ttt.txt', 'r') as f:
        file = []
        for line in f.read().split('\n'):
            file.append([line])
        with open('ttt.encoded', 'a') as f:
            f.write(collapse_lines(encode_lines(file)))


if __name__ == '__main__':
    encode('ttt.txt')
    doctest.testmod()
