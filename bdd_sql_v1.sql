DROP TABLE IF EXISTS possede;
DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS panier;
DROP TABLE IF EXISTS ligne_commande;
DROP TABLE IF EXISTS casque;
DROP TABLE IF EXISTS commande;
DROP TABLE IF EXISTS taille;
DROP TABLE IF EXISTS image;
DROP TABLE IF EXISTS fournisseur;
DROP TABLE IF EXISTS fabricant;
DROP TABLE IF EXISTS type_casque;
DROP TABLE IF EXISTS couleur;
DROP TABLE IF EXISTS etat;
DROP TABLE IF EXISTS user;

CREATE TABLE user(
    user_id INT AUTO_INCREMENT,
    email VARCHAR(255),
    username VARCHAR(255),
    password VARCHAR(255),
    role VARCHAR(255),
    est_actif tinyint(1),
    pseudo VARCHAR(255),    -- utile ?

    -- token_email VARCHAR(255), --validation et mdp oublié
    -- token_email_date date(),

    -- go_auth_token VARCHAR(255),
    -- go_username_token VARCHAR(255),

    PRIMARY KEY(user_id)
);

CREATE TABLE etat(
    etat_id INT AUTO_INCREMENT,
    libelle_etat VARCHAR(255),
    PRIMARY KEY(etat_id)
);

CREATE TABLE couleur(
   couleur_id INT AUTO_INCREMENT,
   libelle_couleur VARCHAR(255),
   PRIMARY KEY(couleur_id)
);

CREATE TABLE type_casque(
   type_casque_id INT AUTO_INCREMENT,
   libelle_type_casque VARCHAR(255),
   PRIMARY KEY(type_casque_id)
);

CREATE TABLE fabricant(
   fabricant_id INT AUTO_INCREMENT,
   libelle_fabricant VARCHAR(255),
   PRIMARY KEY(fabricant_id)
);

CREATE TABLE fournisseur(
   fournisseur_id INT AUTO_INCREMENT,
   libelle_fournisseur VARCHAR(255),
   PRIMARY KEY(fournisseur_id)
);

CREATE TABLE image(
   image_id INT AUTO_INCREMENT,
   url_Image VARCHAR(255),
   PRIMARY KEY(image_id)
);

CREATE TABLE taille(
   taille_id INT AUTO_INCREMENT,
   num_taille NUMERIC(7,2),
   PRIMARY KEY(taille_id)
);

CREATE TABLE commande(
    commande_id INT AUTO_INCREMENT,
    date_achat DATE,
    user_id INT,
    etat_id INT,
    PRIMARY KEY(commande_id),
    CONSTRAINT fk_commande_user
    FOREIGN KEY(user_id) REFERENCES user(user_id),
    CONSTRAINT fk_commande_etat
    FOREIGN KEY(etat_id) REFERENCES etat(etat_id)
);

CREATE TABLE casque(
   casque_id INT AUTO_INCREMENT,
   nom_casque VARCHAR(255),
   stock_casque INT,
   prix_achat_casque NUMERIC(7,2),
   date_achat_casque NUMERIC(7,2),
   description_casque VARCHAR(255),
   taille_id INT,
   image_id INT,
   fabricant_id INT,
   type_casque_id INT,
   PRIMARY KEY(casque_id),
   CONSTRAINT fk_casque_taille
   FOREIGN KEY(taille_id) REFERENCES taille(taille_id),
   CONSTRAINT fk_casque_image
   FOREIGN KEY(image_id) REFERENCES image(image_id),
   CONSTRAINT fk_casque_fabricant
   FOREIGN KEY(fabricant_id) REFERENCES fabricant(fabricant_id),
   CONSTRAINT fk_casque_type_casque
   FOREIGN KEY(type_casque_id) REFERENCES type_casque(type_casque_id)
);

CREATE TABLE ligne_commande(
    commande_id INT,
    casque_id INT,
    prix_unit_ligne_commande NUMERIC(7,2),
    quantite_ligne_commande INT,
    PRIMARY KEY(commande_id, casque_id),
    CONSTRAINT fk_ligne_commande_commande
    FOREIGN KEY(commande_id) REFERENCES commande(commande_id),
    CONSTRAINT fk_ligne_commande_casque
    FOREIGN KEY(casque_id) REFERENCES casque(casque_id)
);

CREATE TABLE panier(
    panier_id INT AUTO_INCREMENT,
    date_ajout DATE,
    user_id INT,
    casque_id INT,
    prix_unit_panier NUMERIC(7,2),
    quantite_panier INT,
    PRIMARY KEY(panier_id),
    CONSTRAINT fk_panier_user
    FOREIGN KEY(user_id) REFERENCES user(user_id),
    CONSTRAINT fk_panier_casque
    FOREIGN KEY(casque_id) REFERENCES casque(casque_id)
);

CREATE TABLE a(
   casque_id INT,
   fournisseur_id INT,
   PRIMARY KEY(casque_id, fournisseur_id),
   FOREIGN KEY(casque_id) REFERENCES casque(casque_id),
   FOREIGN KEY(fournisseur_id) REFERENCES fournisseur(fournisseur_id)
);

CREATE TABLE possede(
   casque_id INT,
   couleur_id INT,
   PRIMARY KEY(casque_id, couleur_id),
   CONSTRAINT fk_possede_casque
   FOREIGN KEY(casque_id) REFERENCES casque(casque_id),
   CONSTRAINT fk_possede_couleur
   FOREIGN KEY(couleur_id) REFERENCES couleur(couleur_id)
);

INSERT INTO user (user_id, email, username, password, role,  est_actif) VALUES
(null, 'admin@admin.fr', 'admin', 'sha256$pBGlZy6UukyHBFDH$2f089c1d26f2741b68c9218a68bfe2e25dbb069c27868a027dad03bcb3d7f69a', 'ROLE_admin', 1);
INSERT INTO user  (user_id, email, username, password, role, est_actif) VALUES
(null, 'client@client.fr', 'client', 'sha256$Q1HFT4TKRqnMhlTj$cf3c84ea646430c98d4877769c7c5d2cce1edd10c7eccd2c1f9d6114b74b81c4', 'ROLE_client',   1);
INSERT INTO user  (user_id, email, username, password, role, est_actif) VALUES
(null, 'client2@client2.fr', 'client2', 'sha256$ayiON3nJITfetaS8$0e039802d6fac2222e264f5a1e2b94b347501d040d71cfa4264cad6067cf5cf3', 'ROLE_client',   1);

SELECT * FROM user;
