-- TP04–equêtesavancées
-- si besoin recréer la BDD
-- Voir sur lr TP03
-- Listez les articles dans l’ordre alphabétique des désignations
SELECT
    *
FROM
    article
ORDER BY
    designation;

-- Listez les articles dans l’ordre des prix du plus élevé au moins élevé
SELECT
    *
FROM
    article
ORDER BY
    prix DESC;

-- Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix
-- ascendant
SELECT
    *
FROM
    article
WHERE
    designation LIKE '%boulon%'
ORDER BY
    prix;

-- Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT
    *
FROM
    article
WHERE
    designation LIKE '%sachet%';

-- Listez tous les articles dont la désignation contient le mot « sachet »
-- indépendamment de la casse !
SELECT
    *
FROM
    article
WHERE
    UPPER(designation) LIKE '%SACHET%';

-- Listez les articles avec les informations fournisseur correspondantes. Les résultats
-- doivent être triées dans l’ordre alphabétique des fournisseurs et par article du prix le
-- plus élevé au moins élevé.
SELECT
    *
FROM
    article as a
    JOIN fournisseur as f ON a.id_fou = f.id
ORDER BY
    f.nom ASC,
    a.prix DESC;

-- Listez les articles de la société « Dubois & Fils »
SELECT
    article.*
FROM
    article as a
    JOIN fournisseur as f ON a.id_fou = f.id
WHERE
    f.id = 3;

-- Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT
    f.nom,
    ROUND(AVG(a.prix), 2) as 'moyenne articles'
FROM
    article as a
    JOIN fournisseur as f ON a.id_fou = f.id
WHERE
    f.nom like 'Dubois%';

-- Calculez la moyenne des prix des articles de chaque fournisseur
SELECT
    f.nom,
    AVG(a.prix) as 'moyenne articles'
FROM
    fournisseur as f
    JOIN article as a ON a.id_fou = f.id
group BY
    f.nom;

-- Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le
-- 05/04/2019 à 12h00.
SELECT
    b.numero,
    b.date_cmde,
    b.delai
FROM
    bon as b
WHERE
    b.date_cmde BETWEEN '2019/03/01'
    AND '2019/04/05 12:00:00';

-- Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT
    DISTINCT b.numero.*
FROM
    bon as b
    JOIN compo as c ON b.id = c.id_bon
    JOIN article as a ON a.id = c.id_art
WHERE
    a.designation LIKE '%boulon%';

-- Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom
-- du fournisseur associé.
SELECT
    DISTINCT b.numero,
    f.nom
FROM
    bon as b
    JOIN compo as c ON b.id = c.id_bon
    JOIN article as a ON a.id = c.id_art
    JOIN fournisseur as f ON f.id = b.id_fou
WHERE
    a.designation LIKE '%boulon%';

-- Calculez le prix total de chaque bon de commande
SELECT
    DISTINCT b.numero,
    SUM(a.prix) as 'prix total'
FROM
    bon as b
    JOIN compo as c ON b.id = c.id_bon
    JOIN article as a ON a.id = c.id_art
GROUP BY
    b.numero;

-- Comptez le nombre d’articles de chaque bon de commande
SELECT
    b.numero,
    SUM(c.qte) as 'nombre d''articles'
FROM
    bon as b
    JOIN compo as c ON b.id = c.id_bon
GROUP BY
    b.numero;

-- Affichez les numéros de bons de commande qui contiennent plus de 25 articles et
-- affichez le nombre d’articles de chacun de ces bons de commande
SELECT
    b.numero,
    SUM(c.qte) as nb_article
FROM
    bon as b
    JOIN compo as c ON b.id = c.id_bon
    JOIN article as a ON a.id = c.id_art
GROUP BY
    b.numero
HAVING
    nb_article > 25;

-- Calculez le coût total des commandes effectuées sur le mois d’avril
SELECT
    SUM(a.prix * c.qte)
FROM
    bon
    JOIN compo as c ON bon.id = c.id_bon
    JOIN article as a ON a.id = c.id_art
WHERE
    MONTH(bon.date_cmde) = 4;

-- 3) Requêtes plus difficiles (facultatives) :

-- a. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs
-- différents (indice : réaliser une auto-jointure i.e. de la table avec elle-même)
SELECT 
    a1.designation, 
    a1.id_fou
FROM article as a1
JOIN article as a2 ON a1.designation = a2.designation
WHERE a1.id_fou != a2.id_fou;

-- j'ai une partie de la consigne, mais je pense devoir rajouter un élément.

-- b. Calculez les dépenses en commandes mois par mois (indice : utilisation des fonctions
-- MONTH et YEAR)


-- c. Sélectionnez les bons de commandes sans article (indice : utilisation de EXISTS)


-- d. Calculez le prix moyen des bons de commande par fournisseur.


-- 4) Commitezetpushez!.