"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib

class TestSuccessfulLoginHasCorrectErrorCode(testLib.RestTestCase):
    def testUnit(self):
        req1 = self.makeRequest("/users/add", method="POST", data={'user':'user1', 'password':'password'})
        req2 = self.makeRequest("/users/login", method="POST", data={'user':'user1', 'password':'password'})
        self.assertEquals(req2['errCode'],1)


class TestUnsuccessfulLogin(testLib.RestTestCase):
    def testUnit(self):
        req1 = self.makeRequest("/users/add", method="POST", data={'user':'user1', 'password':'password'})
        req2 = self.makeRequest("/users/login", method="POST", data={'user':'user1', 'password':'passwordg'})
        self.assertEquals(req2['errCode'],-1)

class TestRepeatedAdd(testLib.RestTestCase):
    def testUnit(self):
        req1 = self.makeRequest("/users/add", method="POST", data={'user':'user1', 'password':'password'})
        req2 = self.makeRequest("/users/add", method="POST", data={'user':'user1', 'password':'password'})
        self.assertEquals(req2['errCode'],-2)

class TestLongPassword(testLib.RestTestCase):
    def testUnit(self):
        req1 = self.makeRequest("/users/add", method="POST", data={'user':'user1', 'password':' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vitae risus velit. Nam quis dui at sem iaculis ornare. Ut volutpat...'})
        self.assertEquals(req1['errCode'],-4)

class TestEmptyPassword(testLib.RestTestCase):
    def testUnit(self):
        req1 = self.makeRequest("/users/add", method="POST", data={'user':'user1', 'password':''})
        self.assertEquals(req1['errCode'],1)

class TestEmptyUsername(testLib.RestTestCase):
    def testUnit(self):
        req1 = self.makeRequest("/users/add", method="POST", data={'user':'', 'password':''})
        self.assertEquals(req1['errCode'],-3)

class TestRepeatedLoginsHaveCorrectCount():
    def testUnit(self):
        req1 = self.makeRequest("/users/add", method="POST", data={'user':'user1', 'password':'password'})
        req2 = self.makeRequest("/users/login", method="POST", data={'user':'user1', 'password':'password'})
        self.assertEquals(req2['count'],2)

