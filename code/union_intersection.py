import matplotlib.pyplot as plt
from matplotlib_venn import venn2
import matplotlib.patches as mpatches

# Преобразуем списки в множества
with open('../data/tf_list_Alina.txt', 'r') as file1:
    list1 = list(map(lambda x: x.strip(), file1.readlines()))

with open('../data/GO_TF_set.txt', 'r') as file2:
    list2 = list(map(lambda x: x.strip(), file2.readlines()))

set1 = set(list1)
set2 = set(list2)

print('Alina TF list:', len(set1))
print('Ivan TF list:', len(set2))

# Объединение
union = set1.union(set2)  # или set1 | set2
print("Объединение:", len(union))

# Пересечение
intersection = set2.intersection(set1)  # или set1 & set2
print("Пересечение:", len(intersection))

# Подготовка данных для диаграммы Венна
only_set1 = set1 - intersection  # Элементы только в первом множестве
only_set2 = set2 - intersection  # Элементы только во втором множестве

# Создание диаграммы Венна с заданием цветов
plt.figure(figsize=(8, 6))
venn_diagram = venn2(subsets=(len(only_set1), len(only_set2), len(intersection)),
                     alpha=0.5)  # Устанавливаем прозрачность

# Задаем новые цвета для каждого множества
venn_diagram.get_patch_by_id('10').set_color('#FF9999')  # Насыщенный красный для Alina TF List
venn_diagram.get_patch_by_id('01').set_color('#99CCFF')  # Насыщенный голубой для Ivan TF List
venn_diagram.get_patch_by_id('11').set_color('#CCCCCC')   # Серый для пересечения

# Функция для форматирования списка с учетом длины
def format_list(elements):
    sorted_elements = sorted(elements)
    if len(sorted_elements) <= 10:
        return '\n'.join(sorted_elements)
    else:
        return '\n'.join(sorted_elements[:10]) + f'\n... ({len(sorted_elements)})'

# Подпись элементов на диаграмме без заголовков
venn_diagram.get_label_by_id('10').set_text(format_list(only_set1))  # Элементы только в первом множестве
venn_diagram.get_label_by_id('01').set_text(format_list(only_set2))  # Элементы только во втором множестве
venn_diagram.get_label_by_id('11').set_text(format_list(intersection))  # Элементы пересечения

# Добавление легенды с квадратиками соответствующего цвета
legend_elements = [
    mpatches.Patch(color='#FF9999', label='Alina TF List'),
    mpatches.Patch(color='#99CCFF', label='Ivan TF List'),
    mpatches.Patch(color='#CCCCCC', label='Пересечение')
]

plt.legend(handles=legend_elements, loc='upper right')

# Отображение диаграммы без заголовков кружочков
plt.title("Диаграмма Венна для Alina TF List и Ivan TF List")
plt.show()