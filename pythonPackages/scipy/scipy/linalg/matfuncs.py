#
# Author: Travis Oliphant, March 2002
#

<<<<<<< HEAD
__all__ = ['expm','expm2','expm3','cosm','sinm','tanm','coshm','sinhm',
           'tanhm','logm','funm','signm','sqrtm']

from numpy import asarray, Inf, dot, floor, eye, diag, exp, \
     product, logical_not, ravel, transpose, conjugate, \
     cast, log, ogrid, imag, real, absolute, amax, sign, \
     isfinite, sqrt, identity, single
from numpy import matrix as mat
import numpy as np

# Local imports
from misc import norm
from basic import solve, inv
from special_matrices import triu, all_mat
from decomp import eig
from decomp_svd import orth, svd
from decomp_schur import schur, rsf2csf
=======
from __future__ import division, print_function, absolute_import

__all__ = ['expm','expm2','expm3','cosm','sinm','tanm','coshm','sinhm',
           'tanhm','logm','funm','signm','sqrtm',
           'expm_frechet', 'expm_cond', 'fractional_matrix_power']

from numpy import (Inf, dot, diag, exp, product, logical_not, cast, ravel,
        transpose, conjugate, absolute, amax, sign, isfinite, sqrt, single)
import numpy as np
import warnings

# Local imports
from .misc import norm
from .basic import solve, inv
from .special_matrices import triu
from .decomp import eig
from .decomp_svd import svd
from .decomp_schur import schur, rsf2csf
from ._expm_frechet import expm_frechet, expm_cond
from ._matfuncs_sqrtm import sqrtm
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

eps = np.finfo(float).eps
feps = np.finfo(single).eps

<<<<<<< HEAD
def expm(A, q=7):
    """Compute the matrix exponential using Pade approximation.

    Parameters
    ----------
    A : array, shape(M,M)
        Matrix to be exponentiated
    q : integer
        Order of the Pade approximation

    Returns
    -------
    expA : array, shape(M,M)
        Matrix exponential of A

    """
    A = asarray(A)

    # Scale A so that norm is < 1/2
    nA = norm(A,Inf)
    if nA==0:
        return identity(len(A), A.dtype.char)
    from numpy import log2
    val = log2(nA)
    e = int(floor(val))
    j = max(0,e+1)
    A = A / 2.0**j

    # Pade Approximation for exp(A)
    X = A
    c = 1.0/2
    N = eye(*A.shape) + c*A
    D = eye(*A.shape) - c*A
    for k in range(2,q+1):
        c = c * (q-k+1) / (k*(2*q-k+1))
        X = dot(A,X)
        cX = c*X
        N = N + cX
        if not k % 2:
            D = D + cX;
        else:
            D = D - cX;
    F = solve(D,N)
    for k in range(1,j+1):
        F = dot(F,F)
    return F

