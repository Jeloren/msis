def get_input(prompt_text):
    """Функция для безопасного ввода только 0 или 1"""
    while True:
        try:
            val = int(input(prompt_text))
            if val in (0, 1):
                return val
            else:
                print("Ошибка! Введите 0 или 1.")
        except ValueError:
            print("Ошибка! Введите целое число (0 или 1).")

print("Введите значения входов X2, X1 и X0 (0 или 1):")
x2 = get_input("X2 (старший бит) = ")
x1 = get_input("X1 = ")
x0 = get_input("X0 (младший бит) = ")
X2 = bool(x2)
X1 = bool(x1)
X0 = bool(x0)
Y0 = not X2 and not X1 and not X0
Y1 = not X2 and not X1 and X0
Y2 = not X2 and X1 and not X0
Y3 = not X2 and X1 and X0
Y4 = X2 and not X1 and not X0
Y5 = X2 and not X1 and X0
Y6 = X2 and X1 and not X0
Y7 = X2 and X1 and X0
outputs = [Y0, Y1, Y2, Y3, Y4, Y5, Y6, Y7]
print("\nСостояния выходов дешифратора:")
for i, y in enumerate(outputs):
    status = "1 (АКТИВЕН)" if y else "0"
    print(f"Y{i}: {status}")
