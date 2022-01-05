.data # Segment de données classique
	compteur: #compteur qui permettre de compter le nbr de voyelles dans les mots
		.quad 0 
	i: # Servira pour faire comme une boucle for en C
		.quad 0 
	texte:  # Contiendra les mots passés en paramètres
		.quad 0

# Différentres phrases qui serviront à l'affichage
	ilya: # Le message pour dire il y a 
		.string "Il y a "
	singulier: # Voyelle mais sans e
		.string " voyelle\n"
	pluriel: # Voyelle mais avec un s
		.string " voyelles\n"
	erreur: # Parce qu'on ne peut pas toujours l'éviter
		.string "Il faut au moins un argument!\n"

.text # C'est là que tout commence
.global _start # On commence par le start

################################ Fonctions  qui retourneront le résultat ###################################

Cest_oui: # Fonction qui servira à renvoyer un si jamais c'est une voyelle
	mov $1, %rax # On met 1 dans rax
	ret # Et on le retourne

Cest_non:  # Fonction qui servira à renvoyer zéro si jamais ce n'est pas une voyelle
	xor %rax, %rax  # On met rax à 0
	ret # Et on le retourne

###############################################################################################################

########################################## Début de la fonction est_voyelle ###################################

est_voyelle: # Fonction pour savoir si telle lettre est une voyelle ou non

##################################################### Lettre a ##################################################

	mov $'a', %rbx  # On met a dans rbx
	cmp %rax, %rbx  # Comparaison de rax et rbx
	je Cest_oui # Si c'est égal on va à la fonction 

# Si c'est oui alors ce n'est pas non et on renvoie 1, si ça ne l'est pas alors on continue jusqu'à la fin
# Maintenant on traite le cas de si c'est sa majuscule 
	mov $'A', %rbx #rbx= A
	cmp %rax, %rbx # Petite comparaison
	je Cest_oui    #Si égal on file vers Cest_oui

##################################################### Lettre e ##################################################

	mov $'e', %rbx # rbx =e
	cmp %rax, %rbx # Comparaison
	je Cest_oui # Si égal on fonce à Cest_oui     

	mov $'E', %rbx
	cmp %rax, %rbx
	je Cest_oui     


##################################################### Lettre i ##################################################
	
	mov $'i', %rbx
	cmp %rax, %rbx
	je Cest_oui    

	mov $'I', %rbx
	cmp %rax, %rbx
	je Cest_oui   

##################################################### Lettre o ##################################################
	
	mov $'o', %rbx
	cmp %rax, %rbx
	je Cest_oui  

	mov $'O', %rbx
	cmp %rax, %rbx
	jne Cest_oui  

##################################################### Lettre u ##################################################
	
	mov $'u', %rbx
	cmp %rax, %rbx
	je Cest_oui  

	mov $'U', %rbx
	cmp %rax, %rbx
	je Cest_oui 

##################################################### Lettre y ##################################################
	
	mov $'y', %rbx
	cmp %rax, %rbx
	je Cest_oui     

	mov $'Y', %rbx
	cmp %rax, %rbx
	je Cest_non     # A ce stade si c'est pas oui c'est non

	########################################## Fin de cette fonction ###################################

	

########################################## Le vrai début ##########################################

_start:

# Vérification de la bonne utilisation du programme

	pop %rax # On dépile la pile dans rax
	cmp %rax, $2 # On compare à 2
	jge conitnue # Si c'est plus grand alors argc > 2 (Spoil: C'est ce qu'on veut)

# Si on entre ici c'est que ça a mal tourné
	mov $1, %rax 
	mov $1, %rdi
	mov $erreur, %rsi # On empile le message d'erreur
	mov $30, %rdx
	syscall                     # On dit que là ça ne va pas

# On sort de cette fonction
	mov $60, %rax
	mov $-1, %rdi
	syscall  				    #

continue:

	pop %rax # On supprime argv[0] (Le nom de la fonction)
	pop %rax # On dépile dans rax pour avoir le texte
	mov %rax, texte  # On met rax dans le texte ( Pour pouvoir utiliser rax librement )