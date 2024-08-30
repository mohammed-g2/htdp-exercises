import doctest

def insert(n: int, lst: list) -> list:
    """
    insert given number in given ordered list
    >>> insert(1, [])
    [1]
    >>> insert(2, [1])
    [2, 1]
    >>> insert(5, [7, 6, 4, 3])
    [7, 6, 5, 4, 3]
    >>> insert(5, [4, 3, 2])
    [5, 4, 3, 2]
    >>> insert(8, [9, 8, 4, 1])
    [9, 8, 8, 4, 1]
    """
    if lst == []:
        return [n]
    else:
        if n >= lst[0]:
            return [n] + lst
        else:
            return [lst[0]] + insert(n, lst[1:])


def sort(lst: list) -> list:
    """
    sort a list of numbers in a descending order where (n1 > n2 > ... n)
    >>> sort([1])
    [1]
    >>> sort([3, 2, 1])
    [3, 2, 1]
    >>> sort([8, 7, 2, 4, 9, 1, 7])
    [9, 8, 7, 7, 4, 2, 1]
    """
    if lst == []:
        return lst
    else:
        return insert(lst[0], sort(lst[1:]))


def is_sorted(lst: list) -> bool:
    """
    check if given non empty list is sorted in the right order
    >>> is_sorted([1])
    True
    >>> is_sorted([1, 2, 3])
    False
    >>> is_sorted([3, 2, 1, -5])
    True
    >>> is_sorted([5, 4, 3, 2, 8, 0])
    False
    """
    if len(lst) == 1:
        return True
    else:
        if lst[0] > lst[1]:
            return is_sorted(lst[1:])
        else:
            return False
        

def search_sorted(n: int, lst: list) -> bool:
    """
    check if given number exists in given non empty sorted list (binary search)
    >>> search_sorted(5, [1])
    False
    >>> search_sorted(5, [9, 8, 6, 4, 2])
    False
    >>> search_sorted(5, [9, 8, 6, 5, 2])
    True
    >>> search_sorted(2, [9, 8, 6, 5, 2])
    True
    """
    if len(lst) == 1 and lst[0] != n:
        return False
    else:
        if lst[len(lst) // 2] == n:
            return True
        elif lst[len(lst) // 2] > n:
            return search_sorted(n, lst[len(lst) // 2:])
        elif lst[len(lst) // 2] < n:
            return search_sorted(n, lst[:len(lst) // 2])


if __name__ == '__main__':
    doctest.testmod()