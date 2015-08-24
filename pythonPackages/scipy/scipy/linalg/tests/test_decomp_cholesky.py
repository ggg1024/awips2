<<<<<<< HEAD

=======
from __future__ import division, print_function, absolute_import
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b

from numpy.testing import TestCase, assert_array_almost_equal

from numpy import array, transpose, dot, conjugate, zeros_like
from numpy.random import rand
<<<<<<< HEAD
from scipy.linalg import cholesky, cholesky_banded, cho_solve_banded
=======
from scipy.linalg import cholesky, cholesky_banded, cho_solve_banded, \
     cho_factor, cho_solve

from scipy.linalg._testutils import assert_no_overwrite
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b


def random(size):
    return rand(*size)


class TestCholesky(TestCase):

    def test_simple(self):
        a = [[8,2,3],[2,9,3],[3,3,6]]
        c = cholesky(a)
        assert_array_almost_equal(dot(transpose(c),c),a)
        c = transpose(c)
        a = dot(c,transpose(c))
        assert_array_almost_equal(cholesky(a,lower=1),c)

<<<<<<< HEAD
=======
    def test_check_finite(self):
        a = [[8,2,3],[2,9,3],[3,3,6]]
        c = cholesky(a, check_finite=False)
        assert_array_almost_equal(dot(transpose(c),c),a)
        c = transpose(c)
        a = dot(c,transpose(c))
        assert_array_almost_equal(cholesky(a,lower=1, check_finite=False),c)

>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
    def test_simple_complex(self):
        m = array([[3+1j,3+4j,5],[0,2+2j,2+7j],[0,0,7+4j]])
        a = dot(transpose(conjugate(m)),m)
        c = cholesky(a)
        a1 = dot(transpose(conjugate(c)),c)
        assert_array_almost_equal(a,a1)
        c = transpose(c)
        a = dot(c,transpose(conjugate(c)))
        assert_array_almost_equal(cholesky(a,lower=1),c)

    def test_random(self):
        n = 20
        for k in range(2):
            m = random([n,n])
            for i in range(n):
                m[i,i] = 20*(.1+m[i,i])
            a = dot(transpose(m),m)
            c = cholesky(a)
            a1 = dot(transpose(c),c)
            assert_array_almost_equal(a,a1)
            c = transpose(c)
            a = dot(c,transpose(c))
            assert_array_almost_equal(cholesky(a,lower=1),c)

    def test_random_complex(self):
        n = 20
        for k in range(2):
            m = random([n,n])+1j*random([n,n])
            for i in range(n):
                m[i,i] = 20*(.1+abs(m[i,i]))
            a = dot(transpose(conjugate(m)),m)
            c = cholesky(a)
            a1 = dot(transpose(conjugate(c)),c)
            assert_array_almost_equal(a,a1)
            c = transpose(c)
            a = dot(c,transpose(conjugate(c)))
            assert_array_almost_equal(cholesky(a,lower=1),c)


class TestCholeskyBanded(TestCase):
    """Tests for cholesky_banded() and cho_solve_banded."""

<<<<<<< HEAD
=======
    def test_check_finite(self):
        # Symmetric positive definite banded matrix `a`
        a = array([[4.0, 1.0, 0.0, 0.0],
                    [1.0, 4.0, 0.5, 0.0],
                    [0.0, 0.5, 4.0, 0.2],
                    [0.0, 0.0, 0.2, 4.0]])
        # Banded storage form of `a`.
        ab = array([[-1.0, 1.0, 0.5, 0.2],
                     [4.0, 4.0, 4.0, 4.0]])
        c = cholesky_banded(ab, lower=False, check_finite=False)
        ufac = zeros_like(a)
        ufac[list(range(4)),list(range(4))] = c[-1]
        ufac[(0,1,2),(1,2,3)] = c[0,1:]
        assert_array_almost_equal(a, dot(ufac.T, ufac))

        b = array([0.0, 0.5, 4.2, 4.2])
        x = cho_solve_banded((c, False), b, check_finite=False)
        assert_array_almost_equal(x, [0.0, 0.0, 1.0, 1.0])

>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
    def test_upper_real(self):
        # Symmetric positive definite banded matrix `a`
        a = array([[4.0, 1.0, 0.0, 0.0],
                    [1.0, 4.0, 0.5, 0.0],
                    [0.0, 0.5, 4.0, 0.2],
                    [0.0, 0.0, 0.2, 4.0]])
        # Banded storage form of `a`.
        ab = array([[-1.0, 1.0, 0.5, 0.2],
                     [4.0, 4.0, 4.0, 4.0]])
        c = cholesky_banded(ab, lower=False)
        ufac = zeros_like(a)
<<<<<<< HEAD
        ufac[range(4),range(4)] = c[-1]
=======
        ufac[list(range(4)),list(range(4))] = c[-1]
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
        ufac[(0,1,2),(1,2,3)] = c[0,1:]
        assert_array_almost_equal(a, dot(ufac.T, ufac))

        b = array([0.0, 0.5, 4.2, 4.2])
        x = cho_solve_banded((c, False), b)
        assert_array_almost_equal(x, [0.0, 0.0, 1.0, 1.0])

    def test_upper_complex(self):
        # Hermitian positive definite banded matrix `a`
