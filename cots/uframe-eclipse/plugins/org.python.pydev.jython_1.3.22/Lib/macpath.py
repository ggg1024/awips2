"""Pathname and path-related operations for the Macintosh."""

import os
from stat import *

__all__ = ["normcase","isabs","join","splitdrive","split","splitext",
           "basename","dirname","commonprefix","getsize","getmtime",
           "getatime","islink","exists","isdir","isfile",
           "walk","expanduser","expandvars","normpath","abspath"]

# Normalize the case of a pathname.  Dummy in Posix, but <s>.lower() here.

def normcase(path):
    return path.lower()


def isabs(s):
    """Return true if a path is absolute.
    On the Mac, relative paths begin with a colon,
    but as a special case, paths with no colons at all are also relative.
    Anything else is absolute (the string up to the first colon is the
    volume name)."""

    return ':' in s and s[0] != ':'


def join(s, *p):
    path = s
    for t in p:
        if (not s) or isabs(t):
            path = t
            continue
        if t[:1] == ':':
            t = t[1:]
        if ':' not in path:
            path = ':' + path
        if path[-1:] != ':':
            path = path + ':'
        path = path + t
    return path


def split(s):
    """Split a pathname into two parts: the directory leading up to the final
    bit, and the basename (the filename, without colons, in that directory).
    The result (s, t) is such that join(s, t) yields the original argument."""

    if ':' not in s: return '', s
    colon = 0
    for i in range(len(s)):
        if s[i] == ':': colon = i + 1
    path, file = s[:colon-1], s[colon:]
    if path and not ':' in path:
        path = path + ':'
    return path, file


def splitext(p):
    """Split a path into root and extension.
    The extension is everything starting at the last dot in the last
    pathname component; the root is everything before that.
    It is always true that root + ext == p."""

    root, ext = '', ''
    for c in p:
        if c == ':':
            root, ext = root + ext + c, ''
        elif c == '.':
            if ext:
                root, ext = root + ext, c
            else:
                ext = c
        elif ext:
            ext = ext + c
        else:
            root = root + c
    return root, ext


def splitdrive(p):
    """Split a pathname into a drive specification and the rest of the
    path.  Useful on DOS/Windows/NT; on the Mac, the drive is always
    empty (don't use the volume name -- it doesn't have the same
    syntactic and semantic oddities as DOS drive letters, such as there
    being a separate current directory per drive)."""

    return '', p


# Short interfaces to split()

def dirname(s): return split(s)[0]
def basename(s): return split(s)[1]


def isdir(s):
    """Return true if the pathname refers to an existing directory."""

    try:
        st = os.stat(s)
    except os.error:
        return 0
    return S_ISDIR(st[ST_MODE])


# Get size, mtime, atime of files.

def getsize(filename):
    """Return the size of a file, reported by os.stat()."""
    st = os.stat(filename)
    return st[ST_SIZE]

def getmtime(filename):
    """Return the last modification time of a file, reported by os.stat()."""
    st = os.stat(filename)
    return st[ST_MTIME]

def getatime(filename):
    """Return the last access time of a file, reported by os.stat()."""
    st = os.stat(filename)
    return st[ST_ATIME]


def islink(s):
    """Return true if the pathname refers to a symbolic link.
    Always false on the Mac, until we understand Aliases.)"""

    return 0


def isfile(s):
    """Return true if the pathname refers to an existing regular file."""

    try:
        st = os.stat(s)
    except os.error:
        return 0
    return S_ISREG(st[ST_MODE])


def exists(s):
    """Return true if the pathname refers to an existing file or directory."""

    try:
        st = os.stat(s)
    except os.error:
        return 0
    return 1

# Return the longest prefix of all list elements.

def commonprefix(m):
    "Given a list of pathnames, returns the longest common leading component"
    if not m: return ''
    prefix = m[0]
    for item in m:
        for i in range(len(prefix)):
            if prefix[:i+1] != item[:i+1]:
                prefix = prefix[:i]
                if i == 0: return ''
                break
    return prefix

def expandvars(path):
    """Dummy to retain interface-compatibility with other operating systems."""
    return path


def expanduser(path):
    """Dummy to retain interface-compatibility with other operating systems."""
    return path

norm_error = 'macpath.norm_error: path cannot be normalized'

def normpath(s):
    """Normalize a pathname.  Will return the same result for
    equivalent paths."""

    if ":" not in s:
        return ":"+s

    comps = s.split(":")
    i = 1
    while i < len(comps)-1:
        if comps[i] == "" and comps[i-1] != "":
            if i > 1:
                del comps[i-1:i+1]
                i = i - 1
            else:
                # best way to handle this is to raise an exception
                raise norm_error, 'Cannot use :: immedeately after volume name'
        else:
            i = i + 1

    s = ":".join(comps)

    # remove trailing ":" except for ":" and "Volume:"
    if s[-1] == ":" and len(comps) > 2 and s != ":"*len(s):
        s = s[:-1]
    return s


def walk(top, func, arg):
    """Directory tree walk.
    For each directory under top (including top itself),
    func(arg, dirname, filenames) is called, where
    dirname is the name of the directory and filenames is the list
    of files (and subdirectories etc.) in the directory.
    The func may modify the filenames list, to implement a filter,
    or to impose a different order of visiting."""

    try:
        names = os.listdir(top)
    except os.error:
        return
    func(arg, top, names)
    for name in names:
        name = join(top, name)
        if isdir(name):
            walk(name, func, arg)


def abspath(path):
    """Return an absolute path."""
    if not isabs(path):
        path = join(os.getcwd(), path)
    return normpath(path)
