DROP DATABASE IF EXISTS compta; -- permet de réutiliser ce code sans devoir tout supprimer.
CREATE DATABASE compta;
USE compta;

CREATE TABLE fournisseur (
    ID int(11) PRIMARY KEY,
    NOM varchar(25) 
);
    
CREATE TABLE article (
	ID int(11) PRIMARY KEY,
    REF varchar(13),
    DESIGNATION varchar(255),
    PRIX decimal(7,2),
    ID_FOU int(11)
);

CREATE TABLE bon (
    ID int(11) PRIMARY KEY,
    NUMERO int(11),
    DATE_CMDE datetime,
    DELAI int(11),
    ID_FOU int(11)
);

CREATE TABLE compo(
    ID int(11) PRIMARY KEY AUTO_INCREMENT,
    ID_ART int(11),
    ID_BON int(11),
    QTE int(11)
);

ALTER TABLE article ADD CONSTRAINT FOREIGN KEY (ID_FOU) REFERENCES fournisseur(id);
ALTER TABLE bon ADD CONSTRAINT FOREIGN KEY (ID_FOU) REFERENCES fournisseur(id);
ALTER TABLE compo ADD CONSTRAINT FOREIGN KEY (ID_BON) REFERENCES article(id);
ALTER TABLE compo ADD CONSTRAINT FOREIGN KEY (ID_BON) REFERENCES bon(id);