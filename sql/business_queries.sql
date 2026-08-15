-- ======================================================
-- PROJET EMMA JUICES : ANALYSE DES VENTES ET DU PANIER
-- ======================================================

-- 1. Chiffre d'affaires total et volume global de ventes
SELECT 
    SUM(quantite * pu_fcfa) AS chiffre_affaires_total,
    SUM(quantite) AS volume_total_vendu,
    COUNT(DISTINCT id_vente) AS nombre_commandes,
    ROUND(SUM(quantite * pu_fcfa) / COUNT(DISTINCT id_vente), 2) AS panier_moyen_commande
FROM sales_cleaned;

-- 2. Performance par catégorie de produit (Jus vs Thé)
SELECT 
    categorie,
    SUM(quantite * pu_fcfa) AS ca_total,
    ROUND((SUM(quantite * pu_fcfa) * 100.0 / (SELECT SUM(quantite * pu_fcfa) FROM sales_cleaned)), 2) AS pct_ca,
    SUM(quantite) AS quantite_vendue
FROM sales_cleaned
GROUP BY categorie
ORDER BY ca_total DESC;

-- 3. Top Produits les plus rentables
SELECT 
    produit,
    categorie,
    SUM(quantite * pu_fcfa) AS ca_total,
    SUM(quantite) AS unites_vendues,
    ROUND(AVG(pu_fcfa), 0) AS prix_moyen
FROM sales_cleaned
GROUP BY produit, categorie
ORDER BY ca_total DESC;

-- 4. Répartition du chiffre d'affaires par Mode de Paiement
SELECT 
    mode_paiement,
    SUM(quantite * pu_fcfa) AS ca_total,
    COUNT(DISTINCT id_vente) AS nb_transactions
FROM sales_cleaned
GROUP BY mode_paiement
ORDER BY ca_total DESC;