<<<<<<< HEAD
        a = array([[4.0, 1.0,  0.0,  0.0],
                    [1.0, 4.0,  0.5,  0.0],
                    [0.0, 0.5,  4.0, -0.2j],
                    [0.0, 0.0,  0.2j, 4.0]])
        # Banded storage form of `a`.
        ab = array([[-1.0, 1.0, 0.5, -0.2j],
                     [4.0, 4.0, 4.0,  4.0]])
        c = cholesky_banded(ab, lower=False)
        ufac = zeros_like(a)
        ufac[range(4),range(4)] = c[-1]
=======
        a = array([[4.0, 1.0, 0.0, 0.0],
                    [1.0, 4.0, 0.5, 0.0],
                    [0.0, 0.5, 4.0, -0.2j],
                    [0.0, 0.0, 0.2j, 4.0]])
        # Banded storage form of `a`.
        ab = array([[-1.0, 1.0, 0.5, -0.2j],
                     [4.0, 4.0, 4.0, 4.0]])
        c = cholesky_banded(ab, lower=False)
        ufac = zeros_like(a)
        ufac[list(range(4)),list(range(4))] = c[-1]
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
        ufac[(0,1,2),(1,2,3)] = c[0,1:]
        assert_array_almost_equal(a, dot(ufac.conj().T, ufac))

        b = array([0.0, 0.5, 4.0-0.2j, 0.2j + 4.0])
        x = cho_solve_banded((c, False), b)
        assert_array_almost_equal(x, [0.0, 0.0, 1.0, 1.0])

    def test_lower_real(self):
        # Symmetric positive definite banded matrix `a`
        a = array([[4.0, 1.0, 0.0, 0.0],
                    [1.0, 4.0, 0.5, 0.0],
                    [0.0, 0.5, 4.0, 0.2],
                    [0.0, 0.0, 0.2, 4.0]])
        # Banded storage form of `a`.
        ab = array([[4.0, 4.0, 4.0, 4.0],
                    [1.0, 0.5, 0.2, -1.0]])
        c = cholesky_banded(ab, lower=True)
        lfac = zeros_like(a)
<<<<<<< HEAD
        lfac[range(4),range(4)] = c[0]
=======
        lfac[list(range(4)),list(range(4))] = c[0]
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
        lfac[(1,2,3),(0,1,2)] = c[1,:3]
        assert_array_almost_equal(a, dot(lfac, lfac.T))

        b = array([0.0, 0.5, 4.2, 4.2])
        x = cho_solve_banded((c, True), b)
        assert_array_almost_equal(x, [0.0, 0.0, 1.0, 1.0])

    def test_lower_complex(self):
        # Hermitian positive definite banded matrix `a`
<<<<<<< HEAD
        a = array([[4.0, 1.0,  0.0,  0.0],
                    [1.0, 4.0,  0.5,  0.0],
                    [0.0, 0.5,  4.0, -0.2j],
                    [0.0, 0.0,  0.2j, 4.0]])
        # Banded storage form of `a`.
        ab = array([[4.0, 4.0, 4.0,  4.0],
                    [1.0, 0.5, 0.2j, -1.0]])
        c = cholesky_banded(ab, lower=True)
        lfac = zeros_like(a)
        lfac[range(4),range(4)] = c[0]
=======
        a = array([[4.0, 1.0, 0.0, 0.0],
                    [1.0, 4.0, 0.5, 0.0],
                    [0.0, 0.5, 4.0, -0.2j],
                    [0.0, 0.0, 0.2j, 4.0]])
        # Banded storage form of `a`.
        ab = array([[4.0, 4.0, 4.0, 4.0],
                    [1.0, 0.5, 0.2j, -1.0]])
        c = cholesky_banded(ab, lower=True)
        lfac = zeros_like(a)
        lfac[list(range(4)),list(range(4))] = c[0]
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
        lfac[(1,2,3),(0,1,2)] = c[1,:3]
        assert_array_almost_equal(a, dot(lfac, lfac.conj().T))

        b = array([0.0, 0.5j, 3.8j, 3.8])
        x = cho_solve_banded((c, True), b)
        assert_array_almost_equal(x, [0.0, 0.0, 1.0j, 1.0])
<<<<<<< HEAD
=======


class TestOverwrite(object):
    def test_cholesky(self):
        assert_no_overwrite(cholesky, [(3,3)])

    def test_cho_factor(self):
        assert_no_overwrite(cho_factor, [(3,3)])

    def test_cho_solve(self):
        x = array([[2,-1,0], [-1,2,-1], [0,-1,2]])
        xcho = cho_factor(x)
        assert_no_overwrite(lambda b: cho_solve(xcho, b), [(3,)])

    def test_cholesky_banded(self):
        assert_no_overwrite(cholesky_banded, [(2,3)])

    def test_cho_solve_banded(self):
        x = array([[0, -1, -1], [2, 2, 2]])
        xcho = cholesky_banded(x)
        assert_no_overwrite(lambda b: cho_solve_banded((xcho, False), b),
                            [(3,)])
>>>>>>> 85b42d3bbdcef5cbe0fe2390bba8b3ff1608040b