def expm2(A):
    """Compute the matrix exponential using eigenvalue decomposition.

    Parameters
    ----------
    A : array, shape(M,M)
=======
_array_precision = {'i': 1, 'l': 1, 'f': 0, 'd': 1, 'F': 0, 'D': 1}


###############################################################################
# Utility functions.


def _asarray_square(A):
    """
    Wraps asarray with the extra requirement that the input be a square matrix.

    The motivation is that the matfuncs module has real functions that have
    been lifted to square matrix functions.

    Parameters
    ----------
    A : array_like
        A square matrix.

    Returns
    -------
    out : ndarray
        An ndarray copy or view or other representation of A.

    """
    A = np.asarray(A)
    if len(A.shape) != 2 or A.shape[0] != A.shape[1]:
        raise ValueError('expected square array_like input')
    return A


def _maybe_real(A, B, tol=None):
    """
    Return either B or the real part of B, depending on properties of A and B.

    The motivation is that B has been computed as a complicated function of A,
    and B may be perturbed by negligible imaginary components.
    If A is real and B is complex with small imaginary components,
    then return a real copy of B.  The assumption in that case would be that
    the imaginary components of B are numerical artifacts.

    Parameters
    ----------
    A : ndarray
        Input array whose type is to be checked as real vs. complex.
    B : ndarray
        Array to be returned, possibly without its imaginary part.
    tol : float
        Absolute tolerance.

    Returns
    -------
    out : real or complex array
        Either the input array B or only the real part of the input array B.

    """
    # Note that booleans and integers compare as real.
    if np.isrealobj(A) and np.iscomplexobj(B):
        if tol is None:
            tol = {0:feps*1e3, 1:eps*1e6}[_array_precision[B.dtype.char]]
        if np.allclose(B.imag, 0.0, atol=tol):
            B = B.real
    return B


###############################################################################
# Matrix functions.


def fractional_matrix_power(A, t):
    """
    Compute the fractional power of a matrix.

    Proceeds according to the discussion in section (6) of [1]_.

    Parameters
    ----------
    A : (N, N) array_like
        Matrix whose fractional power to evaluate.
    t : float
        Fractional power.

    Returns
    -------
    X : (N, N) array_like
        The fractional power of the matrix.

    References
    ----------
    .. [1] Nicholas J. Higham and Lijing lin (2011)
           "A Schur-Pade Algorithm for Fractional Powers of a Matrix."
           SIAM Journal on Matrix Analysis and Applications,
           32 (3). pp. 1056-1078. ISSN 0895-4798

    Examples
    --------
    >>> from scipy.linalg import fractional_matrix_power
    >>> a = np.array([[1.0, 3.0], [1.0, 4.0]])
    >>> b = fractional_matrix_power(a, 0.5)
    >>> b
    array([[ 0.75592895,  1.13389342],
           [ 0.37796447,  1.88982237]])
    >>> np.dot(b, b)      # Verify square root
    array([[ 1.,  3.],
           [ 1.,  4.]])

    """
    # This fixes some issue with imports;
    # this function calls onenormest which is in scipy.sparse.
    A = _asarray_square(A)
    import scipy.linalg._matfuncs_inv_ssq
    return scipy.linalg._matfuncs_inv_ssq._fractional_matrix_power(A, t)


def logm(A, disp=True):
    """
    Compute matrix logarithm.

    The matrix logarithm is the inverse of
    expm: expm(logm(`A`)) == `A`

    Parameters
    ----------
    A : (N, N) array_like
        Matrix whose logarithm to evaluate
    disp : bool, optional
        Print warning if error in the result is estimated large
        instead of returning estimated error. (Default: True)

    Returns
    -------
    logm : (N, N) ndarray
        Matrix logarithm of `A`
    errest : float
        (if disp == False)

        1-norm of the estimated error, ||err||_1 / ||A||_1

    References
    ----------
    .. [1] Awad H. Al-Mohy and Nicholas J. Higham (2012)
           "Improved Inverse Scaling and Squaring Algorithms
           for the Matrix Logarithm."
           SIAM Journal on Scientific Computing, 34 (4). C152-C169.
           ISSN 1095-7197

    .. [2] Nicholas J. Higham (2008)
           "Functions of Matrices: Theory and Computation"
           ISBN 978-0-898716-46-7

    .. [3] Nicholas J. Higham and Lijing lin (2011)
           "A Schur-Pade Algorithm for Fractional Powers of a Matrix."
           SIAM Journal on Matrix Analysis and Applications,
           32 (3). pp. 1056-1078. ISSN 0895-4798

    Examples
    --------
    >>> from scipy.linalg import logm, expm
    >>> a = np.array([[1.0, 3.0], [1.0, 4.0]])
    >>> b = logm(a)
    >>> b
    array([[-1.02571087,  2.05142174],
           [ 0.68380725,  1.02571087]])
    >>> expm(b)         # Verify expm(logm(a)) returns a
    array([[ 1.,  3.],
           [ 1.,  4.]])

    """
    A = _asarray_square(A)
    # Avoid circular import ... this is OK, right?
    import scipy.linalg._matfuncs_inv_ssq
    F = scipy.linalg._matfuncs_inv_ssq._logm(A)
    errtol = 1000*eps
    #TODO use a better error approximation
    errest = norm(expm(F)-A,1) / norm(A,1)
    if disp:
        if not isfinite(errest) or errest >= errtol:
            print("logm result may be inaccurate, approximate err =", errest)
        return F
    else:
        return F, errest


def expm(A, q=None):
    """
    Compute the matrix exponential using Pade approximation.

    Parameters
    ----------
    A : (N, N) array_like or sparse matrix
        Matrix to be exponentiated.

    Returns
    -------
    expm : (N, N) ndarray
        Matrix exponential of `A`.

    References
    ----------
    .. [1] Awad H. Al-Mohy and Nicholas J. Higham (2009)
           "A New Scaling and Squaring Algorithm for the Matrix Exponential."
           SIAM Journal on Matrix Analysis and Applications.
           31 (3). pp. 970-989. ISSN 1095-7162

    Examples
    --------
    >>> from scipy.linalg import expm, sinm, cosm

    Matrix version of the formula exp(0) = 1:

    >>> expm(np.zeros((2,2)))
    array([[ 1.,  0.],
           [ 0.,  1.]])

    Euler's identity (exp(i*theta) = cos(theta) + i*sin(theta))
    applied to a matrix:

    >>> a = np.array([[1.0, 2.0], [-1.0, 3.0]])
    >>> expm(1j*a)
    array([[ 0.42645930+1.89217551j, -2.13721484-0.97811252j],
           [ 1.06860742+0.48905626j, -1.71075555+0.91406299j]])
    >>> cosm(a) + 1j*sinm(a)
    array([[ 0.42645930+1.89217551j, -2.13721484-0.97811252j],
           [ 1.06860742+0.48905626j, -1.71075555+0.91406299j]])

    """
    if q is not None:
        msg = "argument q=... in scipy.linalg.expm is deprecated." 
        warnings.warn(msg, DeprecationWarning)
    # Input checking and conversion is provided by sparse.linalg.expm().
    import scipy.sparse.linalg
    return scipy.sparse.linalg.expm(A)


# deprecated, but probably should be left there in the long term
@np.deprecate(new_name="expm")
def expm2(A):
    """
    Compute the matrix exponential using eigenvalue decomposition.

    Parameters
    ----------
    A : (N, N) array_like
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
        Matrix to be exponentiated

    Returns
    -------
