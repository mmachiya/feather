def greet(name=None):
    if name is None:
        return "Hello, my friend."
    if type(name) == str:
        if name.isupper():
            return "HELLO "+name+"!"
        return "Hello, " + name + "."
    elif type(name) == list:
        comma = False
        temp = []
        for n in name:
            if "\"" in n:
                temp.append(n[1:len(n)-1])
            elif n.find(","):
                names = n.split(", ")
                for n2 in names:
                    temp.append(n2)
            else:
                temp.append(n)
        name = temp
        if len(name) == 2:
            return "Hello, {} and {}.".format(name[0], name[1])
        elif len(name) > 2:
            string = "Hello"
            regname = 0
            upname = 0
            upperstring = " AND HELLO"
            upper = False
            for n in name:
                if n.isupper():
                    upper = True
                    upperstring += " " + n+ "!"
                else:
                    regname += 1
                    string += ", " + n
            index = string.rindex(",")
            if regname > 2:
                string = string[:index+1] + " and" + string[index+1:] + "."
            if regname == 2:
                 string = string[:index] + " and" + string[index+1:] + "."
            if upper:
                return string + upperstring
            return string
    


def main():
    pass


if __name__ == "__main__":
    main()
