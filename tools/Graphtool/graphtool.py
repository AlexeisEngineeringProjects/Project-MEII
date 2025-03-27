from os import path
import pandas as pd

figures = ["fig2.5", "fig2.6", "fig2.7", "fig2.8"] # "fig3.1", "fig6.1" 
graphs = ["p1", "p2", "p3", "p4"] # "", ""

Excellpath = path.join("output", "Graph_Data.xlsx")

try:
    with open(Excellpath, 'r'):
        pass

    with pd.ExcelWriter(Excellpath) as excell:

        writed_tables = 0

        for fig in figures:
            for curve in graphs:
                X = []
                Y = []

                datapath = path.join("input", f"{fig}_{curve}.txt")

                if not path.exists(datapath):
                    print(f"\033[91m[ ERROR ]\033[0m File {fig}_{curve}.txt NOT FOUND\n") 
                    continue

                with open(datapath, 'r') as data:
                        for line in data.readlines():
                            if line: 

                                if "//" in line:
                                    try:
                                        X.append(line.strip().split('//')[0])
                                        Y.append(line.strip().split('//')[1])
                                    except ValueError:
                                        print(f"\033[91m[ ERROR ]\033[0m Error ocured by {fig}_{curve}.txt file reading\n")
                                else:
                                    print(f"\033[91m[ ERROR ]\033[0m Error by deta parsing in {fig}_{curve}.txt file, line = {line}\n")

                        if X and Y:
                            excelldata ={
                                "X" : X,
                                "Y" : Y
                            }

                            dt = pd.DataFrame(excelldata)
                            dt = dt.apply(pd.to_numeric)

                            dt.to_excel(excell, sheet_name = f"{fig}_{curve}", index = False)
                            writed_tables += 1

    if writed_tables == 0:
        print("\033[91m[ ERROR ]\033[0m No sheets were written! Check your input files.\n")
    else:
        print("\033[92m[ PASS ]\033[0m Excel file writed successfully.\n")


except PermissionError:
    print(f"\033[91m[ ERROR ]\033[0m Close Excell {Excellpath} file before writing!\n")