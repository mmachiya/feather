def greet(name):
    if name == None:
        return "Hello, my friend."
    elif type(name) == str:
        if name.isupper():
            return "HELLO, " + name + "!" 
        return "Hello, " + name + "."
    elif type(name) == list:
        if len(name) == 2:
            for n in name:
                if "," in n:
                    return weird(n, name)
            return "Hello, " + name[0] + " and " + name[1] + "."
        elif len(name) > 2:
            for n in name:
                if n.isupper():
                    return shouting(n, name)
            string = ''
            string += "Hello"
            for n in name[0:len(name)-1]:
                string += (", " + n)
            string += ", and " + name[len(name)-1]  + "."
            return string

def shouting(n, name):
    lowernames = []
    for x in name:
        if x != n:
            lowernames.append(x)
    return "Hello, " + lowernames[0] + " and " + lowernames[1] + ". AND HELLO " + n + "!"

def weird(n, name):
    normalnames = []
    weirdnames = []
    for x in name:
        if "," not in x:
            normalnames.append(x)
        else:
            weirdnames.append(x.replace("\"", ""))
    return "Hello, " + normalnames[0] + " and " + weirdnames[0] + "."


import unittest

class TestKata(unittest.TestCase):
    def test_bob(self):
        self.assertEqual(greet("Bob"), "Hello, Bob.")
        
    def test_null(self):
        self.assertEqual(greet(None), "Hello, my friend.")

    def test_shout(self):
        self.assertEqual(greet("JERRY"), "HELLO, JERRY!")

    def test_2names(self):
        self.assertEqual(greet(["Jill", "Jane"]), "Hello, Jill and Jane.")

    def test_more_names(self):
        self.assertEqual(greet(["Amy", "Brian", "Charlotte"]), "Hello, Amy, Brian, and Charlotte.")

    def test_more_names_shout(self):
        self.assertEqual(greet(["Amy", "BRIAN", "Charlotte"]), "Hello, Amy and Charlotte. AND HELLO BRIAN!")

    def test_more_names_per_string(self):
        self.assertEqual(greet(["Bob", "Charlie, Dianne"]), "Hello, Bob, Charlie, and Dianne.")
        
    def test_more_names_per_string(self):
        self.assertEqual(greet(["Bob", "\"Charlie, Dianne\""]), "Hello, Bob and Charlie, Dianne.")


if __name__ == '__main__':
    unittest.main()