<<<<<<< HEAD
    expA : array, shape(M,M)
        Matrix exponential of A

    """
    A = asarray(A)
=======
    expm2 : (N, N) ndarray
        Matrix exponential of `A`

    """
    A = _asarray_square(A)
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
    t = A.dtype.char
    if t not in ['f','F','d','D']:
        A = A.astype('d')
        t = 'd'
<<<<<<< HEAD
    s,vr = eig(A)
    vri = inv(vr)
    return dot(dot(vr,diag(exp(s))),vri).astype(t)

def expm3(A, q=20):
    """Compute the matrix exponential using Taylor series.

    Parameters
    ----------
    A : array, shape(M,M)
        Matrix to be exponentiated
    q : integer
        Order of the Taylor series

    Returns
    -------
    expA : array, shape(M,M)
        Matrix exponential of A

    """
    A = asarray(A)
=======
    s, vr = eig(A)
    vri = inv(vr)
    r = dot(dot(vr, diag(exp(s))), vri)
    if t in ['f', 'd']:
        return r.real.astype(t)
    else:
        return r.astype(t)


# deprecated, but probably should be left there in the long term
@np.deprecate(new_name="expm")
def expm3(A, q=20):
    """
    Compute the matrix exponential using Taylor series.

    Parameters
    ----------
    A : (N, N) array_like
        Matrix to be exponentiated
    q : int
        Order of the Taylor series used is `q-1`

    Returns
    -------
    expm3 : (N, N) ndarray
        Matrix exponential of `A`

    """
    A = _asarray_square(A)
    n = A.shape[0]
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
    t = A.dtype.char
    if t not in ['f','F','d','D']:
        A = A.astype('d')
        t = 'd'
<<<<<<< HEAD
    A = mat(A)
    eA = eye(*A.shape,**{'dtype':t})
    trm = mat(eA, copy=True)
    castfunc = cast[t]
    for k in range(1,q):
        trm *= A / castfunc(k)
        eA += trm
    return eA

_array_precision = {'i': 1, 'l': 1, 'f': 0, 'd': 1, 'F': 0, 'D': 1}

def toreal(arr, tol=None):
    """Return as real array if imaginary part is small.

    Parameters
    ----------
    arr : array
    tol : float
        Absolute tolerance

    Returns
    -------
    arr : double or complex array
    """
    if tol is None:
        tol = {0:feps*1e3, 1:eps*1e6}[_array_precision[arr.dtype.char]]
    if (arr.dtype.char in ['F', 'D','G']) and \
       np.allclose(arr.imag, 0.0, atol=tol):
        arr = arr.real
    return arr

