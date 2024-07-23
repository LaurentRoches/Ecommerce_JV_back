#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: user
#------------------------------------------------------------

CREATE TABLE user(
        id_user               Int  Auto_increment  NOT NULL ,
        str_user_prenom       Varchar (255) NOT NULL ,
        str_user_nom          Varchar (255) NOT NULL ,
        str_user_tel          Varchar (255) NOT NULL ,
        str_user_password     Varchar (255) NOT NULL ,
        dtm_user_naissance    Datetime NOT NULL ,
        bln_newsletter        Boolean NOT NULL DEFAULT FALSE ,
        dtm_user_creation     Datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ,
        dtm_user_modification Datetime ,
        bln_mauvais_payeur    Boolean NOT NULL DEFAULT FALSE ,
        bln_user_verifier     Boolean NOT NULL DEFAULT FALSE ,
        id_role               Int NOT NULL ,
        str_user_email        Varchar (255) NOT NULL
    ,INDEX idx_id_role (id_role)
    ,CONSTRAINT AK_str_user_email UNIQUE(str_user_email)
    ,CONSTRAINT AK_str_user_tel UNIQUE(str_user_tel)
    ,CONSTRAINT user_PK PRIMARY KEY (id_user)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: role
#------------------------------------------------------------

CREATE TABLE role(
        id_role      Int  Auto_increment  NOT NULL ,
        str_role_nom Varchar (255) NOT NULL
    ,CONSTRAINT role_PK PRIMARY KEY (id_role)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: paiement
#------------------------------------------------------------

CREATE TABLE paiement(
        id_paiement       Int  Auto_increment  NOT NULL ,
        str_cb_numero     Varchar (255) NOT NULL ,
        str_cb_expiration Varchar (255) NOT NULL ,
        str_cb_nom        Varchar (255) NOT NULL ,
        str_cb_code_hash  Varchar (255) NOT NULL ,
        id_user           Int NOT NULL
    ,INDEX idx_id_user (id_user)
    ,CONSTRAINT paiement_PK PRIMARY KEY (id_paiement)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: adresse
#------------------------------------------------------------

CREATE TABLE adresse(
        id_adresse               Int  Auto_increment  NOT NULL ,
        str_adresse              Varchar (255) NOT NULL ,
        str_code_postale         Varchar (255) NOT NULL ,
        str_ville                Varchar (255) NOT NULL ,
        str_complementaire       Varchar (255) ,
        dtm_adresse_creation     Datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ,
        dtm_adresse_modification Datetime ,
        id_user                  Int NOT NULL
    ,INDEX idx_id_user (id_user)
    ,CONSTRAINT adresse_PK PRIMARY KEY (id_adresse)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: avis
#------------------------------------------------------------

CREATE TABLE avis(
        id_avis               Int  Auto_increment  NOT NULL ,
        txt_avis              Text NOT NULL ,
        bln_verifie           Boolean NOT NULL ,
        id_user               Int NOT NULL ,
        id_produit            Int NOT NULL ,
        int_note              Int NOT NULL ,
        dtm_user_creation     Datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ,
        dtm_user_modification Datetime 
    ,INDEX idx_id_user (id_user)
    ,INDEX idx_id_produit (id_produit)
    ,INDEX idx_int_note (int_note)
    ,CONSTRAINT avis_PK PRIMARY KEY (id_avis)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: avis_reponse
#------------------------------------------------------------

CREATE TABLE avis_reponse(
        id_avis_reponse       Int  Auto_increment  NOT NULL ,
        txt_avis              Text NOT NULL ,
        id_user               Int NOT NULL ,
        id_avis               Int NOT NULL ,
        dtm_user_creation     Datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ,
        dtm_user_modification Datetime 
    ,INDEX idx_id_user (id_user)
    ,INDEX idx_id_avis (id_avis)
    ,CONSTRAINT avis_reponse_PK PRIMARY KEY (id_avis_reponse)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: produit
#------------------------------------------------------------

CREATE TABLE produit(
        id_produit               Int  Auto_increment  NOT NULL ,
        str_produit_nom          Varchar (255) NOT NULL ,
        str_produit_resume       Varchar (255) NOT NULL ,
        txt_produit_description  Text NOT NULL ,
        dtm_produit_sortie       Datetime NOT NULL ,
        str_produit_ean          Varchar (255) NOT NULL ,
        dtm_produit_creation     Datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ,
        dtm_produit_modification Datetime ,
        id_editeur               Int NOT NULL
    ,INDEX idx_id_editeur (id_editeur)
    ,CONSTRAINT produit_PK PRIMARY KEY (id_produit)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: editeur
#------------------------------------------------------------

CREATE TABLE editeur(
        id_editeur      Int  Auto_increment  NOT NULL ,
        str_editeur_nom Varchar (255) NOT NULL
    ,CONSTRAINT editeur_PK PRIMARY KEY (id_editeur)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: plateforme
#------------------------------------------------------------

CREATE TABLE plateforme(
        id_plateforme      Int  Auto_increment  NOT NULL ,
        str_plateforme_nom Varchar (255) NOT NULL
    ,CONSTRAINT plateforme_PK PRIMARY KEY (id_plateforme)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: panier
#------------------------------------------------------------

CREATE TABLE panier(
        id_panier               Int  Auto_increment  NOT NULL ,
        dcm_panier_montant      Decimal NOT NULL ,
        dtm_panier_creation     Datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ,
        dtm_panier_modification Datetime ,
        id_user                 Int NOT NULL
    ,INDEX idx_id_user (id_user)
    ,CONSTRAINT panier_PK PRIMARY KEY (id_panier)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: produit_plateforme
#------------------------------------------------------------

CREATE TABLE produit_plateforme(
        int_stock        Int NOT NULL ,
        dcm_produit_prix Decimal NOT NULL ,
        id_produit       Int NOT NULL ,
        id_plateforme    Int NOT NULL
    ,INDEX idx_id_produit (id_produit)
    ,INDEX idx_id_plateforme (id_plateforme)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: commande
#------------------------------------------------------------

CREATE TABLE commande(
        id_commande               Int  Auto_increment  NOT NULL ,
        str_commande_numero       Varchar (255) NOT NULL ,
        dcm_commande_montant      Decimal NOT NULL ,
        id_commande_statut        Int NOT NULL ,
        dtm_commande_creation     Datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ,
        dtm_commande_modification Datetime ,
        id_adresse_livraison      Int NOT NULL ,
        id_adresse_facturation    Int NOT NULL ,
        id_user                   Int NOT NULL
    ,INDEX idx_id_user (id_user)
    ,INDEX idx_id_commande_statut (id_commande_statut)
    ,CONSTRAINT commande_PK PRIMARY KEY (id_commande)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: commande_statut
#------------------------------------------------------------

CREATE TABLE commande_statut(
        id_commande_statut      Int  Auto_increment  NOT NULL ,
        str_commande_statut_nom Varchar (255) NOT NULL
    ,CONSTRAINT commande_statut_PK PRIMARY KEY (id_commande_statut)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: panier_liste
#------------------------------------------------------------

CREATE TABLE panier_liste(
        int_quantite Int NOT NULL ,
        id_panier    Int NOT NULL ,
        id_produit   Int NOT NULL
    ,INDEX idx_id_panier (id_panier)
    ,CONSTRAINT panier_liste_Idx INDEX (id_panier,id_produit)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: produit_categorie
#------------------------------------------------------------

CREATE TABLE produit_categorie(
        id_produit   Int NOT NULL ,
        id_categorie Int NOT NULL
    ,INDEX idx_id_produit (id_produit)
    ,INDEX idx_id_categorie (id_categorie)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: categorie
#------------------------------------------------------------

CREATE TABLE categorie(
        id_categorie      Int  Auto_increment  NOT NULL ,
        str_categorie_nom Varchar (255) NOT NULL
    ,CONSTRAINT categorie_PK PRIMARY KEY (id_categorie)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: produit_classification
#------------------------------------------------------------

CREATE TABLE produit_classification(
        id_produit        Int NOT NULL ,
        id_classification Int NOT NULL
    ,INDEX idx_id_produit (id_produit)
    ,INDEX idx_id_classification (id_classification)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: classification
#------------------------------------------------------------

CREATE TABLE classification(
        id_classification      Int  Auto_increment  NOT NULL ,
        str_classification_nom Varchar (255) NOT NULL
    ,CONSTRAINT classification_PK PRIMARY KEY (id_classification)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Insert: role
#------------------------------------------------------------

INSERT INTO role (str_role_nom)
VALUES ("USER");
INSERT INTO role (str_role_nom)
VALUES ("ADMIN");
INSERT INTO role (str_role_nom)
VALUES ("EMPLOYE");


#------------------------------------------------------------
# Insert: user
#------------------------------------------------------------

INSERT INTO user (
    str_user_prenom, 
    str_user_nom, 
    str_user_tel, 
    str_user_password,
    dtm_user_naissance,
    bln_user_verifier,
    id_role,
    str_user_email
    )
VALUES (
    'Laurent',
    'ROCHES',
    '0684892151',
    "$2y$10$kzNha7EzQecz9xcQDIpd5.xomaYaHa8d5L32TK7h/xy8aQ8LqXyuu",
    '1989-05-29',
    TRUE,
    2,
    'rocheslaurent@gmail.com'
);