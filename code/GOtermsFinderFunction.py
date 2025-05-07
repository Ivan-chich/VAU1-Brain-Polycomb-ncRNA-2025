#Script for processing GOtermMapper data

# import libraries:
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# open file with GO terms mapping data:
go_function_mapper = pd.read_csv('/home/ivan/BI/VAU1_2025/GO_annotations/GO_term_mapper/Function/13613_slimTerms.tsv', sep='\t')
#go_function_finder = pd.read_csv('/home/ivan/BI/VAU1_2025/GO_annotations/GO_term_finder/Function/3894423/3894423polycomb gene_list_tab.txt', sep='\t', skiprows=12)

# Select terms 'DNA binding' and 'transcription regulator activity' and take union:
dna_binding = go_function_mapper[(go_function_mapper["TERM"]=='DNA binding')]['ANNOTATED_GENES'].to_list()[0].split(', ')
transcr_reg = go_function_mapper[(go_function_mapper["TERM"]=='transcription regulator activity')]['ANNOTATED_GENES'].to_list()[0].split(', ')

# save TF list as file:
with open('../data/GO_TF_set.txt', 'w', encoding='UTF-8') as outfile:
    print(*sorted(set(dna_binding + transcr_reg)), sep='\n', file=outfile)

# print TFs as list:
print(sorted(set(dna_binding + transcr_reg)))

#plt.figure(figsize=(10, 6))
#sns.barplot(data=go_function_mapper, x='TERM', y='NUM_LIST_ANNOTATIONS', dodge=True)
#plt.xticks(rotation=90)
#plt.show()

#plt.figure(figsize=(10, 6))
#sns.barplot(data=go_function_finder, x='TERM', y='NUM_LIST_ANNOTATIONS', dodge=True)
#plt.xticks(rotation=90)
#plt.show()