def cosm(A):
    """Compute the matrix cosine.
=======
    eA = np.identity(n, dtype=t)
    trm = np.identity(n, dtype=t)
    castfunc = cast[t]
    for k in range(1, q):
        trm[:] = trm.dot(A) / castfunc(k)
        eA += trm
    return eA


def cosm(A):
    """
    Compute the matrix cosine.
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

    This routine uses expm to compute the matrix exponentials.

    Parameters
    ----------
<<<<<<< HEAD
    A : array, shape(M,M)

    Returns
    -------
    cosA : array, shape(M,M)
        Matrix cosine of A

    """
    A = asarray(A)
    if A.dtype.char not in ['F','D','G']:
        return expm(1j*A).real
    else:
        return 0.5*(expm(1j*A) + expm(-1j*A))


def sinm(A):
    """Compute the matrix sine.
=======
    A : (N, N) array_like
        Input array

    Returns
    -------
    cosm : (N, N) ndarray
        Matrix cosine of A

    Examples
    --------
    >>> from scipy.linalg import expm, sinm, cosm

    Euler's identity (exp(i*theta) = cos(theta) + i*sin(theta))
    applied to a matrix:

    >>> a = np.array([[1.0, 2.0], [-1.0, 3.0]])
    >>> expm(1j*a)
    array([[ 0.42645930+1.89217551j, -2.13721484-0.97811252j],
           [ 1.06860742+0.48905626j, -1.71075555+0.91406299j]])
    >>> cosm(a) + 1j*sinm(a)
    array([[ 0.42645930+1.89217551j, -2.13721484-0.97811252j],
           [ 1.06860742+0.48905626j, -1.71075555+0.91406299j]])

    """
    A = _asarray_square(A)
    if np.iscomplexobj(A):
        return 0.5*(expm(1j*A) + expm(-1j*A))
    else:
        return expm(1j*A).real


def sinm(A):
    """
    Compute the matrix sine.
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

    This routine uses expm to compute the matrix exponentials.

    Parameters
    ----------
<<<<<<< HEAD
    A : array, shape(M,M)

    Returns
    -------
    sinA : array, shape(M,M)
        Matrix cosine of A

    """
    A = asarray(A)
    if A.dtype.char not in ['F','D','G']:
        return expm(1j*A).imag
    else:
        return -0.5j*(expm(1j*A) - expm(-1j*A))

def tanm(A):
    """Compute the matrix tangent.
=======
    A : (N, N) array_like
        Input array.

    Returns
    -------
    sinm : (N, N) ndarray
        Matrix cosine of `A`

    Examples
    --------
    >>> from scipy.linalg import expm, sinm, cosm

    Euler's identity (exp(i*theta) = cos(theta) + i*sin(theta))
    applied to a matrix:

    >>> a = np.array([[1.0, 2.0], [-1.0, 3.0]])
    >>> expm(1j*a)
    array([[ 0.42645930+1.89217551j, -2.13721484-0.97811252j],
           [ 1.06860742+0.48905626j, -1.71075555+0.91406299j]])
    >>> cosm(a) + 1j*sinm(a)
    array([[ 0.42645930+1.89217551j, -2.13721484-0.97811252j],
           [ 1.06860742+0.48905626j, -1.71075555+0.91406299j]])

    """
    A = _asarray_square(A)
    if np.iscomplexobj(A):
        return -0.5j*(expm(1j*A) - expm(-1j*A))
    else:
        return expm(1j*A).imag


def tanm(A):
    """
    Compute the matrix tangent.
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

    This routine uses expm to compute the matrix exponentials.

    Parameters
    ----------
<<<<<<< HEAD
    A : array, shape(M,M)

    Returns
    -------
    tanA : array, shape(M,M)
        Matrix tangent of A

    """
    A = asarray(A)
    if A.dtype.char not in ['F','D','G']:
        return toreal(solve(cosm(A), sinm(A)))
    else:
        return solve(cosm(A), sinm(A))

def coshm(A):
    """Compute the hyperbolic matrix cosine.
