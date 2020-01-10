import unittest

def greet(name):
    if name == None:
        return "Hello, my friend."
    elif isinstance(name, list):
        upper = []
        lower = []
        test = []
        temp = []
        for n in name:
            if("\"" not in n):
                test = n.split(", ")
            else:
                test = [n[1:-1]]
            if(len(test) > 0):
                for t in test:
                    temp.append(t)
        name = temp
        for n in name:
            if n.isupper():
                upper.append(n)
            else:
                lower.append(n)
        if len(upper) != 0 and len(lower) != 0:
            return greet(lower) + " AND " + greet(upper)
        if len(upper) == len(name):
            return "HELLO " + name[0] + "!" 
        if(len(name) == 2):
            return "Hello, " + name[0] + " and " + name[1] + "."
        names = "Hello, "
        for n in range(len(name)-1):
            names = names + name[n] + ", "
        return names + "and " + name[len(name)-1] + "."
    elif name.isupper():
        return "HELLO " + name + "!"
    return "Hello, " + name + "."

class TestGreeting(unittest.TestCase):

    def test_greeting(self):
        self.assertEqual(greet("Bob"), "Hello, Bob.")
    def test_null(self):
        self.assertEqual(greet(None), "Hello, my friend.")
    def test_shout(self):
        self.assertEqual(greet("JERRY"), "HELLO JERRY!")
    def test_two_names(self):
        self.assertEqual(greet(["Jill","Jane"]), "Hello, Jill and Jane.")
    def test_more_than_two(self):
        self.assertEqual(greet(["Amy", "Brian", "Charlotte"]), "Hello, Amy, Brian, and Charlotte.")
    def test_mix(self):
        self.assertEqual(greet(["Amy", "BRIAN", "Charlotte"]), "Hello, Amy and Charlotte. AND HELLO BRIAN!")
    def test_comma(self):
        self.assertEqual(greet(["Bob", "Charlie, Dianne"]), "Hello, Bob, Charlie, and Dianne.")
    def test_escape(self):
        self.assertEqual(greet(["Bob", "\"Charlie, Dianne\""]), "Hello, Bob and Charlie, Dianne.")


if __name__ == "__main__":
    unittest.main()
