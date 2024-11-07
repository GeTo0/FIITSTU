import pyperclip
from wolframclient.language import wl, wlexpr
from wolframclient.evaluation import WolframLanguageSession

if __name__ == '__main__':
    try:
        absolute_path = input("Enter the absolute path to the directory with generators: ")
        package_name = input("Enter the package name: ")
        equation_name = input("Enter the equation name ('EASY', 'MEDIUM', 'HARD'): ")

        # Start the Wolfram Language session
        wfs = WolframLanguageSession()
        wfs.ensure_started()
        print("**** Wolfram Language session started successfully. ****")

        # Set the path and load the package
        wfs.evaluate(wlexpr(f'AppendTo[$Path, "{absolute_path}"]'))
        ctx = wfs.evaluate(wlexpr("$ContextPath"))
        wfs.evaluate(wl.Needs(f'{package_name}`'))
        ctx = wfs.evaluate(wlexpr("$ContextPath"))

        # Evaluate the equation
        res = wfs.evaluate_wrap(f'{package_name}`Equation["{equation_name}"]')

        zadanie = res.result[0]
        postup = res.result[1]
        vysledok = res.result[2]

        print("\n" + "*" * 40)
        print("************** Zadanie **************\n")
        print(zadanie)
        print("************** Postup **************\n")
        print(postup)
        print("************** Výsledok **************\n")
        print(vysledok)

        # Option to copy to clipboard multiple times
        while True:
            print("\n" + "*" * 40)
            print("Select which result to copy to clipboard:")
            print("1. Zadanie")
            print("2. Postup")
            print("3. Výsledok")
            print("4. Exit")
            choice = input("Enter the number of your choice: ")

            if choice == '1':
                pyperclip.copy(zadanie)
                print("Zadanie copied to clipboard.")
            elif choice == '2':
                pyperclip.copy(postup)
                print("Postup copied to clipboard.")
            elif choice == '3':
                pyperclip.copy(vysledok)
                print("Výsledok copied to clipboard.")
            elif choice == '4':
                print("Exiting.")
                break
            else:
                print("Invalid choice. Please enter 1, 2, 3, or 4.")

    except Exception as e:
        print(f"An unexpected error occurred: {e}")

    finally:
        wfs.terminate()
        print("**** Wolfram Language session terminated. ****")