=======
    A : (N, N) array_like
        Input array.

    Returns
    -------
    tanm : (N, N) ndarray
        Matrix tangent of `A`

    Examples
    --------
    >>> from scipy.linalg import tanm, sinm, cosm
    >>> a = np.array([[1.0, 3.0], [1.0, 4.0]])
    >>> t = tanm(a)
    >>> t
    array([[ -2.00876993,  -8.41880636],
           [ -2.80626879, -10.42757629]])

    Verify tanm(a) = sinm(a).dot(inv(cosm(a)))

    >>> s = sinm(a)
    >>> c = cosm(a)
    >>> s.dot(np.linalg.inv(c))
    array([[ -2.00876993,  -8.41880636],
           [ -2.80626879, -10.42757629]])

    """
    A = _asarray_square(A)
    return _maybe_real(A, solve(cosm(A), sinm(A)))


def coshm(A):
    """
    Compute the hyperbolic matrix cosine.
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

    This routine uses expm to compute the matrix exponentials.

    Parameters
    ----------
<<<<<<< HEAD
    A : array, shape(M,M)

    Returns
    -------
    coshA : array, shape(M,M)
        Hyperbolic matrix cosine of A

    """
    A = asarray(A)
    if A.dtype.char not in ['F','D','G']:
        return toreal(0.5*(expm(A) + expm(-A)))
    else:
        return 0.5*(expm(A) + expm(-A))

def sinhm(A):
    """Compute the hyperbolic matrix sine.
=======
    A : (N, N) array_like
        Input array.

    Returns
    -------
    coshm : (N, N) ndarray
        Hyperbolic matrix cosine of `A`

    Examples
    --------
    >>> from scipy.linalg import tanhm, sinhm, coshm
    >>> a = np.array([[1.0, 3.0], [1.0, 4.0]])
    >>> c = coshm(a)
    >>> c
    array([[ 11.24592233,  38.76236492],
           [ 12.92078831,  50.00828725]])

    Verify tanhm(a) = sinhm(a).dot(inv(coshm(a)))

    >>> t = tanhm(a)
    >>> s = sinhm(a)
    >>> t - s.dot(np.linalg.inv(c))
    array([[  2.72004641e-15,   4.55191440e-15],
           [  0.00000000e+00,  -5.55111512e-16]])

    """
    A = _asarray_square(A)
    return _maybe_real(A, 0.5 * (expm(A) + expm(-A)))


def sinhm(A):
    """
    Compute the hyperbolic matrix sine.
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

    This routine uses expm to compute the matrix exponentials.

    Parameters
    ----------
<<<<<<< HEAD
    A : array, shape(M,M)

    Returns
    -------
    sinhA : array, shape(M,M)
        Hyperbolic matrix sine of A

    """
    A = asarray(A)
    if A.dtype.char not in ['F','D']:
        return toreal(0.5*(expm(A) - expm(-A)))
    else:
        return 0.5*(expm(A) - expm(-A))

def tanhm(A):
    """Compute the hyperbolic matrix tangent.
=======
    A : (N, N) array_like
        Input array.

    Returns
    -------
    sinhm : (N, N) ndarray
        Hyperbolic matrix sine of `A`

    Examples
    --------
    >>> from scipy.linalg import tanhm, sinhm, coshm
    >>> a = np.array([[1.0, 3.0], [1.0, 4.0]])
    >>> s = sinhm(a)
    >>> s
    array([[ 10.57300653,  39.28826594],
           [ 13.09608865,  49.86127247]])

    Verify tanhm(a) = sinhm(a).dot(inv(coshm(a)))

    >>> t = tanhm(a)
    >>> c = coshm(a)
    >>> t - s.dot(np.linalg.inv(c))
    array([[  2.72004641e-15,   4.55191440e-15],
           [  0.00000000e+00,  -5.55111512e-16]])

    """
    A = _asarray_square(A)
    return _maybe_real(A, 0.5 * (expm(A) - expm(-A)))


def tanhm(A):
    """
    Compute the hyperbolic matrix tangent.
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

    This routine uses expm to compute the matrix exponentials.

    Parameters
    ----------
<<<<<<< HEAD
    A : array, shape(M,M)

    Returns
    -------
    tanhA : array, shape(M,M)
        Hyperbolic matrix tangent of A

    """
    A = asarray(A)
    if A.dtype.char not in ['F','D']:
        return toreal(solve(coshm(A), sinhm(A)))
    else:
        return solve(coshm(A), sinhm(A))

def funm(A, func, disp=True):
    """Evaluate a matrix function specified by a callable.

    Returns the value of matrix-valued function f at A. The function f
    is an extension of the scalar-valued function func to matrices.

    Parameters
    ----------
    A : array, shape(M,M)
