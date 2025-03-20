from os import path

figures = ["fig2.5", "fig2.6", "fig2.7", "fig2.8"]
graphs = ["p1", "p2", "p3", "p4"]


for fig in figures:
    for curve in graphs:

        filepath = path.join("input", f"{fig}_{curve}.txt")
        
        if not path.exists(filepath):
            open(filepath, 'w').close()
        else:
            print(f"File ./input/{fig}_{curve}.txt already exists.\n")
        