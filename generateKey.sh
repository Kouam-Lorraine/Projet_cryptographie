#!/bin/bash

#------------------------debut Déclaration des variables------------------------------

taille=2048 #taille des clés qu'on veut générer
debut=$(date +%s) #temps en secondes avant la génération des clés

#------------------------fin Déclaration des variables------------------------------

#------------------debut Génération des clés publiques et privées---------------

for i in {1..10}
do
	#-------------------------- debut Clé de taille 512--------------------
	
	if [ $taille = 512 ]
	then
		openssl genrsa -out /home/kouam/Documents/RSA_$taille/rsaprivkey_$i.pem $taille
		
		openssl rsa -in /home/kouam/Documents/RSA_$taille/rsaprivkey_$i.pem -outform PEM -pubout -out /home/kouam/Documents/RSA_$taille/rsapubkey_$i.pem 
	fi
	
	#-------------------------- fin Clé de taille 512--------------------
	
	
	#-------------------debut clé de taille 1024----------------------------------------
	
	if [ $taille = 1024 ] 
	then
		openssl genrsa -out /home/kouam/Documents/RSA_$taille/rsaprivkey_$i.pem $taille
		
		openssl rsa -in /home/kouam/Documents/RSA_$taille/rsaprivkey_$i.pem -outform PEM -pubout -out /home/kouam/Documents/RSA_$taille/rsapubkey_$i.pem 
	fi
	
	#-------------------fin clé de taille 1024----------------------------------------
	
	#------------------------------debut clé de taille 2048-------------------
	
	if [ $taille = 2048 ]
	then
		openssl genrsa -out /home/kouam/Documents/RSA_$taille/rsaprivkey_$i.pem $taille
		
		openssl rsa -in /home/kouam/Documents/RSA_$taille/rsaprivkey_$i.pem -outform PEM -pubout -out /home/kouam/Documents/RSA_$taille/rsapubkey_$i.pem 
	fi
	
	#------------------------------fin clé de taille 2048-------------------
	
done

#------------------fin Génération des clés publiques et privées---------------

#---------------------------debut temps en secondes après la génération des clés--------------

fin=$(date +%s)

#---------------------------fin temps en secondes après la génération des clés--------------

#-------------------------------debut durée de génération des clés--------------------

duree=$(($fin - $debut))

#--------------------------- fin temps en secondes après la génération des clés--------------

#-------------------------------fin durée de génération des clés--------------------


#---------------------------début Affichage de la durée de génération des clés-------------------

echo "****************************** Temps mis **********************************"

echo " La génération des clés a durée $duree secondes"

#----------------------------------fin affichage de la durée de génération des clés-------------------

#--------------------------début de suppression des lignes contenant "BEGIN RSA PRIVATE KEY", "END RSA PRIVATE KEY", BEGIN RSA PUBLIC KEY" et "END RSA PUBLIC KEY" dans les fichiers des clés------------------------

for i in {1..10}
do

	grep -r -v -E "BEGIN RSA PRIVATE KEY|END RSA PRIVATE KEY" /home/kouam/Documents/RSA_$taille/rsaprivkey_$i.pem>/home/kouam/Documents/RSA_$taille/new_rsaprivkey_$i.pem
	
	grep -r -v -E "BEGIN PUBLIC KEY|END PUBLIC KEY" /home/kouam/Documents/RSA_$taille/rsapubkey_$i.pem >/home/kouam/Documents/RSA_$taille/new_rsapubkey_$i.pem
	
done

#--------------------------fin de suppression des lignes contenant "BEGIN RSA PRIVATE KEY", "END RSA PRIVATE KEY", BEGIN RSA PUBLIC KEY" et "END RSA PUBLIC KEY" dans les fichiers des clés------------------------

#--------------------------début Recherche des doublons------------------------

for k in {1..10}

do
	
	for j in {2..10}
	do
		
		diff -u /home/kouam/Documents/RSA_$taille/new_rsaprivkey_$k.pem /home/kouam/Documents/RSA_$taille/new_rsaprivkey_$j.pem >> /home/kouam/Documents/RSA_$taille/doublon_rsaprivkey_$taille.pem
		
		diff -u /home/kouam/Documents/RSA_$taille/new_rsapubkey_$k.pem /home/kouam/Documents/RSA_$taille/new_rsapubkey_$j.pem >> /home/kouam/Documents/RSA_$taille/doublon_rsapubkey_$taille.pem
	done

done

#--------------------------fin Recherche des doublons------------------------

#-------------------début Affichage des doublons => fichier vide si aucun doublons n'a été trouvé ------------------------------

echo "Affichage des doublons"

echo "Affichage des doublons des clés privées"

cat /home/kouam/Documents/RSA_$taille/doublon_rsaprivkey_$taille.pem

echo "Affichage des doublons des clés publiques"

cat /home/kouam/Documents/RSA_$taille/doublon_rsapubkey_$taille.pem

#-------------------fin Affichage des doublons => fichier vide si aucun doublons n'a été trouvé ------------------------------