=======
    A : (N, N) array_like
        Input array

    Returns
    -------
    tanhm : (N, N) ndarray
        Hyperbolic matrix tangent of `A`

    Examples
    --------
    >>> from scipy.linalg import tanhm, sinhm, coshm
    >>> a = np.array([[1.0, 3.0], [1.0, 4.0]])
    >>> t = tanhm(a)
    >>> t
    array([[ 0.3428582 ,  0.51987926],
           [ 0.17329309,  0.86273746]])

    Verify tanhm(a) = sinhm(a).dot(inv(coshm(a)))

    >>> s = sinhm(a)
    >>> c = coshm(a)
    >>> t - s.dot(np.linalg.inv(c))
    array([[  2.72004641e-15,   4.55191440e-15],
           [  0.00000000e+00,  -5.55111512e-16]])

    """
    A = _asarray_square(A)
    return _maybe_real(A, solve(coshm(A), sinhm(A)))


def funm(A, func, disp=True):
    """
    Evaluate a matrix function specified by a callable.

    Returns the value of matrix-valued function ``f`` at `A`. The
    function ``f`` is an extension of the scalar-valued function `func`
    to matrices.

    Parameters
    ----------
    A : (N, N) array_like
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
        Matrix at which to evaluate the function
    func : callable
        Callable object that evaluates a scalar function f.
        Must be vectorized (eg. using vectorize).
<<<<<<< HEAD
    disp : boolean
=======
    disp : bool, optional
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
        Print warning if error in the result is estimated large
        instead of returning estimated error. (Default: True)

    Returns
    -------
<<<<<<< HEAD
    fA : array, shape(M,M)
        Value of the matrix function specified by func evaluated at A

    (if disp == False)
    errest : float
        1-norm of the estimated error, ||err||_1 / ||A||_1

    """
    # Perform Shur decomposition (lapack ?gees)
    A = asarray(A)
    if len(A.shape)!=2:
        raise ValueError, "Non-matrix input to matrix function."
    if A.dtype.char in ['F', 'D', 'G']:
        cmplx_type = 1
    else:
        cmplx_type = 0
=======
    funm : (N, N) ndarray
        Value of the matrix function specified by func evaluated at `A`
    errest : float
        (if disp == False)

        1-norm of the estimated error, ||err||_1 / ||A||_1

    Examples
    --------
    >>> from scipy.linalg import funm
    >>> a = np.array([[1.0, 3.0], [1.0, 4.0]])
    >>> funm(a, lambda x: x*x)
    array([[  4.,  15.],
           [  5.,  19.]])
    >>> a.dot(a)
    array([[  4.,  15.],
           [  5.,  19.]])

    Notes
    -----
    This function implements the general algorithm based on Schur decomposition
    (Algorithm 9.1.1. in [1]_).

    If the input matrix is known to be diagonalizable, then relying on the
    eigendecomposition is likely to be faster. For example, if your matrix is
    Hermitian, you can do

    >>> from scipy.linalg import eigh
    >>> def funm_herm(a, func, check_finite=False):
    ...     w, v = eigh(a, check_finite=check_finite)
    ...     ## if you further know that your matrix is positive semidefinite,
    ...     ## you can optionally guard against precision errors by doing
    ...     # w = np.maximum(w, 0)
    ...     w = func(w)
    ...     return (v * w).dot(v.conj().T)

    References
    ----------
    .. [1] Gene H. Golub, Charles F. van Loan, Matrix Computations 4th ed.

    """
    A = _asarray_square(A)
    # Perform Shur decomposition (lapack ?gees)
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
    T, Z = schur(A)
    T, Z = rsf2csf(T,Z)
    n,n = T.shape
    F = diag(func(diag(T)))  # apply function to diagonal elements
<<<<<<< HEAD
    F = F.astype(T.dtype.char) # e.g. when F is real but T is complex
