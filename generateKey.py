import os, sys
import rsa
from datetime import datetime
from iteration_utilities import unique_everseen, duplicates

#--------------------------Déclaration des variables---------------------------

privkey = []
pubkey = []
listPublicKeys = []
listPrivateKeys = []

#------------------------Fonction qui implémente le stockage des clés générées dans les fichiers -------------------------------

def main():
    i = 10
    keySize = 512
    while i != 0:
        makeInAFile('RSA_key_%s_%s' % (keySize, i), keySize)
        i = i - 1
        
#--------------------------- fonction qui génère les clés publiques et privées ----------------------------------

def generateKey(keySize):

     public_key, priv_key = rsa.newkeys(1024)
     privkey.append(priv_key)
     pubkey.append(public_key)
     return (public_key, priv_key)

#-----------------------Fonction qui stocke les clés générées dans les fichiers---------------------------------------

def makeInAFile(name, keySize):
    if os.path.exists('%s_pubkey.txt' % (name)) or os.path.exists('%s_privkey.txt' % (name)):
        sys.exit(
            'WARNING: The file %s_pubkey.txt or %s_privkey.txt already exists! Use a different name or delete these files and re-run this program.' % (
            name, name))
    public_key, priv_key = generateKey(keySize)
    f = open("/home/kouam/Documents/RSA_%s/%s_pubkey.txt" % (keySize, name), 'a')
    f.write('%s' % (public_key))
    f.close

    f = open("/home/kouam/Documents/RSA_%s/%s_privkey.txt" % (keySize, name), 'a')
    f.write('%s' % (priv_key))
    f.close

#------------------------Vérification des doublons dans les fichiers de clés privées -------------------------------

def verifyDoublonsPrivateKeys(liste):

	i = 0
	while i != len(liste):
	
		result1 = str(liste[i]).replace('PrivateKey(', '')
		result = result1.replace(')', '')
		listPrivateKeys.append(result)
		i = i + 1 

	if list(duplicates(listPrivateKeys)) != None and list(duplicates(listPrivateKeys)) != []:
	
		print("Présence de doublons de clés privées \n")
		return list(set(listPrivateKeys))
		
	print("Pas de doublons")
	return listPrivateKeys
 
 #------------------------Vérification des doublons dans les fichiers de clés publiques -------------------------------   
 
def verifyDoublonsPublicKeys(liste):

	i = 0
	while i != len(liste):
	
		result1 = str(liste[i]).replace('PublicKey(', '')
		result = result1.replace(')', '')
		listPublicKeys.append(result)
		i = i + 1 
	
	if list(duplicates(listPublicKeys)) != None  and list(duplicates(listPublicKeys)) != []:

		print("Présence de doublons clés publiques")

		return list(set(listPublicKeys))

	print("Pas de doublons")
	return listPublicKeys

#--------------------------Implémentation des fonctions ---------------------------

if __name__ == '__main__':
    
    #Temps avant la génération des clés
    
    time_init = datetime.now()
    
    #génération des clés et stockage dans les fichiers
    main()
    
    #temps après la génération des clés
    time_finish = datetime.now()
    
    #Durée de la génération des clés
    duration = time_finish - time_init
    
    #Affichage de la liste des clés privées
    print("Private Key RSA : \n", privkey)
    
    #Affichage de la liste des clés publiques
    print("Public Key RSA : \n", pubkey)
    
    #Affichage de la durée de génération des clés
    print("The Key generation has duration : \n", duration)
    
    #Vérification des doublons
    print("Véification des doublons :\n \n")
    
    #Affichage de la liste définitive des clés privées après recherche des doublons. Elle est égale à la liste de départ si n'y a pas de doublons
    print(verifyDoublonsPrivateKeys(privkey), "\n")
    
    #Affichage de la liste définitive des clés publiques après recherche des doublons. Elle est égale à la liste de départ si n'y a pas de doublons
    print(verifyDoublonsPublicKeys(pubkey), "\n")
