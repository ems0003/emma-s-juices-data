import pandas as pd

# Chargement du fichier propre
df = pd.read_excel('./data/cleaned_data.xlsx')

# 1. Statistiques Descriptives du Panier
ca_total = df['Montant_Total_FCFA'].sum()
panier_moyen_commande = df.groupby('Id_Vente')['Montant_Total_FCFA'].sum().mean()
panier_median_commande = df.groupby('Id_Vente')['Montant_Total_FCFA'].sum().median()
ecart_type_commande = df.groupby('Id_Vente')['Montant_Total_FCFA'].sum().std()

print("--- INDICATEURS CLÉS (KPIs) ---")
print(f"Chiffre d'Affaires Total : {ca_total:,.0f} F CFA")
print(f"Panier Moyen par Commande : {panier_moyen_commande:,.2f} F CFA")
print(f"Panier Médian par Commande : {panier_median_commande:,.2f} F CFA")
print(f"Écart-Type des Commandes : {ecart_type_commande:,.2f} F CFA")

print("\n--- REPARTITION PAR CATEGORIE ---")
print(df.groupby('Categorie')['Montant_Total_FCFA'].agg(['sum', 'count']))

print("\n--- TOP PRODUITS EN REVENU ---")
print(df.groupby('Produit')['Montant_Total_FCFA'].sum().sort_values(ascending=False))