=======
    F = F.astype(T.dtype.char)  # e.g. when F is real but T is complex
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

    minden = abs(T[0,0])

    # implement Algorithm 11.1.1 from Golub and Van Loan
    #                 "matrix Computations."
    for p in range(1,n):
        for i in range(1,n-p+1):
            j = i + p
            s = T[i-1,j-1] * (F[j-1,j-1] - F[i-1,i-1])
            ksl = slice(i,j-1)
            val = dot(T[i-1,ksl],F[ksl,j-1]) - dot(F[i-1,ksl],T[ksl,j-1])
            s = s + val
            den = T[j-1,j-1] - T[i-1,i-1]
            if den != 0.0:
                s = s / den
            F[i-1,j-1] = s
            minden = min(minden,abs(den))

<<<<<<< HEAD
    F = dot(dot(Z, F),transpose(conjugate(Z)))
    if not cmplx_type:
        F = toreal(F)
=======
    F = dot(dot(Z, F), transpose(conjugate(Z)))
    F = _maybe_real(A, F)
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

    tol = {0:feps, 1:eps}[_array_precision[F.dtype.char]]
    if minden == 0.0:
        minden = tol
    err = min(1, max(tol,(tol/minden)*norm(triu(T,1),1)))
    if product(ravel(logical_not(isfinite(F))),axis=0):
        err = Inf
    if disp:
        if err > 1000*tol:
<<<<<<< HEAD
            print "Result may be inaccurate, approximate err =", err
=======
            print("funm result may be inaccurate, approximate err =", err)
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
        return F
    else:
        return F, err

<<<<<<< HEAD
def logm(A, disp=True):
    """Compute matrix logarithm.

    The matrix logarithm is the inverse of expm: expm(logm(A)) == A

    Parameters
    ----------
    A : array, shape(M,M)
        Matrix whose logarithm to evaluate
    disp : boolean
        Print warning if error in the result is estimated large
        instead of returning estimated error. (Default: True)

    Returns
    -------
    logA : array, shape(M,M)
        Matrix logarithm of A

    (if disp == False)
    errest : float
        1-norm of the estimated error, ||err||_1 / ||A||_1

    """
    # Compute using general funm but then use better error estimator and
    #   make one step in improving estimate using a rotation matrix.
    A = mat(asarray(A))
    F, errest = funm(A,log,disp=0)
    errtol = 1000*eps
    # Only iterate if estimate of error is too large.
    if errest >= errtol:
        # Use better approximation of error
        errest = norm(expm(F)-A,1) / norm(A,1)
        if not isfinite(errest) or errest >= errtol:
            N,N = A.shape
            X,Y = ogrid[1:N+1,1:N+1]
            R = mat(orth(eye(N,dtype='d')+X+Y))
            F, dontcare = funm(R*A*R.H,log,disp=0)
            F = R.H*F*R
            if (norm(imag(F),1)<=1000*errtol*norm(F,1)):
                F = mat(real(F))
            E = mat(expm(F))
            temp = mat(solve(E.T,(E-A).T))
            F = F - temp.T
            errest = norm(expm(F)-A,1) / norm(A,1)
    if disp:
        if not isfinite(errest) or errest >= errtol:
            print "Result may be inaccurate, approximate err =", errest
        return F
    else:
        return F, errest

def signm(a, disp=True):
    """Matrix sign function.
=======

def signm(A, disp=True):
    """
    Matrix sign function.
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

    Extension of the scalar sign(x) to matrices.

    Parameters
    ----------
<<<<<<< HEAD
    A : array, shape(M,M)
        Matrix at which to evaluate the sign function
    disp : boolean
=======
    A : (N, N) array_like
        Matrix at which to evaluate the sign function
    disp : bool, optional
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
        Print warning if error in the result is estimated large
        instead of returning estimated error. (Default: True)

    Returns
    -------
<<<<<<< HEAD
    sgnA : array, shape(M,M)
        Value of the sign function at A

    (if disp == False)
    errest : float
=======
    signm : (N, N) ndarray
        Value of the sign function at `A`
    errest : float
        (if disp == False)

