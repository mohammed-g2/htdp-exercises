import doctest
from typing import List

# wc
# count the number of 1strings, words, and lines in a given file


def count_line_characters(line: List[str]) -> int:
    """
    count the number of characters in a line
    >>> count_line_characters([])
    0
    >>> count_line_characters(['', ' '])
    1
    >>> count_line_characters(['hello', 'world'])
    10
    """
    if line == []:
        return 0
    else:
        return len(line[0]) + count_line_characters(line[1:])


def count_characters(file: List[List[str]]) -> int:
    """
    count the number of characters in given file (list of lists of strings)
    count_characters([[]])
    0
    >>> count_characters([['a', 'b', 'cd'], ['f'], ['gh']])
    7
    """
    if file == []:
        return 0
    else:
        return count_line_characters(file[0]) + count_characters(file[1:])


def count_line_words(line: List[str]) -> int:
    """
    count words in list, skips empty strings
    """
    if line == []:
        return 0
    else:
        if line[0] == '':
            return count_line_words(line[1:])
        return 1 + count_line_words(line[1:])


def count_words(file: List[List[str]]) -> int:
    """
    count the number of words in file
    >>> count_words([[]])
    0
    >>> count_words([['ab cd ef'], ['d'], ['gf'], ['c']])
    6
    """
    if len(file) == 0:
        return 0
    else:
        if file[0] == [''] or file[0] == [' '] or file[0] == []:
            return count_words(file[1:])
        return count_line_words(file[0][0].split(' ')) + count_words(file[1:])


def count_lines(file: List[List[str]]) -> int:
    """
    count the number of lines in given file
    """
    pass


def wc(filename: str) -> dict:
    with open(filename, 'r') as f:
        file = []
        for line in f.read().split('\n'):
            file.append([line])
        return {
            'Characters': count_characters(file),
            'Words': count_words(file),
            'Lines': len(file)}


if __name__ == '__main__':
    print(wc('ttt.txt'))
    doctest.testmod()
