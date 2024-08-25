import doctest

# List-of-x is one of:
# - []
# - [x] + List-of-x
# interp. a list of given element
# examples:
lstx1 = [1, 2, 3, 4]
lstx2 = ['a', 'b', 'c', 'd']
# template
"""
def fn_for_lstx(lstx):
    if lstx == []:
        return ...
    else:
        return combinator(lstx[0], lstx[1:])
"""

def find(e: str, lst: list) -> bool:
    """
    find if element e exists in list lst
    >>> find('a', [])
    False
    >>> find('a', ['c', 'd', 'f'])
    False
    >>> find('a', ['a', 'b', 'c'])
    True
    >>> find('a', ['c', 'd', 'f', 'a', 'b', 'c'])
    True
    >>> find('a', ['c', 'd', 'f', 'b', 'a'])
    True
    """
    if lst == []:
        return False
    else:
        return lst[0] == e or find(e, lst[1:])


def sum(lst: list) -> int:
    """
    sum the elements of a list
    >>> sum([])
    0
    >>> sum([1])
    1
    >>> sum([1, 2, 3, 4, 5])
    15
    >>> sum([1, -1, 2, -2, 3])
    3
    """
    if lst == []:
        return 0
    else:
        return lst[0] + sum(lst[1:])


def pos_list(lst: list) -> bool:
    """
    check if all elements of given list are positive numbers
    >>> pos_list([])
    True
    >>> pos_list([1])
    True
    >>> pos_list([1, 2, 3, 4])
    True
    >>> pos_list([1, 2, 3, -4, 5])
    False
    >>> pos_list([-1, -2, -3, -4])
    False
    """
    if lst == []:
        return True
    else:
        return (lst[0] > 0) and pos_list(lst[1:])


def all_true(lst: list) -> bool:
    """
    check if all element of given list are True
    >>> all_true([])
    True
    >>> all_true([True])
    True
    >>> all_true([False])
    False
    >>> all_true([True, True, True])
    True
    >>> all_true([True, True, False, True])
    False
    """
    if lst == []:
        return True
    else:
        return lst[0] and all_true(lst[1:])


def one_true(lst: list) -> bool:
    """
    check if any element of given list is True
    >>> one_true([])
    False
    >>> one_true([True])
    True
    >>> one_true([False])
    False
    >>> one_true([False, False, False, False])
    False
    >>> one_true([False, False, False, True, False])
    True
    """
    if lst == []:
        return False
    else:
        return lst[0] or one_true(lst[1:])


def check_sorted(lst: list) -> bool:
    """
    check if given non empty list is sorted in descending order
    >>> check_sorted([1])
    True
    >>> check_sorted([2, 1])
    True
    >>> check_sorted([1, 2])
    False
    >>> check_sorted([2, 1, 0, -1, -2])
    True
    >>> check_sorted([5, 4, 3, 2, 8, 0])
    False
    """
    if len(lst) == 1:
        return True
    else:
        return (lst[0] > lst[1]) and check_sorted(lst[1:])


def add(a: int, b: int) -> int:
    """
    adds 2 numbers without using +
    >>> add(0, 0)
    0
    >>> add(1, 0)
    1
    >>> add(0, 1)
    1
    >>> add(1, 1)
    2
    >>> add(5, 8)
    13
    >>> add(100, 420)
    520
    """
    if a == 0:
        return b
    else:
        return sum([1, add((a - 1), b)])

def multiply(a: int, b: int) -> int:
    """
    multiplies 2 numbers without using *
    >>> multiply(0, 0)
    0
    >>> multiply(1, 0)
    0
    >>> multiply(0, 1)
    0
    >>> multiply(1, 5)
    5
    >>> multiply(5, 5)
    25
    >>> multiply(10, 30)
    300
    """
    if a == 0:
        return 0
    else:
        if a == 1:
            return b
        else:
            return b + multiply((a - 1), b)


if __name__ == '__main__':
    # multiply(5, 5)
    doctest.testmod()