>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
        1-norm of the estimated error, ||err||_1 / ||A||_1

    Examples
    --------
    >>> from scipy.linalg import signm, eigvals
    >>> a = [[1,2,3], [1,2,1], [1,1,1]]
    >>> eigvals(a)
    array([ 4.12488542+0.j, -0.76155718+0.j,  0.63667176+0.j])
    >>> eigvals(signm(a))
    array([-1.+0.j,  1.+0.j,  1.+0.j])

    """
<<<<<<< HEAD
    def rounded_sign(x):
        rx = real(x)
        if rx.dtype.char=='f':
            c =  1e3*feps*amax(x)
        else:
            c =  1e3*eps*amax(x)
        return sign( (absolute(rx) > c) * rx )
    result,errest = funm(a, rounded_sign, disp=0)
=======
    A = _asarray_square(A)

    def rounded_sign(x):
        rx = np.real(x)
        if rx.dtype.char == 'f':
            c = 1e3*feps*amax(x)
        else:
            c = 1e3*eps*amax(x)
        return sign((absolute(rx) > c) * rx)
    result, errest = funm(A, rounded_sign, disp=0)
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
    errtol = {0:1e3*feps, 1:1e3*eps}[_array_precision[result.dtype.char]]
    if errest < errtol:
        return result

    # Handle signm of defective matrices:

    # See "E.D.Denman and J.Leyva-Ramos, Appl.Math.Comp.,
    # 8:237-250,1981" for how to improve the following (currently a
    # rather naive) iteration process:

<<<<<<< HEAD
    a = asarray(a)
    #a = result # sometimes iteration converges faster but where??

    # Shifting to avoid zero eigenvalues. How to ensure that shifting does
    # not change the spectrum too much?
    vals = svd(a,compute_uv=0)
    max_sv = np.amax(vals)
    #min_nonzero_sv = vals[(vals>max_sv*errtol).tolist().count(1)-1]
    #c = 0.5/min_nonzero_sv
    c = 0.5/max_sv
    S0 = a + c*np.identity(a.shape[0])
=======
    # a = result # sometimes iteration converges faster but where??

    # Shifting to avoid zero eigenvalues. How to ensure that shifting does
    # not change the spectrum too much?
    vals = svd(A, compute_uv=0)
    max_sv = np.amax(vals)
    # min_nonzero_sv = vals[(vals>max_sv*errtol).tolist().count(1)-1]
    # c = 0.5/min_nonzero_sv
    c = 0.5/max_sv
    S0 = A + c*np.identity(A.shape[0])
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
    prev_errest = errest
    for i in range(100):
        iS0 = inv(S0)
        S0 = 0.5*(S0 + iS0)
<<<<<<< HEAD
        Pp=0.5*(dot(S0,S0)+S0)
        errest = norm(dot(Pp,Pp)-Pp,1)
        if errest < errtol or prev_errest==errest:
=======
        Pp = 0.5*(dot(S0,S0)+S0)
        errest = norm(dot(Pp,Pp)-Pp,1)
        if errest < errtol or prev_errest == errest:
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
            break
        prev_errest = errest
    if disp:
        if not isfinite(errest) or errest >= errtol:
<<<<<<< HEAD
            print "Result may be inaccurate, approximate err =", errest
        return S0
    else:
        return S0, errest

def sqrtm(A, disp=True):
    """Matrix square root.

    Parameters
    ----------
    A : array, shape(M,M)
        Matrix whose square root to evaluate
    disp : boolean
        Print warning if error in the result is estimated large
        instead of returning estimated error. (Default: True)

    Returns
    -------
    sgnA : array, shape(M,M)
        Value of the sign function at A

    (if disp == False)
    errest : float
        Frobenius norm of the estimated error, ||err||_F / ||A||_F

    Notes
    -----
    Uses algorithm by Nicholas J. Higham

    """
    A = asarray(A)
    if len(A.shape)!=2:
        raise ValueError, "Non-matrix input to matrix function."
    T, Z = schur(A)
    T, Z = rsf2csf(T,Z)
    n,n = T.shape

    R = np.zeros((n,n),T.dtype.char)
    for j in range(n):
        R[j,j] = sqrt(T[j,j])
        for i in range(j-1,-1,-1):
            s = 0
            for k in range(i+1,j):
                s = s + R[i,k]*R[k,j]
            R[i,j] = (T[i,j] - s)/(R[i,i] + R[j,j])

    R, Z = all_mat(R,Z)
    X = (Z * R * Z.H)

    if disp:
        nzeig = np.any(diag(T)==0)
        if nzeig:
            print "Matrix is singular and may not have a square root."
        return X.A
    else:
        arg2 = norm(X*X - A,'fro')**2 / norm(A,'fro')
        return X.A, arg2
=======
            print("signm result may be inaccurate, approximate err =", errest)
        return S0
    else:
        return S0, errest
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
