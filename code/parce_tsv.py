import os
import pandas as pd

os.chdir('/home/ivan/BI/VAU1_2025')
data = pd.read_csv('polycomb_dots_hand_coords_update.tsv', sep='\t')

gene1_list = list(set(list(data['gene1'])))
gene2_list = list(set(list(data['gene2'])))

genes1_list_split = list(map(lambda x: x.split(','), gene1_list))
genes2_list_split = list(map(lambda x: x.split(','), gene2_list))

genes1_list_split.remove(['-'])
genes2_list_split.remove(['-'])

#print(genes1_list_split)

genes = []

for item in genes1_list_split:
    for elem in item:
        genes.append(elem)

for item in genes2_list_split:
    for elem in item:
        genes.append(elem)
with open('/home/ivan/BI/VAU1_2025/polycomb gene_list', 'w', encoding='utf-8') as outfile:
    print(*sorted(list(set(genes))), sep='\n', file=outfile)
