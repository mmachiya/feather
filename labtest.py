import unittest
import greet1

class TestGreet(unittest.TestCase):
    def test_greet1(self):
        self.assertEqual(greet1.greet("Bob"), "Hello, Bob.")
        
    def test_greet2(self):
        self.assertEqual(greet1.greet(), "Hello, my friend.")

    def test_greet3(self):
        self.assertEqual(greet1.greet("JERRY"), "HELLO JERRY!")

    def test_greet4(self):
        self.assertEqual(greet1.greet(["Jill", "Jane"]), "Hello, Jill and Jane.")

    def test_greet5(self):
        self.assertEqual(greet1.greet(["Amy", "Brian", "Charlotte"]), 
                    "Hello, Amy, Brian, and Charlotte.")

    def test_greet6(self):
        self.assertEqual(greet1.greet(["Amy", "BRIAN", "Charlotte"]),
                            "Hello, Amy and Charlotte. AND HELLO BRIAN!")

    def test_greet7(self):
        self.assertEqual(greet1.greet(["Bob", "Charlie, Dianne"]), 
                            "Hello, Bob, Charlie, and Dianne.")

    def test_greet8(self):
        self.assertEqual(greet1.greet(["Bob", "\"Charlie, Dianne\""]),
                            "Hello, Bob and Charlie, Dianne.")


if __name__ == '__main__':
    unittest.main()
